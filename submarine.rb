class Submarine < Formula
  desc "Navigate the murky waters of git submodules"
  homepage "https://github.com/tomchkk/submarine"
  version "0.16.0"
  url "#{homepage}/archive/v#{version}.tar.gz"
  sha256 "23a9269c8f8dd76d11a88f2919cdcec8657e7b4fc6945f37cccf5aaf273e945d"
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
