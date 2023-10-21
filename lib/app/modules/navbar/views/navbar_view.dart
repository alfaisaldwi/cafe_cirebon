import 'package:cafe_cirebon/app/modules/home/views/home_view.dart';
import 'package:cafe_cirebon/app/style/color_primary.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class BasicMainNavigationView extends StatefulWidget {
  const BasicMainNavigationView({Key? key}) : super(key: key);

  @override
  State<BasicMainNavigationView> createState() =>
      _BasicMainNavigationViewState();
}

class _BasicMainNavigationViewState extends State<BasicMainNavigationView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: [
            HomeView(),
            Container(
              color: Colors.red[100],
            ),
            Container(
              color: Colors.purple[100],
            ),
            Container(
              color: Colors.blue[100],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 14,
          iconSize: 26,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: Styles.colorPrimary(),
          unselectedItemColor: Styles.colorSecondary(),
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                BoxIcons.bxs_home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Recomend",
              icon: Icon(
                BoxIcons.bxs_coffee_alt,
              ),
            ),
            BottomNavigationBarItem(
              label: "Radar",
              icon: Icon(
                Iconsax.map,
              ),
            ),
            BottomNavigationBarItem(
              label: "Favorite",
              icon: Icon(
                Iconsax.like,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
