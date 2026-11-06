class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.7/arcsync-mcp-0.3.7-darwin-arm64.tar.gz"
      sha256 "df2507308ec8337c810569081349b8b3d988cc3bfb60fe4f4f8ecec29fac990a"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.7.tgz"
      sha256 "3415b410e4c0eb2a7c4454516eb034d09e7985ebd5e8327a827936d4797b559d"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.7/arcsync-mcp-0.3.7-linux-arm64.tar.gz"
      sha256 "18e74ca2d9910a78fcfff95d762f20568d0bad3e3442236ca1893b5575693d08"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.7/arcsync-mcp-0.3.7-linux-x64.tar.gz"
      sha256 "9d1c19567b04d8bbd2f585e93ca332f3f4d7e52b9b526b638c71070467d49ef6"
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
