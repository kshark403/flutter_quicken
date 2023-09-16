// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // navigate to login screen
    Navigator.pushReplacementNamed(context, AppRouter.login);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Padding(
      padding: const EdgeInsets.only(top:50.0),
      child: Image.asset('assets/images/$assetName', width: width),
    );
  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "ระบบข่าวสารสำหรับทุกคน",
            body:
            "เริ่มต้นใช้ระบบกับเราเพียง 3 ขั้นตอนง่ายๆ",
            image: _buildImage('slide1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "เรียนรู้การใช้งานเบื้องต้น",
            body:
            "ดาวน์โหลดโหลดคู่มือการเรียนรู้ได้เลย",
            image: _buildImage('slide2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "เริ่มต้นกับเราได้แล้ววันนี้",
            body:
            "เพียงลงทะเบียนรับเสิทธิ์ฟรี",
            image: _buildImage('slide3.png'),
            decoration: pageDecoration,
          ),
    
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        nextFlex: 0,
        skip: const Text('ข้าม'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('เริ่มใช้งาน', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
    
      ),
    );
  }
}