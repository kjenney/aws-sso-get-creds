class AwsSsoGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/homebrew-aws-sso-get-creds"
  url "https://github.com/kjenney/homebrew-aws-sso-get-creds/archive/1.2.tar.gz"
  sha256 "c19eef1718ce5fa1ef2a79dda8dbaadbc67cc83739bd2bf33a3da1510db3e05a"

  depends_on "aws-sso-creds"
  
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
