import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/core/values/strings.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/main_page.dart';
import 'package:dekcaca_app/src/feature/main/presentation/pages/search_page.dart';
import 'package:dekcaca_app/src/feature/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Get.to(const ProfilePage(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(color: AppColor.secondary, width: 2),
                    ),
                    height: 50,
                    width: 50,
                    child: ClipOval(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.network(
                            "https://plus.unsplash.com/premium_photo-1724296697228-ae418d019540?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxOXx8fGVufDB8fHx8fA%3D%3D"),
                      ),
                    ),
                  ),
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
      unselectedItemColor: Colors.grey.shade300,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 30),
      items: const [
        BottomNavigationBarItem(label: "Beranda", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Pencarian", icon: Icon(Icons.search)),
      ],
    );
  }
}
