// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:risk/screens/map/animationFloatingActionButton.dart';
import 'package:risk/screens/map/appBar.dart';
import 'package:risk/screens/map/mapSettingsBottomSheet.dart';


Location location = Location();
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



  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.location_on_outlined, color: Colors.black,),
                title: Text('Hasanoğlan Bahçelievler, 06850 Elmadağ/Ankara'+' '+'', style: GoogleFonts.rajdhani(),),
              ),
              ListTile(
                leading: Icon(Icons.emergency_share_rounded, color: Colors.black,),
                title: Text('Kaza Sebepleri', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('%54 Kaza Sebep 1', style: GoogleFonts.rajdhani(),),
                    Text('%31 Kaza Sebep 2', style: GoogleFonts.rajdhani(),),
                    Text('%10 Kaza Sebep 3', style: GoogleFonts.rajdhani(),),
                    Text('%54 Kaza Sebep 4', style: GoogleFonts.rajdhani(),),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.ac_unit, color: Colors.black,),
                title: Text('Kazaların Yaşandığı Tarihler', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('%55 Kış - Ocak', style: GoogleFonts.rajdhani(),),
                    Text('%30 Sonbahar - Ekim', style: GoogleFonts.rajdhani(),),
                    Text('%10 İlkbahar - Mayıs', style: GoogleFonts.rajdhani(),),
                    Text('%30 Yaz - Haziran', style: GoogleFonts.rajdhani(),),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.access_time_outlined, color: Colors.black,),
                title: Text('Kazaların Yaşandığı Saatler', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('%60 Öğleden Önce - 07.54', style: GoogleFonts.rajdhani(),),
                    Text('%40 Öğleden Sonra - 20.45', style: GoogleFonts.rajdhani(),),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.cloud, color: Colors.black,),
                title: Text('Kazaların Yaşandığı Hava Durumu', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(leading: Icon(Icons.severe_cold, color: Colors.black,), title: Text('%60 Yağışlı', style: GoogleFonts.rajdhani(),)),
                    ListTile(leading: Icon(Icons.wb_sunny_outlined, color: Colors.black,),title: Text('%40 Açık', style: GoogleFonts.rajdhani(),)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  //location


  static late CameraPosition _cameraPosition = CameraPosition(
  bearing: 192.8334901395799,
  target: LatLng(39.96521,33.16189),
  tilt: 59.440717697143555,
  zoom: 19.151926040649414,
  );

  @override

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
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              buildingsEnabled: true,
trafficEnabled: true,
              mapType: mapType,
              initialCameraPosition: _cameraPosition,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onMapCreated: (map){},

circles: _circleSet(),

            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: AppBarWidget(),
              ),
            ),

          ],
        ),
        floatingActionButton: AnimationFloatingActionButton(),

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
      _showBottomSheet();
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