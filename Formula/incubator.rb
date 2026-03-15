class Incubator < Formula
  include Language::Python::Virtualenv

  desc "A team of Claude agents that takes an idea from research to release"
  homepage "https://github.com/terraboops/incubator"
  url "https://github.com/terraboops/incubator/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "d7502535e2325bfac4a2c1e6096effdd59a2cbca2188f124310ab4192ab92de0"
  license "MIT"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install_and_link buildpath
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
