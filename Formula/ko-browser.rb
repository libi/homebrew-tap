class KoBrowser < Formula
  desc "A fast, token-efficient browser for AI agents"
  homepage "https://github.com/libi/ko-browser"
  url "https://github.com/libi/ko-browser/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "dc5f42a1fc29d23c25409540cfa4676b97fcacdf221a33a3f7860714acf43749"
  license "MIT"
  version "0.1.3"
  head "https://github.com/libi/ko-browser.git", branch: "main"

  depends_on "go" => :build
  depends_on "pkgconf" => :build
  depends_on "tesseract"

  def install
    ENV["CGO_ENABLED"] = "1"

    ldflags = %W[
      -s -w
      -X github.com/libi/ko-browser/cmd.version=#{version}
      -X github.com/libi/ko-browser/cmd.commit=homebrew
      -X github.com/libi/ko-browser/cmd.date=homebrew
    ]

    system "go", "build", *std_go_args(output: bin/"kbr", ldflags: ldflags), "-tags=ocr", "./cmd/kbr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kbr version")
  end
end
