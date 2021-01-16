---
typora-root-url: ./assets
---

# 1 brief profile

Complete the registration in three steps:
1. Fill in the email and password
2. Complete personal information
3. verify phone

![image-20210112120323067](/image-20210112120323067.png)



![image-20210112133230254](/image-20210112133230254.png)

![image-20210116130402321](/image-20210116130402321.png)

# 2 知识点

- 多个页面之间传参数。有以下两种不同的方式，推荐使用第一种

  - ```
    # 1. CompleteProfileController
    Get.toNamed<dyanmic>(RouteNames.OtpScreen, arguments: phone.value);
    
    # 2. OtpScreen
    final phone = Get.arguments as String;
    ```

  - ```
    # 1. CompleteProfileController
    Get.toNamed<void>(RouteNames.OtpScreen);
    
    # 2. OtpScreen
    final phone = Get.find<CompleteProfileController>().phone.value;
    ```

- 倒计时

```
TweenAnimationBuilder<double>(
  tween: Tween(begin: 30, end: 0),
  duration: Duration(seconds: 30),
  builder: (_, value, child) => Text(
    '${value.toInt()}',
    style: TextStyle(color: kPrimaryColor),
  ),
)
```

- spred array

```
var a = [0,1,2,3,4];
var b = [6,7,8,9];
var c = [...a,5,...b];

print(c);  // prints: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

- 获得焦点

```
FocusNode // requestFocus() // unfocus()
```