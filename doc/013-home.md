---
typora-root-url: ./assets
---

# 1 brief profile

<img src="/image-20210117000659290.png" alt="image-20210117000659290" style="zoom:50%;" />

# 2 city location

- Get the current location of the device
- Translate an address to geo coordinates and vice versa

## 2.1 location

### 2.1.1 dependency

```
geolocator: ^6.1.13
```

### 2.1.2 Android and iOS settings

https://pub.dev/packages/geolocator

### 2.1.3 source code

`lib/config/constants.dart`

```
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error('Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}
```



## 2.2 city name

### 2.2.1 dependency

```
geocoding: ^1.0.5
```

### 2.2.2  source code

```
Future<String> city() async {
  final position = await _determinePosition();
  final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: window.locale.toString());
  if(placemarks != null && placemarks.isNotEmpty){
    final city = placemarks.first;
    return '${city.locality}, ${city.country}';
  }
  return null;
}
```

## 2.3 build Text Widget

```
FutureBuilder(
    future: city(),
    builder: (context, snapshot){
      dynamic cityName = snapshot.data;
      return Text(cityName == null ? '' : cityName as String);
    }
)
```

# 3 refactoring

## 3.1 navigation

```
GetPage(
    name: RouteNames.SignUpScreen,
    page: () => SignUpScreen(),
    binding: BindingsBuilder<UserSignUpController>(() => Get.lazyPut(() => UserSignUpController())),
    children: [
      GetPage(
        name: '/complete/profile',
        page: () => CompleteProfileScreen(),
        binding: BindingsBuilder<CompleteProfileController>(() => Get.lazyPut(() => CompleteProfileController())),
        children: [
          GetPage(
            name: '/otp',
            page: () => OtpScreen(),
            binding: BindingsBuilder<OtpController>(() => Get.lazyPut(() => OtpController())),
          ),
        ],
      ),
    ],
  ),
```

## 3.2 GetView\<Controller\>

- `GetView` is a `StatelessWidget`
- has a getter `controller` for the registered `Controller`

```
GetPage(
    name: RouteNames.CounterScreen,
    page: () => CounterScreen(),
    binding: BindingsBuilder<CounterController>(() => Get.lazyPut(() => CounterController())),
)
```

![image-20210117121440792](/image-20210117121440792.png)

## 3.3 Pass arguments to a named route

### 3.3.1 parent controller

```
# CompleteProfileController
Get.toNamed<dynamic>(RouteNames.OtpScreen, arguments: phone.value);
```

### 3.3.2 routes

```
GetPage(
  name: '/complete/profile',
  page: () => CompleteProfileScreen(),
  binding: BindingsBuilder<CompleteProfileController>(() => Get.lazyPut(() => CompleteProfileController())),
  children: [
    GetPage(
      name: '/otp',
      page: () => OtpScreen(
        phone: Get.arguments as String
      ),
      binding: BindingsBuilder<OtpController>(() => Get.lazyPut(() => OtpController())),
    ),
  ],
),
```

### 3.3.3 child screen

```
class OtpScreen extends StatelessWidget {
  final String phone;

  const OtpScreen({
    Key key,
    @required this.phone,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    ...
  }
}
```

# 4 Drawer with Custom Icon

## 4.1 HomeController

```
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }
}
```

## 4.2 HomeScreen

```
class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => controller.openDrawer(),
            );
          },
        ),
      ),
      drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () => controller.closeDrawer(),
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () => controller.closeDrawer(),
              ),
            ],
          ),
      ),
      body: ...
    );
  }
}
```

## 4.3 custom drawer icon

```
icon: SvgPicture.asset('assets/images/drawer.svg')
```

## 4.4 right drawer

- Widget: endDrawer
- Icon: actions

# 5 HomeScreen Layout

```
body: SafeArea(
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(30, (index) => Column(
            children: [
              Text('Hi Annie,'),
              SizedBox(height: S.y(30)),
            ],
          )),
          Text('------end-------'),
        ],
      ),
    ),
  ),
),
```



