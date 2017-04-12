class Dapperdox < Formula
  desc "Beautiful, integrated, OpenAPI documentation"
  homepage "http://dapperdox.io"
  url "https://github.com/DapperDox/dapperdox/archive/v1.1.1.tar.gz"
  sha256 "fa207e27929c2a65a81ad241bb51471835c90236ed7720db16de622d9e9379d7"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/DapperDox/dapperdox").install buildpath.children

    cd "src/github.com/DapperDox/dapperdox" do
      system "go", "get"
      system "go", "build", "-o", bin/"dapperdox"
      prefix.install_metafiles
      (pkgshare/"examples").install Dir["examples/*"]
    end
  end

  test do
    assert (bin/"dapperdox").exist?
  end
end
