---
typora-root-url: ./assets
---

# 1 versions

| items         | version           | Commands            |
| ------------- | ----------------- | ------------------- |
| intellij idea | 2020.2.3          |                     |
| git           | 2.29.2          | git --version       |
| Flutter       | 1.26.0-2.0.pre.94 | flutter --version   |
| JDK           | openjdk 11.0.8    | java -version       |
| xcode         | 12.3            | xcodebuild -version |
| android studio | 4.1 |                     |

```
yuri@yuris-MBP ~ % flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.26.0-2.0.pre.94, on Mac OS X 10.15.7 19H15 darwin-x64,
    locale en)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[✓] Xcode - develop for iOS and macOS (Xcode 12.3)
[✓] Chrome - develop for the web
[✓] Android Studio (version 4.1)
[✓] IntelliJ IDEA Ultimate Edition (version 2020.3)
[✓] VS Code (version 1.52.1)
[✓] Connected device (1 available)
```



# 2 steps

## 2.1 git & intellij idea

skip.

## 2.2 flutter

```
# 1 make tools directory
mkdir tools
cd /Users/yuri/tools
# 2 install git (macOS Catalina)
git clone https://github.com/flutter/flutter.git
```

![image-20200926190757855](/image-20200926190757855.png)

```
# 3 (use zsh to)add flutter to your path
echo 'export PATH="$PATH:/Users/yuri/tools/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# 4 Verify that the flutter command is available by running:
which flutter
flutter --version
```

![image-20200926195015586](/image-20200926195015586.png)

## 2.3 JDK

```
# 1. Update HomeBrew and add the casks tap of HomeBrew.
$ brew update
$ brew tap homebrew/cask-versions
$ brew tap adoptopenjdk/openjdk

2. Install Version 11 of Java JDK.
$ brew cask install adoptopenjdk11
$ java --version
openjdk 11.0.8 2020-07-14
OpenJDK Runtime Environment AdoptOpenJDK (build 11.0.8+10)
OpenJDK 64-Bit Server VM AdoptOpenJDK (build 11.0.8+10, mixed mode)
$ javac --version
javac 11.0.8 
```

## 2.4 flutter doctor

```
# 1 pre-download development binaries 
$ flutter precache

# 2 checks your environment and displays a report to the terminal window.
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.22.0-10.0.pre.380, on Mac OS X 10.15.7 19H2 x86_64, locale en)
[✗] Android toolchain - develop for Android devices
    ✗ Unable to locate Android SDK.
      Install Android Studio from: https://developer.android.com/studio/index.html
      On first launch it will assist you in installing the Android SDK components.
      (or visit https://flutter.dev/docs/get-started/install/macos#android-setup for detailed
      instructions).
      If the Android SDK has been installed to a custom location, please use
      `flutter config --android-sdk` to update to that location.

[✗] Xcode - develop for iOS and macOS
    ✗ Xcode installation is incomplete; a full installation is necessary for iOS development.
      Download at: https://developer.apple.com/xcode/download/
      Or install Xcode via the App Store.
      Once installed, run:
        sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
        sudo xcodebuild -runFirstLaunch
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to
        your plugin usage on the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To install:
        sudo gem install cocoapods
[!] Android Studio (not installed)
[!] IntelliJ IDEA Ultimate Edition (version 2020.2.2)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
[!] Connected device
    ! No devices available

! Doctor found issues in 5 categories.
```

## 2.5 iOS Simulator

> 1. xcode安装时间大约需要1个多小时。相当久
> 2. 依次输入第2步的命令，按‘空格键’跳转到最后，然后输入‘agree’，才算安装完毕


1. Install the latest stable version of Xcode (using [web download](https://developer.apple.com/xcode/) or the [Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835)).
2. Config Xcode enviroment

```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

![xcode](/xcode.png)

3. To view xcode version

```
yuri ~# xcodebuild -version
Xcode 12.1
Build version 12A7403
```

4. open a simulator

```
open -a Simulator
```

<img src="/image-20200927144043554.png" alt="image-20200927144043554" style="zoom:50%;" />




## 2.6 intellij idea plugins

![image-20200926212915274](/image-20200926212915274.png)



![image-20200926213608808](/image-20200926213608808.png)

```
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.22.0-10.0.pre.380, on Mac OS X 10.15.7 19H2
    x86_64, locale en)
[✗] Android toolchain - develop for Android devices
    ✗ Unable to locate Android SDK.
      Install Android Studio from:
      https://developer.android.com/studio/index.html
      On first launch it will assist you in installing the Android SDK
      components.
      (or visit https://flutter.dev/docs/get-started/install/macos#android-setup
      for detailed instructions).
      If the Android SDK has been installed to a custom location, please use
      `flutter config --android-sdk` to update to that location.

[✗] Xcode - develop for iOS and macOS
    ✗ Xcode installation is incomplete; a full installation is necessary for iOS
      development.
      Download at: https://developer.apple.com/xcode/download/
      Or install Xcode via the App Store.
      Once installed, run:
        sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
        sudo xcodebuild -runFirstLaunch
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin
        code that responds to your plugin usage on the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To install:
        sudo gem install cocoapods
[!] Android Studio (not installed)
[✓] IntelliJ IDEA Ultimate Edition (version 2020.2.2)
[!] Connected device
    ! No devices available
```
## 2.7 hello world

![helloworld](/helloworld.png)



# 3 Android Set up

## 3.1 flutter doctor

```
yuri@yuris-MBP flutter % flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, 1.26.0-2.0.pre.86, on Mac OS X 10.15.7 19H15
    darwin-x64, locale en)
[✗] Android toolchain - develop for Android devices
    ✗ Unable to locate Android SDK.
      Install Android Studio from:
      https://developer.android.com/studio/index.html
      On first launch it will assist you in installing the Android SDK
      components.
      (or visit https://flutter.dev/docs/get-started/install/macos#android-setup
      for detailed instructions).
      If the Android SDK has been installed to a custom location, please use
      `flutter config --android-sdk` to update to that location.

[!] Xcode - develop for iOS and macOS (Xcode 12.2)
    ! CocoaPods 1.9.3 out of date (1.10.0 is recommended).
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin
        code that responds to your plugin usage on the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To upgrade see
      https://guides.cocoapods.org/using/getting-started.html#installation for
      instructions.
[✓] Chrome - develop for the web
[!] Android Studio (not installed)
[✓] IntelliJ IDEA Ultimate Edition (version 2020.3)
[✓] VS Code (version 1.52.1)
[✓] Connected device (1 available)

! Doctor found issues in 3 categories.
```

## 3.2 安装Android studio

```
brew install --cask android-studio
```

## 3.3 打开Android studio

![image-20201219225403451](/image-20201219225403451.png)

## 3.4 accept android licenses

```
flutter doctor --android-licenses
```

## 3.5 AMD Manager

![image-20201219231852866](/image-20201219231852866.png)

![image-20201219232242455](/image-20201219232242455.png)

# 4 finished

![Screen Shot 2020-12-19 at 11.07.41 PM](/Screen%20Shot%202020-12-19%20at%2011.07.41%20PM.png)





# 5 update flutter

```
cd /Users/yuri/tools/flutter
git pull
flutter doctor
flutter --version
```

