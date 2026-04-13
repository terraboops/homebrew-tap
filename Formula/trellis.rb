class Trellis < Formula
  include Language::Python::Virtualenv

  desc "Agentic pipeline platform - design agent teams that take ideas from concept to launch"
  homepage "https://github.com/terraboops/trellis"
  url "https://github.com/terraboops/trellis/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "43e59f026abda28e490a12487c604f0cb5656a57127a5d6bb5baed079951cdca"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath
    (bin/"trellis").write_env_script(libexec/"bin/trellis", PATH: "#{libexec}/bin:$PATH")
  end

  def caveats
    <<~EOS
      To get started:
        trellis init myproject
        cd myproject
        trellis serve
    EOS
  end

  test do
    assert_match "trellis", shell_output("#{bin}/trellis --help")
  end
end
