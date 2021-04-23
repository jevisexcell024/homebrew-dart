class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.12.4"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "21df868f61389e9410c6893d4afffd6ad3dedb84a4770c206ebc6ee8d302c544"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "479fd97114f8dc2e01a29bcf2c9fb46ff2c137390f6fe9f998a8d979604d33fd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c12ef383c50262a3891e6731068b7b982540e6c874dbc31be0fd4c3e0517bd41"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e31b619e4de778ed95b00f5af92b02c9aadc5db34245823b6faedf10ac014121"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c2e5a0d360766cbea648e63f49a8a4edb5bb64e736edb4274530ed76110caf68"
    end
  end

  head do
    version "2.14.0-32.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-32.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "98611eedcde0143492527ee1a20017b2ffa60b03447740a3e6de796f3f7f0a5c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-32.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c021a87331e375d966476f88c60a7a229092d8cd0fdbccd457f9e2203de9612a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-32.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "17d09665ba46b1e51854765ac8aaabf7d49e6c6b89a46438b2ff8fabfe85fc3c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-32.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "993123dd4c8b36393ab797af1463be0d09ae26630489ab3a2e0bdc83bbe5f088"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-32.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5c2fd4d348555a972ac5fa8f69fe71b92b12fd28b2bcbec8299771b5de61796f"
      end
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
      Please note the path to the Dart SDK:
        #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
