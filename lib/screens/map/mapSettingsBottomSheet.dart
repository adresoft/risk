import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

MapType mapType = MapType.normal;

void mapSettingsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Harita Ayarları', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
                IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.close, color: Colors.black,))
              ],
            ),
            Row(
              children: [
                Expanded(child:
                ElevatedButton(onPressed: ()=> mapType=MapType.normal,child: Text('Varsayılan'),),
                ),
                Expanded(child:
                ElevatedButton(onPressed: ()=> mapType=MapType.hybrid,child: Text('Uydu ve Arazi'),),
                ),
                Expanded(child:
                ElevatedButton(onPressed: ()=> mapType=MapType.none,child: Text('Tanımsız'),),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}