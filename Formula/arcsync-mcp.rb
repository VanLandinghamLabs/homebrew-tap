class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.2.0/arcsync-mcp-0.2.0-darwin-arm64.tar.gz"
      sha256 "98726bb1865d7cacdedcdf4dcac4c0a9cce32863eb9836a68cc0682a09fae924"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.2.0.tgz"
      sha256 "7cd3c99c71c45ee72450e12ea843f8a863738d222bb3a2bdc761e379a110fb90"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.2.0/arcsync-mcp-0.2.0-linux-arm64.tar.gz"
      sha256 "8a9dabd58a6336ca5bbc5f9e3d246fcb18fcdf697d7db0fe92bcfd7ed23a02e8"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.2.0/arcsync-mcp-0.2.0-linux-x64.tar.gz"
      sha256 "ddd0121b6099d60daed914b1e50fb028fa2cdceeb294565d82df9c79457093f4"
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
