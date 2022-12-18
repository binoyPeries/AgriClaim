import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/farmer/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({Key? key}) : super(key: key);

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultScaffold(
        appBar: DefaultAppBar(
            title: _appbarTitle[_selectedIndex], backButtonVisible: false),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 2.h,
          selectedIconTheme:
              IconThemeData(color: AgriClaimColors.primaryMaterialColor),
          selectedItemColor: AgriClaimColors.primaryColor,
          unselectedFontSize: 15,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.wpforms),
              label: 'Claims',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.wheatAwn),
              label: 'Farms',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  static const List<String> _appbarTitle = ["Claims", "Farms", "Profile"];
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    ProfilePage(),
  ];
}
