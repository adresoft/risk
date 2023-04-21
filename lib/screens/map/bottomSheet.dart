import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void riskPointBottomSheet(BuildContext context) {
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