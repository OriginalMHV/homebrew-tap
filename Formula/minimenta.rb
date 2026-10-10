class Minimenta < Formula
  desc "Minuere impedimenta: an interactive disk usage analyzer for the terminal"
  homepage "https://github.com/OriginalMHV/minimenta"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.1.0/minimenta-aarch64-apple-darwin.tar.xz"
      sha256 "e9535fb7ddbbb2c450495a403473df25f28caae47789760826b7f3b201b81cbd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.1.0/minimenta-x86_64-apple-darwin.tar.xz"
      sha256 "cb74e37dfefb2b78a9d6531da4c0685cf0b9070453117629072cd35974620b02"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.1.0/minimenta-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "40b9d67f3bf7977694c7c846cac76484317eda348c9230778cc1d359c608bd2c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/minimenta/releases/download/v0.1.0/minimenta-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "408001dc6ff70f8b87866a56df332c85af7d18ba98f1a1938680955a1c64962f"
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
