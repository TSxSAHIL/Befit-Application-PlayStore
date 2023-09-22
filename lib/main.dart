// ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors, constant_identifier_names, duplicate_ignore, non_constant_identifier_names, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:befit/data/workout_data.dart';
import 'package:befit/screens/exersice.dart';
import 'package:befit/screens/feedback.dart';
import 'package:befit/screens/my_drawer_header.dart';
import 'package:befit/screens/onerepmax.dart';
import 'package:befit/screens/splash.dart';
import 'package:befit/screens/support_us.dart';
import 'package:befit/screens/workout.dart';
import 'package:flutter/material.dart';
import 'package:befit/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:befit/screens/firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("workout_database");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        title: 'BMI Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSection.Workout;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSection.Workout) {
      container = const Workout();
    } else if (currentPage == DrawerSection.BMI_Calculator) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSection.Water_Log) {
      container = const ExpansionTileExample();
    }else if(currentPage == DrawerSection.onerepmax){
      container = const OneRepMax();
    }
     else if (currentPage == DrawerSection.Support_us) {
      container = const SupportUsPage();
    } else if (currentPage == DrawerSection.send_feedback) {
      container = const FeedbackPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentHexColor,
        title: Text("BeFit - Workout Tracker"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Workout Tracker", Icons.dashboard_outlined,
              currentPage == DrawerSection.Workout ? true : false),
          menuItem(2, "Workout Planner ", Icons.book,
              currentPage == DrawerSection.Water_Log ? true : false),
          menuItem(3, "BMI Calculator", Icons.calculate_outlined,
              currentPage == DrawerSection.BMI_Calculator ? true : false),
          menuItem(4, "1RM Calculator", Icons.calculate_sharp,
              currentPage == DrawerSection.onerepmax ? true : false),
          const Divider(),
          menuItem(5, "Support Us", Icons.notifications_outlined,
              currentPage == DrawerSection.Support_us ? true : false),
          menuItem(6, "Send Feedback", Icons.mail_outlined,
              currentPage == DrawerSection.send_feedback ? true : false),
          const Divider(),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      // ignore: prefer_const_constructors
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSection.Workout;
            } else if (id == 2) {
              currentPage = DrawerSection.Water_Log;
            } else if (id == 3) {
              currentPage = DrawerSection.BMI_Calculator;
            } else if (id == 4) {
              currentPage = DrawerSection.onerepmax;
            } else if (id == 5) {
              currentPage = DrawerSection.Support_us;
            } else if (id == 6) {
              currentPage = DrawerSection.send_feedback;
            }
          });
        },
        // ignore: prefer_const_constructors
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  Workout,
  BMI_Calculator,
  Water_Log,
  Support_us,
  send_feedback,
  onerepmax,
}
