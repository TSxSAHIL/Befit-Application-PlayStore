// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import

import 'package:befit/constants/app_constants.dart';
import 'package:befit/main.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class SupportUsPage extends StatelessWidget {
  const SupportUsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: mainHexColor,
          body: ContactUs(
          logo: AssetImage('assets/cbumm.jpg'),
          email: 'befit133@gmail.com',
          companyName: "BeFit", 
          dividerThickness: 2,
          dividerColor: accentHexColor,
          website: 'https://sahil-arora23.netlify.app',
          githubUserName: 'TSxSAHIL',
          linkedinURL: 'https://www.linkedin.com/in/sahil-arora-472415209/',
          cardColor: accentHexColor, 
          companyColor: accentHexColor, 
          taglineColor: accentHexColor, 
          textColor: Colors.white,
            ),
      );
  }
}