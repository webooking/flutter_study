import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kTextColor = Color(0xFF757575);

/// storage
const kAccessToken = 'accessToken';
const kRefreshToken = 'refreshToken';

const splashData = [
  'assets/images/splash-1.svg',
  'assets/images/splash-2.svg',
  'assets/images/splash-3.svg',
];

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

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(S.x(15)),
    borderSide: BorderSide(color: kTextColor),
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
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      return Future.error('Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}

Future<String> city() async {
  final position = await _determinePosition();
  final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: window.locale.toString());
  if (placemarks != null && placemarks.isNotEmpty) {
    final city = placemarks.first;
    return '${city.locality}, ${city.country}';
  }
  return null;
}
