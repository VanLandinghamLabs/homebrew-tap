class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.16/arcsync-mcp-0.3.16-darwin-arm64.tar.gz"
      sha256 "3962e2195908378f7a56f856c048ed141aebf0298f15c97af2042d6c6225d8b4"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.16.tgz"
      sha256 "a9de18bb758b0b8a26d9138808b8408ad11c65d866c4fd7862600c896b3e38f0"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.16/arcsync-mcp-0.3.16-linux-arm64.tar.gz"
      sha256 "760da5bd3e99abbed01e6391da453bf9de53a31a92f7a19a62f9a92f72380389"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.16/arcsync-mcp-0.3.16-linux-x64.tar.gz"
      sha256 "8572ce27b2dcd0078a58eb1029388908a09506946f8682bcc3cbc834287f1a84"
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
