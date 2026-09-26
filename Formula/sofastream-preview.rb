class SofastreamPreview < Formula
  desc "Twitch on Apple TV from a macOS terminal (development)"
  homepage "https://github.com/TheDutchSmoke/sofastream"
  url "https://github.com/TheDutchSmoke/sofastream/archive/refs/tags/v0.2.0-dev.1.tar.gz"
  version "0.2.0-dev.1"
  sha256 "05e1dbf44ffb8a64c2ba03071f88a0250193df19e454d9d776f76242303767bc"
  license "MIT"

  depends_on :macos
  depends_on "fzf"
  depends_on "node"
  depends_on "python@3.14"
  depends_on "streamlink"
  depends_on "uv"

  def install
    libexec.install "app", "bin", "VERSION"
    ENV["UV_CACHE_DIR"] = buildpath/"uv-cache"
    ENV["npm_config_cache"] = buildpath/"npm-cache"
    system Formula["uv"].opt_bin/"uv", "venv", "--python",
           Formula["python@3.14"].opt_bin/"python3.14", libexec/"remote-venv"
    system Formula["uv"].opt_bin/"uv", "pip", "install", "--python",
           libexec/"remote-venv/bin/python", "-r", libexec/"app/remote-requirements.txt"
    system Formula["node"].opt_bin/"npm", "ci", "--prefix", libexec/"app/gui-importer",
           "--omit=dev", "--no-audit", "--no-fund"
    bin.install_symlink libexec/"bin/tv-dev" => "tv-dev"
    bin.install_symlink libexec/"bin/tv-dev" => "sofastream@dev"
  end

  def caveats
    <<~EOS
      Start with: tv-dev
      VLC on Apple TV needs Remote Playback enabled.
      Pair automatic wake/app launch with: tv-dev pair
      Pairing displays a code on the TV; do it when the TV is available.
      Installation does not contact or change your Apple TV.
    EOS
  end

  test do
    assert_match "SofaStream", shell_output("#{bin}/tv-dev --version")
    assert_match "Twitch", shell_output("#{bin}/tv-dev --help")
    system libexec/"remote-venv/bin/python", "-c", "import pyatv"
    system Formula["node"].opt_bin/"node", "-e",
           "require('#{libexec}/app/gui-importer/node_modules/classic-level')"
  end
end
