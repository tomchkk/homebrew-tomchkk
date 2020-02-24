# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class TimeWarp < Formula
  desc ""
  homepage ""
  url "https://gitlab.com/tomchkk-public/time-warp/-/archive/v0.0.2/time-warp-v0.0.2.tar.gz"
  sha256 "4f5599deeca4fa8ed6a71f4e0fd35da2800303e5a000d6767d6235af77f04512"

  def install
	bin.install "time-warp"
  end
end
