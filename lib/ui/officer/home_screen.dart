import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/officer/assigned_claims.dart';
import 'package:agriclaim/ui/officer/profile_page.dart';
import 'package:agriclaim/ui/officer/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class OfficerHomePage extends StatefulWidget {
  const OfficerHomePage({Key? key}) : super(key: key);

  @override
  State<OfficerHomePage> createState() => _OfficerHomePageState();
}

class _OfficerHomePageState extends State<OfficerHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      appBar: DefaultAppBar(
          title: _appbarTitle[_selectedIndex], backButtonVisible: false),
      body: _pages.elementAt(_selectedIndex),
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
            icon: Icon(FontAwesomeIcons.book),
            label: 'Claims',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  static const List<String> _appbarTitle = [
    "Assigned Claims",
    "Search",
    "Profile"
  ];
  static const List<Widget> _pages = <Widget>[
    AssignedClaimsPage(),
    SearchPage(),
    ProfilePage(),
  ];
}
