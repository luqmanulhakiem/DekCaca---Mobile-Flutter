import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSchoolPage extends StatefulWidget {
  const ProfileSchoolPage({super.key});

  @override
  State<ProfileSchoolPage> createState() => _ProfileSchoolPageState();
}

class _ProfileSchoolPageState extends State<ProfileSchoolPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 20,
        backgroundColor: AppColor.primary,
        iconTheme: const IconThemeData(color: AppColor.secondary),
        title: Text(
          "Profile Sekolah",
          style: GoogleFonts.poppins(
            color: AppColor.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: TextEditingController(text: "SMK Negeri 1 Omben"),
                readOnly: true,
                decoration: InputDecoration(
                    label: const Text("Nama Sekolah"),
                    enabledBorder: _borderOutline(),
                    focusedBorder: _borderOutline()),
              ),
              Gap(gap: 20),
              TextField(
                controller: TextEditingController(
                    text: "Jl. Raya Sogiyan Omben Sampang 69291"),
                readOnly: true,
                decoration: InputDecoration(
                    label: const Text("Alamat"),
                    enabledBorder: _borderOutline(),
                    focusedBorder: _borderOutline()),
              ),
              Gap(gap: 20),
              TextField(
                controller: TextEditingController(
                    text: "https://www.smkn1omben.sch.id"),
                readOnly: true,
                decoration: InputDecoration(
                    label: const Text("Website"),
                    enabledBorder: _borderOutline(),
                    focusedBorder: _borderOutline()),
              ),
              Gap(gap: 20),
              TextField(
                controller:
                    TextEditingController(text: "smknegeri1omben@gmail.com"),
                readOnly: true,
                decoration: InputDecoration(
                    label: const Text("Email"),
                    enabledBorder: _borderOutline(),
                    focusedBorder: _borderOutline()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _borderOutline() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColor.primary),
    );
  }
}
