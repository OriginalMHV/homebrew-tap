class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.1/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "cb9fcc88fbfcca7946068469332cb30c106de59fe229fc3ad865b59f2189af86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.1/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bc959be8bc49c90514653bcdcddf51b6a6bdbcfe7e705ce9d569ee0e9a2e1409"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.1/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7514a99442febf49280bc04d46a552d7a0df5b09d2a9158d3975775b816d7d46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.1/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11d87886a13b7ff3c1b32689de0c797a80476b77bb204f8aaf367956f43c7dd6"
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
    bin.install "ward" if OS.mac? && Hardware::CPU.arm?
    bin.install "ward" if OS.mac? && Hardware::CPU.intel?
    bin.install "ward" if OS.linux? && Hardware::CPU.arm?
    bin.install "ward" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
