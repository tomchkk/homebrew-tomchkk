# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class TimeWarp < Formula
  desc ""
  homepage ""
  url "https://gitlab.com/tomchkk-public/time-warp/-/archive/v0.0.1/time-warp-v0.0.1.tar.gz"
  sha256 "3ca8e7ea6d4599a6537f338e3cd55d34c4f5d76253218727c2e75bf58e788491"

  def install
	bin.install "index"
  end
end
