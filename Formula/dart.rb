# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-178.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "522dab5540acb5ee51886c5424496dff74053ba30886d1e0fd26389c07c47fdb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c76073a2d392d9da800df2ed4d15201007ba8729abd5fbaf7f1743a624d667b6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cf723dd277dce968d916d0b59a78491d75d46512c34b8715953a8ed84260f134"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f48265262f26cc47f37f3720caf0f923b47e9d06a597494f2724f77b0ea0a9fa"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "806b6b5210fe0f51c5a559411dcb65a2431e83779f2ab36d902c7141198eef46"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "444a74dd9174fd1cdd88e0a523de2d642f34c51854eff772ffe830ed8bbfca32"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "65f00ed58e635574fe69708644c65f2a938034ffd424832cd0a73ec5d63c304c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5bbbfd94db56131a5ffbbe106f7d3b15c8bc3436fbf8aaaef32cf28131e1d20c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b50f0523eb1cdaa3c18bcb88f78b4dddfad9e3abced0aef05b0fd765b980d98"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c43199ade3bca564204f8df3cf63c5194b53003afc5f519660786ac17e932f5b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0a382412154fc12ce6dd6d25903281e3c33922b0d3857bc541baea054f09a1f2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6be11d8bf7e9f4b9a04ba3169be9af7f407f73c0eee60c0081c5f3871762489c"
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
