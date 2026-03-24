class Trellis < Formula
  include Language::Python::Virtualenv

  desc "Agentic pipeline platform — design agent teams that take ideas from concept to launch"
  homepage "https://github.com/terraboops/trellis"
  url "https://github.com/terraboops/trellis/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "ec3c3304778eb54971d3bf354f590e0d5b972b8592fe9d4debe86daaf5bca115"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Use pip directly (without --no-deps) so all dependencies resolve
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath
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
