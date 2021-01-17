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
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error('Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}

Future<String> city() async {
  final position = await _determinePosition();
  final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: window.locale.toString());
  if(placemarks != null && placemarks.isNotEmpty){
    final city = placemarks.first;
    return '${city.locality}, ${city.country}';
  }
  return null;
}