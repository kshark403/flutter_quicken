// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavpage/setting_screen.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // ส่วนของการโหลดสลับข้อมูลใน bottomNavigationBar -------------------------

  // สร้างตัวแปรเก็บ title ของแต่ละหน้า
  String _title = 'Flutter Scale';

  // สร้างตัวแปรเก็บ index ของแต่ละหน้า
  int _currentIndex = 0;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  // ฟังก์ขันในการเปลี่ยนหน้า โดยรับค่า index จากการกดที่ bottomNavigationBar
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = AppLocalizations.of(context)!.menu_home; break;
        case 1: _title = AppLocalizations.of(context)!.menu_report; break;
        case 2: _title = AppLocalizations.of(context)!.menu_notification; break;
        case 3: _title = AppLocalizations.of(context)!.menu_setting; break;
        case 4: _title = AppLocalizations.of(context)!.menu_profile; break;
        default: _title = 'Flutter Scale'; break;
      }
    });
  }

  // จบส่วนของการโหลดสลับข้อมูลใน bottomNavigationBar -----------------------

  // Method Logout ------------------------------------------------------
  void _logout() async {

    // Create SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear sharedPreferences
    prefs.clear();

    // Set step to 1
    prefs.setInt('step', 1);

    // Navigate to Login Screen
    Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (route) => false);
    
  }
  // ---------------------------------------------------------------------

  // สร้างตัวแปรไว้เก็บค่า user profile
  String? _fistname, _lastname, _email;

  // Get User Profile
  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fistname = prefs.getString('firstname');
      _lastname = prefs.getString('lastname');
      _email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        // backgroundColor: primary,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  accountName: Text('$_fistname $_lastname'), 
                  accountEmail: Text(_email ?? ''),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/noavartar.png'),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/noavartar.png'),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(AppLocalizations.of(context)!.menu_info, style: TextStyle(fontSize: 18),),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(AppLocalizations.of(context)!.menu_about, style: TextStyle(fontSize: 18),),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(AppLocalizations.of(context)!.menu_contact, style: TextStyle(fontSize: 18),),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(AppLocalizations.of(context)!.menu_logout, style: TextStyle(fontSize: 18),),
                  onTap: _logout,
                ),
                ]
              ),
            ),
          ],
        )
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: AppLocalizations.of(context)!.menu_report
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.menu_notification
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.menu_setting
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.menu_profile
          ),
        ]
      ),
    );
  }
}