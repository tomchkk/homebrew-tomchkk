class Submarine < Formula
  desc "Navigate the murky waters of git submodules"
  homepage "https://github.com/tomchkk/submarine"
  version "0.15.0"
  url "#{homepage}/archive/v#{version}.tar.gz"
  sha256 "be3c6a01f8230d1f5819852539a88b2e1d839b3b4db480eb17ff760ce751ad13"
  license "MIT"

  def install
    system "make", "VERSION=#{version}"
    prefix.install ".env", Dir["{bin,resource,src,submarine,version}"]
  end

  test do
    system "git", "clone", "#{homepage}", "submarine-test"

    cd "submarine-test" do
      system "submarine", "install", "--all"

      expected = "tomchkk/bash-test -> submodules/tomchkk/bash-test"
      actual = shell_output("#{bin}/submarine list --installed")
      assert_match expected, actual
    end
  end
end
