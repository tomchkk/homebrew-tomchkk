class Submarine < Formula
  desc "Navigate the murky waters of git submodules"
  homepage "https://github.com/tomchkk/submarine"
  version "1.2.0"
  url "#{homepage}/archive/v#{version}.tar.gz"
  sha256 "b7b24a8748ee5d21e2d88f1205a8be42e054054cf13189685250ad01403e83e4"
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
