class Incubator < Formula
  include Language::Python::Virtualenv

  desc "A team of Claude agents that takes an idea from research to release"
  homepage "https://github.com/terraboops/incubator"
  url "https://github.com/terraboops/incubator/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "bc416bbe036b4d5c078d0aca1559ddc8f494ab6ec38ccf0b5dbb36d9d41dfd66"
  license "MIT"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Use pip directly (without --no-deps) so all dependencies resolve
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath
    (bin/"incubator").write_env_script(libexec/"bin/incubator", PATH: "#{libexec}/bin:$PATH")
  end

  def caveats
    <<~EOS
      To get started:
        incubator init myproject
        cd myproject
        incubator serve

      Configure your .env file with Telegram credentials for
      human-in-the-loop approval gates. See:
        https://github.com/terraboops/incubator#configuration
    EOS
  end

  test do
    assert_match "incubator", shell_output("#{bin}/incubator --help")
  end
end
