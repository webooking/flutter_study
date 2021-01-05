---
typora-root-url: ./assets
---

# 1 简介

| platformType | deviceType |
| ------------ | ---------- |
| Web          | Windows    |
| Web          | Linux      |
| Web          | MacOS      |
| Web          | Fuchsia    |
| Web          | Android    |
| Web          | iOS        |
| **Android**  | Android    |
| **iOS**      | iOS        |

## 1.1 Android

| Name            | Desc                                                         |
| --------------- | ------------------------------------------------------------ |
| **IMEI**        | International Mobile Equipment Identity<br />国际移动电话设备识别码，最常使用在GSM制式的手机上<br />每台手机一个，而且全球唯一 |
| **MEID**        | Mobile Equipment IDentifier<br />56bit CDMA制式移动终端标识号 |
| **ESN**         | Electronic Serial Number<br />美国联邦通信委员会规定的，最常使用在CDMA手机上<br />早期用于AMPS和D-AMPS手机上 |
| **SerialNo**    | 一套正版的产品只对应一组产品序列号                           |
| **DEVICE_ID**   | Android系统为开发者提供的<br />根据不同的手机设备返回IMEI，MEID或者ESN码<br />Android10上更新的隐私保护，已经无法正常获取了 |
| **ANDROID_ID**  | 手机首次启动时，系统会随机生成一个64位的数字 。<br />当设备被wipe（恢复出厂设置、刷机等)后，该值会被重置 |
| **MAC ADDRESS** | 每个网卡一个MAC地址<br />若手机有多个网卡，则有多个MAC地址   |

## 1.2 iOS



# 2 读取设备信息

![image-20201220004042474](/image-20201220004042474.png)


## 2.1 dependency

```
dependencies:
  device_info: ^1.0.0
```

## 2.2 测试DeviceInfoScreen

```
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DeviceInfoScreen extends HookWidget {
  const DeviceInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Platform.isAndroid ? 'Android Device Info' : 'iOS Device Info'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _readDeviceInfo(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                String key = snapshot.data.keys.elementAt(index);
                return Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Text(
                        '${snapshot.data[key]}',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                  ],
                );
              });
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _readDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final error = <String, dynamic>{'Error:': 'Failed to get platform version.'};

    try {
      if (Platform.isAndroid) {
        return _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        return _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      return error;
    }
    return error;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}

```

# 3 预加载的数据

1. 用途
- 用户首次使用app时，需要询问用户，获得权限后，才可以读取这些敏感信息
- 根据手机上设置的语言，时区等信息
    - 显示过场动画
    - 显示菜单/按钮等
    - 错误提示
- 根据access_token，自动识别用户身份；根据refresh_token，自动续约

2. 存储

- 保存到服务端（数据库）
    - 用户每次登录使用的`deviceToken`,`deviceInfo`,`region`等数据，都要保存到服务端（数据库）
    - 每次refresh token时，自动获取`deviceToken`,`deviceInfo`,`region`等数据，与本地存储的数据做对比，若发生变化，将其保存到服务端（数据库）
    - 服务端以日志的形式，记录用户的敏感数据。方便审计，追查等

- 保存到本地
  本地只需要保存用户当前使用的数据。不需要变更记录
3. 更改
- 用户注册过程中，可以选择自己喜欢的语言，日期/时间格式，城市等
- 进入app后，可以修改默认的语言，日期/时间格式，城市等

## 3.1 加密

| name           | desc                                                         |
| -------------- | ------------------------------------------------------------ |
| deviceToken    | 设备码<br />判断用户是否更换设备                             |
| access_token   | app发给用户的临时通行证                                      |
| refresh_token  | 当access_token过期后<br />1. refresh_token有效<br /> a) 不需要用户参与<br /> b) app后台会自动发放新的access_token<br />2. refresh_token过期。请重新登录 |
| authentication | 用户的身份信息，id，姓名，性别等                             |
| authorization  | 用户的权限数据。允许该用户访问哪些screen，menu，API等        |

## 3.2 不加密

| name            | desc           |            |
| --------------- | -------------- | ---------- |
| GeoPosition     | 用户的当前坐标 | geolocator |
| Language        |                | i18n       |
| TimeZone        |                |            |
| DateTime Format |                |            |
| Date Format     |                |            |

## 3.3 本地存储

- 加密：flutter_secure_storage
- 不加密： shared_preferences

## 3.4 测试

### 3.4.1 GeoPositionScreen

1. 配置

| android                                             | iOS                                                          |
| --------------------------------------------------- | ------------------------------------------------------------ |
| 太长了，略<br />https://pub.dev/packages/geolocator | 在文件`ios/Runner/Info.plist`中，添加下面的配置<br /><key>NSLocationWhenInUseUsageDescription</key> <br /><string>This app needs access to location when open.</string> <br /><key>NSLocationAlwaysUsageDescription</key> <br /><string>This app needs access to location when in the background.</string> |



2. 测试记录

![image-20201220212809907](/image-20201220212809907.png)

<img src="/image-20201220212920374.png" alt="image-20201220212920374" style="zoom:25%;" />

3. Source code

```
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoPositionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(Platform.isAndroid ? 'Android GeoPosition' : 'iOS GeoPosition'),
    ),
    body: Container(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot){
          return Text(
            snapshot.data.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    ),
    );
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      if(Platform.isAndroid){
        // await Geolocator.openLocationSettings();
        await Geolocator.openAppSettings();
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error(
              'Location permissions are denied (actual value: $permission).');
        }
      }
      if(Platform.isIOS){
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    if (Platform.isIOS && permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
```

