// home_page_screen.dart
import 'package:flutter/material.dart';
import 'package:muhkamat/quran_reading_screen.dart';
import 'package:quran/quran.dart' as quran;


class QuranScreen extends StatefulWidget {
  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  final List<String> buttonLabels = [
    "1. Al-Fatiha",
    "2. Al-Baqarah",
    "3. Al Imran",
    "4. Al-Nisaa",
    "5. Al-Maidah",
  ];

  String number = quran.getSurahName(16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Koran'),
      ),
      body: ListView.builder(
        itemCount: quran.totalSurahCount,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(0.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Makes it a perfect square
                  ),
                  minimumSize: Size(50, 70), // Adjust size as needed
                ),
                onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranReadingScreen(surahNumber: index + 1),
              ),
            );
          }, child: Align(
                alignment: Alignment.centerLeft, // Text nach links ausrichten
                child: Text("${index + 1}. ${quran.getSurahName(index + 1)}"),
              ),
          ));
        },
      ),
    );
  }
}