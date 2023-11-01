class AwsSsoGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/homebrew-aws-sso-get-creds"
  url "https://github.com/kjenney/homebrew-aws-sso-get-creds/archive/1.0.tar.gz"
  sha256 "12843cca35b67524f2ed462081839b8df523f25abbb354180e34c252edc8c46a"

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
