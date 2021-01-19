import 'package:flutter/material.dart';
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
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F1F1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: SvgPicture.asset('assets/images/drawer.svg'),
                  ),
                  SizedBox(height: S.y(15),),
                  Text('Flight',
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
