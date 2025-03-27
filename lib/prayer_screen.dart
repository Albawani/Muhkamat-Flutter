import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';


class PrayerScreen extends StatefulWidget {
  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  Position? _currentPosition;
  PrayerTimes? _prayerTimes;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.checkPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }


    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _calculatePrayerTimes();
    });
  }

  void _calculatePrayerTimes() {
    if (_currentPosition == null) return;

    final coordinates = Coordinates(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    final params = CalculationMethod.turkey.getParameters();
    final prayerTimes = PrayerTimes.today(coordinates, params);

    setState(() {
      _prayerTimes = prayerTimes;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gebetszeiten'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _prayerTimes == null
                ? CircularProgressIndicator()
            :
            Table(
              columnWidths: {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
              children: [
                _buildRow("Fajr", _prayerTimes!.fajr),
                _buildRow("Sonnenaufgang", _prayerTimes!.sunrise),
                _buildRow("Dhuhr", _prayerTimes!.dhuhr),
                _buildRow("Asr", _prayerTimes!.asr),
                _buildRow("Maghrib", _prayerTimes!.maghrib),
                _buildRow("Isha", _prayerTimes!.isha),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String prayerName, DateTime time) {
    return TableRow(children: [
      Center(
          child: Text(prayerName, style: TextStyle(fontSize: 18))
      ),
      Center(
        child: Text("${time.hour}:${time.minute.toString().padLeft(2, '0')}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    ]);
  }
}