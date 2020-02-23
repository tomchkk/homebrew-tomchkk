# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class TimeWarp < Formula
  desc ""
  homepage ""
  url "https://gitlab.com/tomchkk-private/projects/time-warp/-/archive/v0.0.1/time-warp-v0.0.1.tar.gz"
  sha256 "35c60901a15b39c572a41a3f9d0215476bed5341f73c3b3371e8df29e697aa89"

  # depends_on "cmake" => :build

  def install
	bin.install "index"
  end
end
