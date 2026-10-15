class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.2/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "bb3c53fd44d5ae58996b060cb74b22decb865e18649a4e974c054be53af56799"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.2/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "dc420b30184b01969b78fb75d54cc4533218b8fbea54a00c8f2c6a9e12f6ad8f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.2/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0d7fc48ae51fc9864cd43db01345de6ab8643ad58f8de7a1d80b07d260d9558e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.6.2/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0bbcd4b7ff48ff09ca7f68cbf97196bc2d6ff7c49d80857d9063a85d06c83a6a"
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
