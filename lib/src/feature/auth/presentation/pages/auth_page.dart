import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:dekcaca_app/src/feature/splash/presentation/pages/splash_page.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Container(
      color: AppColor.primary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    height: 200,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset("assets/images/rain.jpg")),
                    )),
              ),
              Text(
                "DekCaca",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 46,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w800),
              ),
              const Gap(gap: 20),
              Text(
                "Cari tahu cuaca dan perkiraan cuaca yang anda inginkan",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(gap: 50),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessLogin) {
                    getx.Get.off(const SplashPage());
                  } else if (state is AuthFailure) {
                    print("FAILED LOGIN");
                  }
                },
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      authBloc.add(AuthLogin());
                    },
                    child: Text(
                      "Login dengan Google",
                      style: GoogleFonts.poppins(color: AppColor.primary),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
