import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';

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