import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dekcaca_app/src/feature/profile/presentation/pages/profile_school_page.dart';
import 'package:dekcaca_app/src/feature/splash/presentation/pages/splash_page.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String displayName = "";
  String email = "";
  String photoUrl = "";
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final name = await storage.read(key: 'displayName');
    final mail = await storage.read(key: 'email');
    final photo = await storage.read(key: 'photoUrl');
    setState(() {
      email = mail ?? "";
      displayName = name ?? "";
      photoUrl = photo ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        border: Border.all(color: AppColor.secondary, width: 2),
                      ),
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.antiAlias,
                          child: displayName == ''
                              ? Image.network(
                                  "https://plus.unsplash.com/premium_photo-1724296697228-ae418d019540?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxOXx8fGVufDB8fHx8fA%3D%3D")
                              : Image.network(photoUrl),
                          // child: FirebaseAuth.instance.currentUser == null
                          //     ? Image.network(
                          //         "https://plus.unsplash.com/premium_photo-1724296697228-ae418d019540?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxOXx8fGVufDB8fHx8fA%3D%3D")
                          //     : Image.network(
                          //         FirebaseAuth.instance.currentUser?.photoURL ??
                          //             ""),
                        ),
                      ),
                    ),
                    const Gap(gap: 30),
                    Text(
                      displayName ?? "",
                      // FirebaseAuth.instance.currentUser?.displayName ?? "",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      email ?? "",
                      // FirebaseAuth.instance.currentUser?.email ?? "",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Gap(gap: 40),
              Text(
                "Pengaturan",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Gap(gap: 10),
              InkWell(
                onTap: () {
                  getx.Get.to(const ProfileSchoolPage(),
                      transition: getx.Transition.rightToLeft);
                },
                child: Container(
                  height: 60,
                  color: AppColor.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.business_outlined,
                              color: AppColor.secondary,
                            ),
                            const Gap(gap: 10),
                            Text(
                              "Profil Sekolah",
                              style: GoogleFonts.poppins(
                                  color: AppColor.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.navigate_next_rounded,
                          color: AppColor.secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(gap: 10),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessLogout) {
                    getx.Get.off(const SplashPage());
                  } else if (state is AuthFailure) {
                    print("FAILED LOGOUT");
                  }
                },
                child: InkWell(
                  onTap: () {
                    authBloc.add(AuthLogout());
                  },
                  child: Container(
                    height: 60,
                    color: AppColor.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                color: AppColor.secondary,
                              ),
                              const Gap(gap: 10),
                              Text(
                                "Logout",
                                style: GoogleFonts.poppins(
                                    color: AppColor.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.navigate_next_rounded,
                            color: AppColor.secondary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
