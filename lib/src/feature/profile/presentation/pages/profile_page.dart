import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 20,
        backgroundColor: AppColor.primary,
        iconTheme: IconThemeData(color: AppColor.secondary),
        title: Text(
          "Profil",
          style: GoogleFonts.poppins(
            color: AppColor.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.red,
          ),
          Gap(gap: 30),
          Text("Luqman"),
          Text("Luqman@gmail.com"),
        ],
      ),
    );
  }
}
