get_sso_session_expiration() {
        epoch=0
        json_files=$(find ~/.aws/sso/cache -type f -name "*.json")
        if [ ! -z "$json_files" ]; then
                epoch=$(aws configure get sso_start_url --profile $1 | xargs -I {} grep -h {} ~/.aws/sso/cache/*.json | jq .expiresAt | xargs -I {} sh -c 'TZ="UTC" date -j -f "%Y-%m-%dT%H:%M:%S" "+%s" $1 2>/dev/null' -- {} | head -n 1)
        fi
        echo $epoch
}

# Check if a passed epoch is in the past
is_epoch_in_past() {
	current_time=$(date +%s)
	epoch_time=$1
	if [ $current_time -ge $epoch_time ]; then echo "true"; else echo "false"; fi
}

do_we_have_a_session() {
	aws sts get-caller-identity --profile $1 > /dev/null 2>&1
	if [ "$?" = 0 ]; then echo "true"; else echo "false"; fi
}

do_we_have_a_valid_session() {
	if [[ $(do_we_have_a_session $2) = "true" && $(is_epoch_in_past $1) = "false" ]]; then echo "true"; else echo "false"; fi
}

# Cleanup sessions older than a day
cleanup_old_sso_cache() {
	find ~/.aws/sso/cache/ -type f -mtime +1 -delete
}

combine_aws_profiles() {
	cat ~/.aws/config-* > ~/.aws/config
}

# When a profile is passed by name check to make sure it exists
check_profile() {
	aws configure list-profiles | grep $1 > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "Invalid profile $1"
		False
	else
		True
	fi
}

aws-sso-get-creds() {
	combine_aws_profiles
	cleanup_old_sso_cache
	if [ -z $1 ]; then
		profiles=($(aws configure list-profiles))
		echo "Available profiles:"
		for i in "${!profiles[@]}"; do
  			echo "  ${i}. ${profiles[$i]}"
		done
		read -p "Select a profile: " profile_number
		if [[ ! "${!profiles[@]}" =~ "${profile_number}" ]]; then
  			echo "Invalid profile."
			exit 1
	   	else
			profile="${profiles[$profile_number]}"
		fi
	else
		profile="$1"
	fi
	if check_profile $profile; then
		aws configure get region --profile $profile > /dev/null 2>&1
		region=$(aws configure get region --profile $profile)
		export AWS_DEFAULT_REGION=$region
		expiration_epoch=$(get_sso_session_expiration $profile)
		if [ $(do_we_have_a_valid_session $expiration_epoch $profile) = "false" ]; then
			echo "Refreshing session"
			aws sso login --profile $profile > /dev/null 2>&1
		else
			echo "Session already present"
		fi
		eval $(aws-sso-creds export -p $profile)
	fi
}

_aws_sso_get_creds_completions()
{
  COMPREPLY=($(compgen -W "$(aws configure list-profiles)" -- "${COMP_WORDS[1]}"))
}

complete -F _aws_sso_get_creds_completions aws-sso-get-creds
