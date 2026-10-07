class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.0/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f59bcbbd95b3e659313a638b39173a396d790a44b477e2b6108452ceafd2a456"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.0/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "26a4bd42218cd189a9d951d2056c09b190a09b314d803a78cde4d4c38b703141"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.0/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fef8b27507441064ed7c899350ab5abb1d3e195fadbbc1a6b368e2d1b9227fd6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.0/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7753a41f360dd250c0ea21c0c835046eeb856bfc48e3e105cc45fbb940ee274c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ward"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ward"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ward"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ward"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
