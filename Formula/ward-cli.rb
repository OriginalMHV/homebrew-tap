class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.1/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "34d8a5353f00a69c35f63154db1a35d397a4a93b7cd664d11b322cf8de06256a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.1/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d7955f992a6d466bc724a1e858928ae323dbde238a51d602c007d47a03202bd2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.1/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5289686c5229743789fde70609ffb39fb9500108eb09910f913489c272d15342"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.1/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d0761d20840bb3158f1d1a4eda97569c42f8c1cfce5d949413d899d507c2f47d"
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
