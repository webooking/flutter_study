import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

Padding categories() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
              4,
              (index) => Column(
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
          )
        ],
      ),
    );
