import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/core/values/strings.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/main_page.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/search_page.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentPage = 0;
  final List<Widget> pages = [
    const MainPage(),
    const SearchPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: _appBar(),
      body: pages[currentPage],
      bottomNavigationBar: _bottomNavbar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: kToolbarHeight + 20,
      backgroundColor: AppColor.primary,
      title: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 8,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Text(
                    Strings.appName,
                    style: GoogleFonts.poppins(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 2,
                child: Container(
                  height: 50,
                  width: 50,
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset("assets/images/logosmk.png")),
                )),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavbar() {
    return BottomNavigationBar(
      onTap: (newValue) {
        setState(() {
          currentPage = newValue;
        });
      },
      currentIndex: currentPage,
      backgroundColor: AppColor.primary,
      selectedItemColor: AppColor.secondary,
      // unselectedItemColor: Colors.grey.shade300,
      unselectedItemColor: Colors.grey.shade400,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 30),
      items: const [
        BottomNavigationBarItem(label: "Beranda", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Pencarian", icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: "Profil", icon: Icon(Icons.person)),
      ],
    );
  }
}
