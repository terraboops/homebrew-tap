class Trellis < Formula
  include Language::Python::Virtualenv

  desc "Agentic pipeline platform — design agent teams that take ideas from concept to launch"
  homepage "https://github.com/terraboops/trellis"
  url "https://github.com/terraboops/trellis/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "33e1e7fbb9fd35d195719d33cd2c5e74aa22b27a095dbd603861241efe4827be"
  license "Apache-2.0"

  depends_on "python@3.12"
  depends_on "rust" => :build  # cryptography requires Rust to build from source

  skip_clean "libexec"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Build cryptography from source so Mach-O headers have room for
    # Homebrew's dylib ID relocation (pre-built wheels have headers
    # that are too small, causing "Failed changing dylib ID" errors).
    system libexec/"bin/python", "-m", "pip", "install",
           "--no-cache-dir", "--no-binary", "cryptography", buildpath
    (bin/"trellis").write_env_script(libexec/"bin/trellis", PATH: "#{libexec}/bin:$PATH")
  end

  def caveats
    <<~EOS
      To get started:
        trellis init myproject
        cd myproject
        trellis serve

      Configure your .env file with Telegram credentials for
      human-in-the-loop approval gates. See:
        https://github.com/terraboops/trellis#configuration
    EOS
  end

  test do
    assert_match "trellis", shell_output("#{bin}/trellis --help")
  end
end
