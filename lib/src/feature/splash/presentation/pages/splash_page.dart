import 'dart:async';

import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/core/values/strings.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/index_page.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => Get.off(const IndexPage(), transition: Transition.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  Strings.appName,
                  style: TextStyle(color: AppColor.secondary),
                ),
              ),
            ),
            const Gap(gap: 30),
            // TODO: NYALAKAN NANTI
            // SizedBox(
            //   height: 40,
            //   width: 40,
            //   child: FittedBox(
            //       fit: BoxFit.fill,
            //       child: Image.asset("assets/images/logosmk.png")),
            // ),
            const Gap(gap: 40)
          ],
        ),
      ),
    );
  }
}
