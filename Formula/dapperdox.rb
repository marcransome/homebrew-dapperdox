class Dapperdox < Formula
  desc "Beautiful, integrated, OpenAPI documentation"
  homepage "http://dapperdox.io"
  url "https://github.com/DapperDox/dapperdox/archive/v1.1.1.tar.gz"
  sha256 "fa207e27929c2a65a81ad241bb51471835c90236ed7720db16de622d9e9379d7"

  depends_on "go" => :build

  # patch the default assets path to permit assets to be installed in /usr/local/share
  patch :DATA

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/DapperDox/dapperdox").install buildpath.children

    cd "src/github.com/DapperDox/dapperdox" do
      system "go", "get"
      system "go", "build", "-o", bin/"dapperdox"
      prefix.install_metafiles
      (pkgshare/"assets").install Dir["assets/*"]
      (pkgshare/"examples").install Dir["examples/*"]
    end
  end

  test do
    assert (bin/"dapperdox").exist?
  end
end

__END__
diff --git a/config/config.go b/config/config.go
index affc6a7..0b96721 100644
--- a/config/config.go
+++ b/config/config.go
@@ -39,7 +39,7 @@ func Get() (*config, error) {
 	cfg = &config{
 		BindAddr:         "localhost:3123",
 		SpecDir:          "spec",
-		DefaultAssetsDir: "assets",
+		DefaultAssetsDir: "/usr/local/share/dapperdox/assets",
 		LogLevel:         "info",
 		SiteURL:          "http://localhost:3123/",
 		ShowAssets:       false,
