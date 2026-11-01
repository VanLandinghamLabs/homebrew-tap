class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.0/arcsync-mcp-0.3.0-darwin-arm64.tar.gz"
      sha256 "be279fad9b0e13d58445a0dd29019397b6d521dab29778b6157d32507ca9a7e0"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.0.tgz"
      sha256 "dc4eb96f21029c29b9552a5821b4c1ff705a729bcb62bc59d76dbd47e04fd34d"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.0/arcsync-mcp-0.3.0-linux-arm64.tar.gz"
      sha256 "5966821c3822d68706ff442cf573833f0caa2476d11489e219ea6609aba17977"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.0/arcsync-mcp-0.3.0-linux-x64.tar.gz"
      sha256 "fb6f0cc602e41c776c2e43b191f508eb403c4f679da4e924b16c2edc90a155b3"
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
