class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.15/arcsync-mcp-0.3.15-darwin-arm64.tar.gz"
      sha256 "4633841292a0a9514dbf904819436aa5f0a5aa89966befdff718d3a57ec6317c"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.15.tgz"
      sha256 "0878365f0089542e979ca0e92123fdfdf76cf54643e13794ebaf830cbd64e07d"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.15/arcsync-mcp-0.3.15-linux-arm64.tar.gz"
      sha256 "b99f2b0ad30183e810e14dfbe4b70874ed81473c69a3d0d69131e7856815d529"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.15/arcsync-mcp-0.3.15-linux-x64.tar.gz"
      sha256 "af2aa7bf48c94090097df1656f84a38930ad757354977f021c6e2340d5caaf50"
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
