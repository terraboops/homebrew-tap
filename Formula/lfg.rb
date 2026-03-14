class Lfg < Formula
  desc "WoW-inspired raid frames on a 64x64 LED panel for monitoring coding agents"
  homepage "https://github.com/terraboops/lfg"
  url "https://github.com/terraboops/lfg.git", tag: "v0.1.0"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      lfg requires an iDotMatrix 64x64 LED panel connected via Bluetooth.
      The panel is auto-discovered by scanning for BLE devices named IDM-*.

      To run without hardware (HTTP-only mode for testing):
        lfg --no-ble

      To configure IDE hooks, see:
        https://github.com/terraboops/lfg#configure-hooks
    EOS
  end

  test do
    # Verify the binary runs and shows help
    assert_match "iDotMatrix Raid Frames", shell_output("#{bin}/lfg --help")
  end
end
