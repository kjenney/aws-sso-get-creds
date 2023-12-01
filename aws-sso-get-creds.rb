class AwsSsoGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/homebrew-aws-sso-get-creds"
  url "https://github.com/kjenney/homebrew-aws-sso-get-creds/archive/1.1.tar.gz"
  sha256 "776dacb8b47696e3fefc03fc3a57bb892204f323da0d81abfc56cfbc8393fcb3"

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
