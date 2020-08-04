# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class TestProject < Formula
  desc ""
  homepage ""
  url "https://gitlab.com/tomchkk-public/test-project/-/archive/v1.0.0/test-project-v1.0.0.tar.gz"
  sha256 "b61735c96f2dcbcc32ef0f0314f9da1305ab806fc11ed0bd72b4d94e47dacbe0"
  license ""

  # depends_on "cmake" => :build

  def install
    system "touch", "test-empty"
    bin.install "test-empty"

    system "make", "all"
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
