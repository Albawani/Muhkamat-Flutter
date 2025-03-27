// home_page_screen.dart
import 'package:flutter/material.dart';
import 'package:muhkamat/home_screen.dart';
import 'package:muhkamat/prayer_screen.dart';
import 'package:muhkamat/quran_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {int currentPageIndex = 0;

@override
Widget build(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return Scaffold(
    bottomNavigationBar: NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.book_rounded)),
          label: 'Quran',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.access_time)),
          label: 'Prayer Time',
        ),
      ],
    ),
    body:
    <Widget>[
      /// Home page
      HomeScreen(),

      /// Notifications page
      QuranScreen(),

      /// Messages page
      PrayerScreen(),
    ][currentPageIndex],
  );
}
}