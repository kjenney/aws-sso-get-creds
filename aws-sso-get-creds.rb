class AWSSSOGetCreds < Formula
  desc "Shell functions to export AWS credentials from AWS SSO"
  homepage "https://github.com/kjenney/aws-sso-get-creds"
  url "https://github.com/kjenney/aws-sso-get-creds/archive/1.0.tar.gz"
  sha256 "1d56bc86ac730ed85402293ef8234f33f8ee25e31e891cd3cbd097692939bdba"

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
