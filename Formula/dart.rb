# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-196.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7c9185f8593eb044a85829b32d95432e02f1f56c95d68e0e5b5beabdd8b0403c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2166c2b3b389f630c0e77db277e8cb238cd3f056701a781094d82c1b4061bbbe"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4a4fe21fa7c2ac239462660576d06ad2c0e1ed1e90473eb465868594b1f6bcf7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7cf89e504c00e091880cf3f941f7fc5b9188082de243283851edb686897bdfb3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "499da256a4cb904e204afa3f23494afd390f2d6273f6fe4357774df0ec25e507"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-196.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fcc8ec15dbd4462b4937db5b47e323da1c339ddf161c6a4d2a5a5d78fff220cd"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3a17b8e5876ef4d2ef391b9c5ed041a3c3ef809fd83018d6881e19612bbee2f5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c6d4437d2a166738eba640ecc7d436de67975dcc3a51d985dab8f109cdeb6bf9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "43a60e3a15a52fd584b0eddd235f0afeffed50f6e15a56f4ad74d83ee8fb5943"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6e5f39f9e7df0720a6146dfe4da6047180d278f706fb2afd840b51b887978d16"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4e0ce122acc157d3177c0911c79ec25560d6465d8adc17a4de10d824aa14d0de"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "11a6e8ee6f0f449fb1f1657cb35acea3f75234de02c735fd06fc61ccb6dfd1eb"
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
