class AwsSsoGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/homebrew-aws-sso-get-creds"
  url "https://github.com/kjenney/homebrew-aws-sso-get-creds/archive/1.0.tar.gz"
  sha256 "cc06cf806cc096d7f00caa9577befd3e368516438069d11d1388e1c46e43bf4b"

  def install
    bin.install "./aws-sso-get-creds.sh"
  end

  def caveats
    <<~EOS
      Source aws-sso-get-creds in ~/.bash_profile or ~/.bashrc to load this in
      your terminal.
      source /usr/local/bin/aws-sso-get-creds.sh
    EOS
  end

  test do
    system "false"
  end
end
