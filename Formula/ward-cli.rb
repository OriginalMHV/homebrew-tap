class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.5.0/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "12e3653543da8e68a562d82d259a4766c4722bb69454ce27427dfcd488a5383d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.5.0/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "da709dfab0ff388a48d0401daecf4e0a951fc8de90ed65055ae5b47e49bfb52c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.5.0/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ec35fa47fc8c15201acddf0ceb781aed0a776e9ec74eb61708c8649eff5a6eb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.5.0/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "53eb683087cba856cf0d7a59b1ee32bf25f6af58a067a7ce0e9d2d3ab5da640b"
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
