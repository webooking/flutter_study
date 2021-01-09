---
typora-root-url: ./assets
---

# 1 brief profile

- 公司logo
- 介绍产品的功能
- 预加载一些数据

![image-20210107220700760](/image-20210107220700760.png)

# 2 pub.dev

```
dependencies:
  flutter_svg: ^0.19.2+1
  flutter_swiper: ^1.1.6
  
flutter:
  assets:
    - assets/images/
    - assets/fonts/
    - assets/icons/
```



# 3 config

## 3.1 x & y

|        | template       | acutal    |
| ------ | -------------- | --------- |
| screen | _templateWidth | Get.width |
| widget | inputWidth     | x         |

```
inputWidth/_templateWidth = x / Get.width

x = inputWidth/_templateWidth * Get.width
```



```
import 'package:get/get.dart';

class S {
  static final double _templateWidth = 428.0;
  static final double _templateHeight = 926.0;

  static double x(double inputWidth) => inputWidth / _templateWidth * Get.width;
  static double y(double inputHeight) => inputHeight / _templateHeight * Get.height;
}
```

## 3.2 constants

```
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
```

## 3.3 defaut button

```
import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: S.y(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        child: Text(
          text,
          style: TextStyle(
            fontSize: S.x(18),
            color: Colors.white,
          ),
        ),
        onPressed: press,
      ),
    );
  }
}
```



## 3.4 i18n





# 4 source code

<img src="/image-20210108162424638.png" alt="image-20210108162424638" style="zoom:25%;" />

```
import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/model/SplashData.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(S.x(380), S.y(500),)),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) => SvgPicture.asset(
                  SplashData.data[index],
                ),
                itemCount: SplashData.data.length,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: kPrimaryColor,
                  ),
                ),
                autoplay: true,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: S.x(20)),
              child: Column(
                children: [
                  DefaultButton(
                    text: L.button.bt_continue,
                    press: () {
                      //Get.offAllNamed('/register');
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
```











