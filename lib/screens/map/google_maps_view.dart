// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:risk/screens/map/bottomSheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:risk/screens/map/animationFloatingActionButton.dart';
import 'package:risk/screens/map/appBar.dart';
import 'package:risk/screens/map/mapSettingsBottomSheet.dart';
import 'package:flutter_tts/flutter_tts.dart';




Set<LatLng> riskPoints = {
  const LatLng(39.92447870431509, 33.21703466803235),
  const LatLng(39.96521,33.16189),
  const LatLng(39.95219428726504, 33.188385228779964),
  const LatLng(39.96503947341852, 33.1678746115696),
  const LatLng(39.966733597008115, 33.141701590708294),
};

Polygon ankara = const Polygon(
  polygonId: PolygonId('Ankara'),
  points: [
    LatLng(39.756,32.566),
    LatLng(39.870, 32.566),
    LatLng(40.153, 32.511),
    LatLng(40.162, 32.676),
    LatLng( 40.026, 32.842),
    LatLng( 39.809, 32.880),
    LatLng( 39.687, 32.811),
    LatLng( 39.697, 32.639),
    LatLng( 39.756, 32.566),
    LatLng(39.93236320706288, 32.65292041923445),
  ],
  strokeWidth: 2,
  strokeColor: Colors.red,
  fillColor: Colors.white,
);


class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({Key? key}) : super(key: key);

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late FlutterTts flutterTts;
  StreamSubscription<Position>? _positionStream;
  bool _showingWarning = false;

  Widget _buildWarning() {
    return _showingWarning
        ? GestureDetector(
      onTap: ()=> setState(() {
        _speak('Risk Noktasına Yaklaşıyorsunuz, Lütfen Hızınızı Düşürün!');
      }),
          child: Container(
            decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(5.0),
            ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Text(
          'Risk Noktasına Yaklaşıyorsunuz, Lütfen Hızınızı Düşürün!',
          style: TextStyle(color: Colors.white),
      ),
    ),
        )
        : SizedBox.shrink();
  }


  static late CameraPosition _cameraPosition = CameraPosition(
  bearing: 192.8334901395799,
  target: LatLng(39.96521,33.16189),
  tilt: 59.440717697143555,
  zoom: 19.151926040649414,
  );

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _getCurrentLocation();
    _positionStream = Geolocator.getPositionStream().listen((position) {
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
      });
    });
  }



  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titleTextStyle: GoogleFonts.rajdhani(color: Colors.black),
            icon: Icon(Icons.error_outline, color: Colors.black,),
            title: Text('Lütfen Konum Hizmetlerine İzin Verin!'),
          );
        },
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Kullanıcı konum erişimini vermedi, hata mesajı göster
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Lütfen Konum Erişimine İzin Verin!'),
            );
          },
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lütfen Ayarlardan Konum Hizmetlerine İzin Verin!'),
          );
        },
      );
      return;
    }
    _positionStream = Geolocator.getPositionStream().listen(_onPositionUpdate);
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("tr-TR"); // Dil ayarlaması
    await flutterTts.setPitch(1); // Ses perdesi
    await flutterTts.setSpeechRate(0.7); // Konuşma hızı
    await flutterTts.speak(text); // Metni oku
  }

  void dispose() {
    super.dispose();
    flutterTts.stop();
    _positionStream?.cancel();
  }

  void _onPositionUpdate(Position position) {
    for(LatLng riskPoint in riskPoints) {
      double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          riskPoint.latitude,
          riskPoint.longitude
      );

      int distanceValue;

      if(speed >= 1 && speed <= 80){
        distanceValue = 200;
      }
      else if(speed >= 81 && speed <= 100) {
        distanceValue = 300;
      }
      else if(speed >= 101 && speed <= 120){
        distanceValue = 400;
      }
      else if(speed >= 121 && speed >= 140){
        distanceValue = 500;
      }
      else{
        distanceValue = 800;
      }

      if (distance <= distanceValue) {
        _showWarning();
        Timer(Duration(seconds: 10), () {
          _hideWarning();
        });
      }
    }
  }

  void _showWarning() {
    setState(() {
      _showingWarning = true;
    });
  }
  void _hideWarning() {
    setState(() {
      _showingWarning = false;
    });
  }


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              compassEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              buildingsEnabled: true,
              trafficEnabled: traffic,
              mapType: mapType,
              initialCameraPosition: _cameraPosition,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (map){},
              polygons: {ankara},
              circles: _circleSet(),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: AppBarWidget(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildWarning(),
              ),
              ),
          ],
        ),
        floatingActionButton: const AnimationFloatingActionButton(),

      ),
    );
  }



 //


  



Set<Circle> _circleSet(){
  return <Circle>{

  Circle(circleId: const CircleId('MQdYvdUs1IJSbqJBmx0D'),
    center: const LatLng(39.96521,33.16189),
    fillColor: Colors.red.withOpacity(0.5),
    radius: 50,
    strokeWidth: 0,
    onTap: (){
    setState(() {
    riskPointBottomSheet(context);
    });
    },
    consumeTapEvents: true,
  ),
    Circle(circleId: CircleId('aaa'),
      center: LatLng(39.92447870431509, 33.21703466803235),
      fillColor: Colors.red.withOpacity(0.5),
      radius: 20,
      strokeWidth: 0,
    ),
    Circle(circleId: CircleId('bbb'),
      center: LatLng(39.95219428726504, 33.188385228779964),
      fillColor: Colors.blue.withOpacity(0.5),
      radius: 20,
      strokeWidth: 0,
    ),
    Circle(circleId: CircleId('ccc'),
      center: LatLng(39.96503947341852, 33.1678746115696),
      fillColor: Colors.orange.withOpacity(0.5),
      radius: 20,
      strokeWidth: 0,
    ),
    Circle(circleId: CircleId('ddd'),
      center: LatLng(39.93236320706288, 32.65292041923445),
      fillColor: Colors.red.withOpacity(0.5),
      radius: 20,
      strokeWidth: 0,
    ),
  };
}
}