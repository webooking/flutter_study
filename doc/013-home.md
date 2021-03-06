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
icon: SvgPicture.asset('assets/icons/drawer.svg')
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



# 6 beutify

## 6.1 avatar

```
IconButton(
  icon: Container(
    width: S.x(40),
    height: S.y(40),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Color(0xFFD8D8D8),
      ),
    ),
    child: SvgPicture.asset('assets/images/avatar.svg'),
  ),
  onPressed: controller.openEndDrawer,
),
```

## 6.2 categories

### 6.2.1 config

```
const categoriesData = [
  {
    'name': 'Flight',
    'svg': 'assets/images/flight.svg',
    'backgroundColor': Color(0xFF5E64F4),
    'svgColor': Colors.white,
  },
  {
    'name': 'Hotel',
    'svg': 'assets/images/hotel.svg',
    'backgroundColor': Color(0xFFFF665B),
    'svgColor': Colors.white,
  },
  {
    'name': 'Bus',
    'svg': 'assets/images/bus.svg',
    'backgroundColor': Color(0xFF00CFFF),
    'svgColor': Colors.white,
  },
  {
    'name': 'More',
    'svg': 'assets/images/more.svg',
    'backgroundColor': Color(0xFFFF8945),
    'svgColor': Colors.white,
  },
];
```



### 6.2.2 widget 

```
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: S.x(55),
      height: S.y(55),
      padding: EdgeInsets.all(S.x(15)),
      decoration: BoxDecoration(
        color: categoriesData[index]['backgroundColor'] as Color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SvgPicture.asset(
        categoriesData[index]['svg'] as String,
        color: categoriesData[index]['svgColor'] as Color,
      ),
    ),
    SizedBox(height: S.y(15),),
    Text(categoriesData[index]['name'] as String,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
)
```



## 6.3 recommend

```
Container(
  margin: EdgeInsets.only(right: 15),
  padding: EdgeInsets.all(S.x(15)),
  width: S.x(267),
  height: S.y(350),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: Colors.black,
    ),
  ),
  child: Column(
    children: [
      Container(
        width: S.x(243),
        height: S.y(227),
        decoration: BoxDecoration(
          color: Color(0xFFF4F1F1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: SvgPicture.asset('assets/images/splash-1.svg'),
      ),
      SizedBox(height: S.y(20)),
      Text('Explore this magical place in Greece'),
    ],
  ),
)
```



## 6.4 search field

```
TextField(
  decoration: InputDecoration(
    hintText: 'Search Hotels, Taxi etc..',
    prefixIcon: Icon(Icons.search),
    filled: true,
    fillColor: Color(0xFFF4F6FE),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: Color(0xFFF4F6FE)),
      gapPadding: 10,
    ),
  ),
)
```



