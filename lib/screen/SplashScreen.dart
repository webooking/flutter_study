import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/model/SplashData.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(
                S.x(380.0),
                S.y(500.0),
              )),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return SvgPicture.asset(
                    SplashData.data[index],
                  );
                },
                itemCount: 3,
                autoplay: true,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: S.x(20)),
              child: DefaultButton(
                text: L.button.bt_continue,
                press: () {},
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
