class AwsSsoGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/homebrew-aws-sso-get-creds"
  url "https://github.com/kjenney/homebrew-aws-sso-get-creds/archive/1.0.tar.gz"
  sha256 "56a6cd1ef8174a27cb5fea394163814bc126ebdc9e8acf1ca4f7e61d9148b7a0"

  def install
    bin.install "./bin/aws-sso-get-creds.sh"
  end

  def caveats
    <<~EOS
      Source aws-sso-get-creds in ~/.bash_profile or ~/.bashrc to load this in
      your terminal.
      source /opt/homebrew/bin/aws-sso-get-creds.sh
    EOS
  end

  test do
    system "false"
  end
end
