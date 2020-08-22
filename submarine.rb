class Submarine < Formula
  desc "Navigate the murky waters of git submodules"
  homepage "https://github.com/tomchkk/submarine"
  version "0.15.1"
  url "#{homepage}/archive/v#{version}.tar.gz"
  sha256 "47b58ca83f0547c68ab7ded8aa721ab62e2ae12c85e67b78cfe0f6f93dbec250"
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
