# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-140.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "658e0c7df99db0aaa8c90de59bbea65c96ca01e0458b13b0c8afb03ed1a8964a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "0c1d4927486c5f314ad97fc1f8d2b730e064d2e902d5931cbcf95669454f3337"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "28d29d228a7ba6bf66c75c0d11fcdb49fe4c5e2d468dc8a8b226134d577d6350"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1f6bc8b3380c09561fa1cf50943b359a882e2bfe4179dcf1ae10f198b1b15df1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fde6dc0c32429e05d336d4ea8a23410e914b88d1ac2a19384ba613ef51f2817b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bb5cac7c5bd74e69d2a854e5a41c1f38d2a0f5ee64cafc44c561522a9f568355"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "304ecad745b2e558be5951e6dd54b42a8ab84a8f3b6c7667258404318edd9db3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b254b3f2987bdf7ea2b982855642cbea9b96e8973307cabf369ef312d0b38ab2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3ebf6ba4065ec941bb3b2e82118ae06fce34125ce6f8289e633c4b67a56cbcad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "423b1725de2c4ec779b16da7dca7f338c4c4557803a74ae70a8382551abe3e65"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19684c1615b2070a6933972809ed61f3f236fc42829c77fa19737dd2e8b7b202"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "65e821835cf1eed37cbe53d7e18a9e81e3fcb13ceaabaf7a6fe09fff9dae3160"
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
