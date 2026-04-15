class KoBrowser < Formula
  desc "A fast, token-efficient browser for AI agents"
  homepage "https://github.com/libi/ko-browser"
  url "https://github.com/libi/ko-browser/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "3328e536ef3ce9799d7c718877ab5877a5acd9b7c91d24547388d1c07b45e6af"
  license "MIT"
  version "0.1.4"
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
