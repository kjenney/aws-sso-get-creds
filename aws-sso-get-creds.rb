class AwsSsoGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/homebrew-aws-sso-get-creds"
  url "https://github.com/kjenney/homebrew-aws-sso-get-creds/archive/1.2.tar.gz"
  sha256 "97a49304d9dec7e40097bd4162b105fd9f6ce6fcf4f84352aaac95a7b24f087f"

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
