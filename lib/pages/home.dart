import 'package:flutter/material.dart';
import 'package:italk/pages/chats_screen.dart';
import 'package:italk/pages/discover_screen.dart';
import 'package:italk/pages/people_screen.dart';
import 'package:italk/widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  static final routeName = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curentIndex = 0;

  var screens = [
    ChatsScreen(),
    PeopleScreen(),
    DiscoverScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        curentIndex: curentIndex,
        onChanged: (v) {
          setState(() {
            curentIndex = v;
            print(v);
          });
        },
      ),
      body: screens[curentIndex],
    );
  }
}
