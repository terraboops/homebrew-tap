class Declaude < Formula
  desc "De-AI your text locally on Apple Silicon via MLX (Lynote + Humaneyes)"
  homepage "https://github.com/terraboops/declaude"
  url "https://github.com/terraboops/declaude/releases/download/v0.1.0/declaude-macos-arm64"
  sha256 "d8f4d19b1f223dcf48e4b35f1aa99f4f579ee267d2a036b5484964317e5f46a0"
  version "0.1.0"
  license "MIT"

  depends_on arch: :arm64 # MLX requires Apple Silicon
  depends_on :macos

  def install
    bin.install "declaude-macos-arm64" => "declaude"
  end

  test do
    assert_path_exists bin/"declaude"
  end
end
