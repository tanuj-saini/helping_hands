import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Orders/orderModule.dart';
import 'package:latlng/latlng.dart';

class FarmerLocation extends ConsumerStatefulWidget {
  final OrderModule orderModule;
  FarmerLocation({required this.orderModule, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerLocation();
  }
}

class _FarmerLocation extends ConsumerState<FarmerLocation> {
  @override
  Widget build(BuildContext context) {
    String DileveryLati = widget.orderModule.DileveryLati;
    double dileveryLati = double.parse(DileveryLati);

    String FarmerLati = widget.orderModule.FarmerLati;
    double fileveryLati = double.parse(FarmerLati);

    String DileveryLongi = widget.orderModule.DileveryLongi;
    double dileveryLongi = double.parse(DileveryLongi);

    String FarmerLogi = widget.orderModule.FarmerLogi;
    double farmerLogi = double.parse(FarmerLogi);

    // var center=LatLng((dileveryLati+fileveryLati)/2,(dileveryLongi+farmerLogi)/2);
    return Scaffold();
  }
}
