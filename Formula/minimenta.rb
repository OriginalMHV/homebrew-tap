class Minimenta < Formula
  desc "Minuere impedimenta: an interactive disk usage analyzer for the terminal"
  homepage "https://github.com/OriginalMHV/minimenta"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.2.0/minimenta-aarch64-apple-darwin.tar.xz"
      sha256 "40f11287f8f146139112a1d031a4b48367ba259fd40fbf2eb6e8d27ea50ae11b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.2.0/minimenta-x86_64-apple-darwin.tar.xz"
      sha256 "493737b8d998ed322fafe1ccd8cd52e8a712ddd53ebc2563d349f1a451636fb2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.2.0/minimenta-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "468251deefd5eecacbaec646ba108cfcc41956fc44ca0eafe3d82a42a3b7f00e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.2.0/minimenta-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "962c8f9a7635d4c3a9fcdc925cbd51e414aea6a89b0811a0726cf54245c2e331"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "minimenta", "mm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "minimenta", "mm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "minimenta", "mm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "minimenta", "mm"
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
