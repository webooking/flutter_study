import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> recommend() => [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
            ),
            Text(
              'View All',
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: S.y(30),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              ...List.generate(
                  3,
                  (index) => Container(
                    margin: EdgeInsets.only(right: 15),
                    width: S.x(267),
                    height: S.y(350),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F1F1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: SvgPicture.asset('assets/images/splash-1.svg'),
                  )),
            ],
          ),
        ),
      ),
    ];
