// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_escapes, no_leading_underscores_for_local_identifiers, duplicate_ignore, sized_box_for_whitespace, prefer_final_fields, unused_import
import 'package:befit/constants/app_constants.dart';
import 'package:befit/screens/feedback.dart';
import 'package:befit/screens/support_us.dart';
import 'package:befit/screens/workout.dart';
import 'package:befit/widgets/left_bar.dart';
import 'package:befit/widgets/right_bar.dart';
import 'package:flutter/material.dart';
import 'my_drawer_header.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;
  String _textResult = "";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: mainHexColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  child: TextField(
                    controller: _heightController,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor),
                    keyboardType: TextInputType.number,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Height ",
                      // ignore: prefer_const_constructors
                      hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  child: TextField(
                    controller: _weightController,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor),
                    keyboardType: TextInputType.number,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Weight",
                      // ignore: prefer_const_constructors
                      hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                double _h = double.parse(_heightController.text);
                double _w = double.parse(_weightController.text);
                setState(() {
                  _bmiResult = _w /(_h * _h) *10000;
                    if(_bmiResult > 25){
                      _textResult = "You\'re over weight";
                    } else if(_bmiResult >= 18.5 && _bmiResult <= 25){
                      _textResult = "You have normal weight";
                    }else{
                      _textResult = "You\'re under weight";
                    }
                });
              },
              child: Container(
                child: Text(
                  "Calculate",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: accentHexColor),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                _bmiResult.toStringAsFixed(2),
                style: TextStyle(fontSize: 90, color: accentHexColor),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Visibility(
              visible: _textResult.isNotEmpty,
              child: Container(
                child: Text(
                  _textResult,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: accentHexColor),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LeftBar(
              barWidth: 40,
            ),
            SizedBox(
              height: 20,
            ),
            LeftBar(
              barWidth: 70,
            ),
            SizedBox(
              height: 20,
            ),
            LeftBar(
              barWidth: 40,
            ),
            SizedBox(
              height: 20,
            ),
            RightBar(
              barWidth: 70,
            ),
            SizedBox(
              height: 20,
            ),
            RightBar(
              barWidth: 70,
            ),
          ],
        ),
      ),
      
    );
  }
  
}

