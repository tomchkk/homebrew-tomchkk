class NoSubmodulesStrategy < GitDownloadStrategy
  # prevents submodules from being added by the parent strategy, so they can be
  # installed by submarine instead
  def submodules?
    false
  end
end

class TimeWarp < Formula
  desc "A MacOS Time Machine Tinkerer"
  homepage "https://github.com/tomchkk/time-warp"
  version "1.4.1"
  url "#{homepage}.git", :using => NoSubmodulesStrategy, :tag => "v#{version}"
  license "MIT"

  depends_on "submarine" => :build
  depends_on "terminal-notifier"
  depends_on "watchexec@1.17"

  def install
    system "make", "VERSION=#{version}"
    # install all dependencies
    system "submarine", "install", "--all", "--no-dev"

    # clear the services cache
    system "bin/time-warp", "services", "--flush"
    # fix the path values in the generated autoload cache
    inreplace "submodules/autoload.cache", "#{buildpath}", "#{prefix}"

    # install the app files
    prefix.install ".env", "Makefile", "time-warp", "version"
    prefix.install Dir["{bin,config,resource,src,submodules}"]
  end

  def post_install
    # warm the services cache
    system "#{opt_bin}/time-warp"
  end

  def caveats
    <<~EOS
      Time Warp can indicate its status by integrating automatically with AnyBar.
      Just install the app with:
       - `brew install --cask anybar`.

      After an update, restart the background watch process with:
       - `brew services restart time-warp`
    EOS
  end

  service do
    require_root true
    run [opt_bin/"time-warp", "watch"]
    keep_alive true
    log_path var/"log/time-warp.log"
    error_log_path var/"log/time-warp.log"
  end

  test do
    assert_match "#{version}", shell_output("#{opt_bin}/time-warp --version")
    assert_match "prod", shell_output(
      "#{opt_bin}/time-warp services --definitions @app-env"
    )
    assert_match "#{prefix}", shell_output(
      "#{opt_bin}/time-warp services --definitions @project-dir"
    )
  end
end
