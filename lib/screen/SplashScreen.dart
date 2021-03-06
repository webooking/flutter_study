import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/routes.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            _buildSwiper(),
            Spacer(),
            _buildButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Padding _buildButton() => Padding(
        padding: EdgeInsets.symmetric(horizontal: S.x(20)),
        child: DefaultButton(
          text: L.button.bt_continue,
          press: () => Get.offAllNamed<void>(RouteNames.SignInScreen),
        ),
      );

  ConstrainedBox _buildSwiper() => ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
          S.x(380.0),
          S.y(500.0),
        )),
        child: Swiper(
          duration: 2000,
          itemBuilder: (BuildContext context, int index) {
            return TweenAnimationBuilder<Color>(
                tween: ColorTween(begin: Colors.white, end: Colors.orangeAccent),
                duration: Duration(milliseconds: 2000),
                builder: (context, value, child) {
                  return SvgPicture.asset(
                    splashData[index],
                    color: value,
                  );
                });
          },
          itemCount: 3,
          autoplay: true,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              color: kPrimaryColor,
            ),
          ),
        ),
      );
}
