class RecallCli < Formula
  desc "TUI session browser for GitHub Copilot CLI, Claude Code, and other coding tools"
  homepage "https://github.com/OriginalMHV/recall"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/recall/releases/download/v0.1.1/recall-cli-aarch64-apple-darwin.tar.xz"
      sha256 "0f4a9ce56c7e3398c3dcddb6819cb74e3d60bf06ac289c6f4fd1f930e10168ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/recall/releases/download/v0.1.1/recall-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a4b171d4fe5a270b4b5d1f1c362a5bf6198a45e94ffa2ce5233e965ca60ab1bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OriginalMHV/recall/releases/download/v0.1.1/recall-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "904f6b7c2a9df4df5fc215e99f4fedcc7823c9037e0b95d97b6333d6595789fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OriginalMHV/recall/releases/download/v0.1.1/recall-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "272b7886483a860ef438b48a8b49cdef466455681f7d413615f4eea8cd70dbf4"
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
    bin.install "recall" if OS.mac? && Hardware::CPU.arm?
    bin.install "recall" if OS.mac? && Hardware::CPU.intel?
    bin.install "recall" if OS.linux? && Hardware::CPU.arm?
    bin.install "recall" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
