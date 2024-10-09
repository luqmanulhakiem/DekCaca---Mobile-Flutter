import 'dart:async';

import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/core/values/strings.dart';
import 'package:dekcaca_app/src/feature/auth/presentation/pages/auth_page.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/index_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    init();

    // final user = FirebaseAuth.instance.currentUser;
    // if (user?.displayName != null) {
    //   Timer(const Duration(seconds: 2),
    //       () => Get.off(const IndexPage(), transition: Transition.rightToLeft));
    // } else {
    //   Timer(const Duration(seconds: 2),
    //       () => Get.off(const AuthPage(), transition: Transition.rightToLeft));
    // }
  }

  void init() async {
    final storage = FlutterSecureStorage();
    final signIn = await storage.read(key: 'signIn');

    // final user = FirebaseAuth.instance.currentUser;
    if (signIn == 'true') {
      Timer(const Duration(seconds: 2),
          () => Get.off(const IndexPage(), transition: Transition.rightToLeft));
    } else {
      Timer(const Duration(seconds: 2),
          () => Get.off(const AuthPage(), transition: Transition.rightToLeft));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.appName,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 46,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
