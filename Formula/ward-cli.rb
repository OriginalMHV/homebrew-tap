class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.0/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "81230d986f920794ea8bf31b90801f6a4d904c55a6373f752bf776d190c82675"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.0/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d43a6b4f5ac73b3a5addd441fb031df9271c69c3e8b249fdd5643b63439c56e7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.0/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1c7a13b9a1a978c39051190269d8005b4fbca4179d87cadc5273f1543a3b15ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.2.0/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4b6d7fccf5900bd4f0a170f2f90e7614da237e3160cc1cb6d4b940d8ea300ee6"
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
