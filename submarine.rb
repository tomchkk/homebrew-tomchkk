class Submarine < Formula
  desc "Navigate the murky waters of git submodules"
  homepage "https://github.com/tomchkk/submarine"
  version "1.2.1"
  url "#{homepage}/archive/v#{version}.tar.gz"
  sha256 "da12f9f9af1a0a7d81f1002d069af7c2fda93500022d8835e425ff163f7c0678"
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
