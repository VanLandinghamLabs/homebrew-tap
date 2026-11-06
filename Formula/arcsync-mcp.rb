class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.6/arcsync-mcp-0.3.6-darwin-arm64.tar.gz"
      sha256 "d512a42bee3d0488bad6262bccb719eaff519e13b16f4f6f1379b80d3b26d1b0"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.6.tgz"
      sha256 "41193471cd1a2c5082c0718c4abdfeb2beb41a0665f76a45ee95e8753546a9d2"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.6/arcsync-mcp-0.3.6-linux-arm64.tar.gz"
      sha256 "4c3e11000ab8fa08d51ee1f95f9066a2fd2f7b84131887813f84a884bd6b8842"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.6/arcsync-mcp-0.3.6-linux-x64.tar.gz"
      sha256 "751f4a52e621258d6c05473a157c116c4d7487eefbe646ea190990be8794b53a"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      system "npm", "install", *std_npm_args
      bin.install_symlink libexec.glob("bin/*")
    else
      bin.install "arcsync-mcp"
    end
  end

  test do
    request = '{"jsonrpc":"2.0","id":1,"method":"initialize","params":' \
              '{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"brew","version":"0"}}}'
    assert_match '"name":"arcsync"', pipe_output(bin/"arcsync-mcp", "#{request}\n", 0)
  end
end
