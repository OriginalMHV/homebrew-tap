class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.4.2/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d5ae4f22958c3c711f01e84648486206cb88e6b08811bd48940372b2e2a154a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.4.2/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "74e9943e84f510ccd03b689389d4bcee6411ccdf1c1124ba888dd78cef586a61"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.4.2/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "976d54f836013ff36df21aecc6ef6c87c7225c551eb8bfda11403051aa924505"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.4.2/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d68efc5cc2ff15d604337614d91622637649bb1dc37e039264d78223cd86488d"
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
