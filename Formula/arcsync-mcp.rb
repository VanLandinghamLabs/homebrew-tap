class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.12/arcsync-mcp-0.3.12-darwin-arm64.tar.gz"
      sha256 "48ee7724647bfde410ae3ca5fbb75b100c942c70b5798cc22daeadedb2bab5f3"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.12.tgz"
      sha256 "8d0266e88fa619a6c74eb13220c4035367510ce6610ecdc12162c8f717353659"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.12/arcsync-mcp-0.3.12-linux-arm64.tar.gz"
      sha256 "703129dc8915b69d559d7daa47c1dce8b94c80019c6978edabc3c4a77ced89f8"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.12/arcsync-mcp-0.3.12-linux-x64.tar.gz"
      sha256 "32502199b92c0b6322d5943e094aec93200b83915299329dc135691acd83ae12"
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
