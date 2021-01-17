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