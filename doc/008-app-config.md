---
typora-root-url: ./assets
---

# 1 项目结构

<img src="/image-20201225195914865.png" alt="image-20201225195914865" style="zoom:50%;" />

# 2 change app name

| android/app/src/main/AndroidManifest.xml                     | ios/Runner/Info.plist                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `<application>`<br/>  `android:label="your_app_name"`<br/>... | `<key>CFBundleName</key>`<br/>`<string>your_app_name</string>` |



# 3 Change App Launcher Icon

- 准备一张高分辨率的图片。最好是`SVG`
- https://makeappicon.com/
- 解压，并替换相应的文件

![image-20201228000524507](/image-20201228000524507.png)

# 4 国际化

怎么使用`GetX`实现国际化？

