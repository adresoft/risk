import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import'dart:convert';

import '../screens/map/google_maps_view.dart';
import 'dart:convert';
import 'dart:io';


void main() {
  final jsonString = File('risk_points.json').readAsStringSync();
  final jsonData = jsonDecode(jsonString);
  final xKoordinat = jsonData['xKoordinat'];
  final yKoordinat = jsonData['yKoordinat'];
  final kazaSayisi = jsonData['kazaSayisi'];
  final kazaSekli = jsonData['kazaSekli'];

  final risk_points = <Map<String, dynamic>>{};

  for (final kaza in kazaSekli) {
    final kazaTipi = kaza['kazaTipi'];
    final adet = kaza['Adet'];
    final yuzde = kaza['%'];

    final risk_point = {
      'xKoordinat': xKoordinat,
      'yKoordinat': yKoordinat,
      'kazaSayisi': kazaSayisi,
      'kazaTipi': kazaTipi,
      'Adet': adet,
      '%': yuzde,
    };

    risk_points.add(risk_point);
  }

}
