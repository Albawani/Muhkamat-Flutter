import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_flutter/quran_flutter.dart';

class QuranReadingScreen extends StatefulWidget {
  final int surahNumber;

  QuranReadingScreen({required this.surahNumber});

  @override
  State<QuranReadingScreen> createState() => _QuranReadingScreenState();
}

class _QuranReadingScreenState extends State<QuranReadingScreen> {
  @override
  Widget build(BuildContext context) {
    // Initialize the PageController with the starting page based on surahNumber
    PageController _pageController = PageController(
      initialPage: Quran.getPageNumber(surahNumber: widget.surahNumber, verseNumber: 1), // Correct the initial page index
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Quran Reading"),
      ),
      body: PageView.builder(
        itemCount: Quran.pageCount, // Total pages count in the Quran
        controller: _pageController,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(Quran.getTotalVersesInPage(index + 1), (i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Quran.getVerse(surahNumber: widget.surahNumber, verseNumber: i + 1).text,
                    style: GoogleFonts.amiriQuran(),
                  ),);
              }
              ),
            ),
          );
        },
      ),
    );
  }
}

// Arabic
/*
// Safely access the verse text and start from index 1
                  int verseIndex = i + 1; // Adjusting index to be 1-based
                  if (verseIndex <= verseTexts.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        verseTexts[i],
                        style: GoogleFonts.amiriQuran(),
                      ),
                    );
                  } else {
                    return Container(); // Return an empty container if index is out of bounds
                  }
 */