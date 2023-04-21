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
LatLng( 39.756, 32.566),],
  strokeWidth: 2,
  strokeColor: Colors.red,
  fillColor: Colors.transparent,
);

double? speed;

/*speedFunction() {
  print(location.onLocationChanged.listen((LocationData currentLocation) {
    speed = currentLocation.speed ?? 0;
  }));
}*/

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({Key? key}) : super(key: key);

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late FlutterTts flutterTts;

  bool _showingWarning = false;

 /* algoritm() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return AlertDialog(
        title: Text('Lütfen Konum Hizmetlerine İzin Verin!'),
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Kullanıcı konum erişimini vermedi, hata mesajı göster
        return AlertDialog(
          title: Text('Lütfen Konum Erişimine İzin Verin!'),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return AlertDialog(
        title: Text('Lütfen Ayarlardan Konum Hizmetlerine İzin Verin!'),
      );
    }

    Position position = await Geolocator.getCurrentPosition();

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
        39.90636764745673, 33.221895565809035,
    );

    if (distance <= 150) {
      // Kullanıcı çemberin içinde veya çemberin yakınında, widget göster
      _showWarning();
      Timer(Duration(seconds: 10), () {
        _hideWarning();
      });
    }
  }*/



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


  //location


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
  }

  var _positionStream;

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
        39.90737782488754, 33.22217606444013
    );

    if (distance <= 150) {
      // Kullanıcı çemberin içinde veya çemberin yakınında, widget göster
      _showWarning();
      Timer(Duration(seconds: 10), () {
        _hideWarning();
      });
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
              compassEnabled: false,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              buildingsEnabled: false,
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
    Circle(circleId: CircleId('bbb'),
      center: LatLng(39.9172800,33.2324753),
      fillColor: Colors.red.withOpacity(0.5),
      radius: 3,
      strokeWidth: 0,
    ),
    Circle(circleId: CircleId('ccc'),
      center: LatLng(39.9168835,33.2318066),
      fillColor: Colors.blue.withOpacity(0.5),
      radius: 16,
      strokeWidth: 0,
    ),
    Circle(circleId: CircleId('ddd'),
      center: LatLng(39.9199002,33.2350055),
      fillColor: Colors.blue.withOpacity(0.5),
      radius: 16,
      strokeWidth: 0,
    ),
    Circle(circleId: CircleId('eee'),
      center: LatLng(39.920235,33.233821),
      fillColor: Colors.red.withOpacity(0.5),
      radius: 7,
      strokeWidth: 0,
    ),
  };
}
}