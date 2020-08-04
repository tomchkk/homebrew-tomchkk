# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class TestProject < Formula
  desc ""
  homepage ""
  url "https://gitlab.com/tomchkk-public/test-project/-/archive/v1.0.1/test-project-v1.0.1.tar.gz"
  sha256 "1761338ec2f1463a6151a7a98bacaed47f731da9d03a2f3dc3c864b38dc65176"
  license ""

  def install
    system "make"

    bin.install Dir["test-output/*"]
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test test-project`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
