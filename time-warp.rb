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
  version "1.0.2"
  url "#{homepage}.git", :using => NoSubmodulesStrategy, :tag => "v#{version}"
  license "MIT"

  depends_on "submarine" => :build
  depends_on "terminal-notifier"
  depends_on "watchexec"

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
       - `brew cask install anybar`.

      After updating restart the background watch process with:
       - `brew services restart time-warp`
    EOS
  end

  plist_options :startup => true

  def plist
    <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/time-warp</string>
          <string>watch</string>
        </array>
        <key>StandardOutPath</key>
        <string>#{var}/log/time-warp.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/time-warp.log</string>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    EOS
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
