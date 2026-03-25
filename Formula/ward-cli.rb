class WardCli < Formula
  desc "GitHub repository management for developers. Plan, apply, verify."
  homepage "https://github.com/OriginalMHV/Ward"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.3.0/ward-cli-aarch64-apple-darwin.tar.xz"
      sha256 "decc311e1750885514095867dc39b3752d394f3d41e82e7f26aa9f6425b67838"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.3.0/ward-cli-x86_64-apple-darwin.tar.xz"
      sha256 "eecdb409881f274dbc41c54a692397b70ffeb65fb8cad15a5c67c3438be99faa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.3.0/ward-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cc728b33900997b350683b112343fe4d93b6e0a8a0cc0b20d8f7d28b4b61f35a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/Ward/releases/download/v0.3.0/ward-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df043456b5519d6eee55adec4c9b027f03f7a435bbf0508074e357ff2a911b0a"
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
