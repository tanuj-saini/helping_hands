import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Dilevery/Deliveryinfo.dart';
import 'package:helping_hands/Dilevery/DeliveryHomeScreen.dart';
import 'package:helping_hands/Farmer/FarmerInfo.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/ConsumerInfo.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapScreen extends ConsumerStatefulWidget {
  final String name;
  final double latitude;
  final double longitude;
  MapScreen(
      {required this.name,
      required this.latitude,
      required this.longitude,
      super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Map();
  }
}

class _Map extends ConsumerState<MapScreen> {
  dynamic address = "";

  @override
  Widget build(BuildContext context) {
    double Lati = widget.latitude;
    double Longi = widget.longitude;
    double Llatii = widget.latitude;
    double Llongi = widget.longitude;

    return Scaffold(
        appBar: AppBar(
          title: Text("Pick Up Location"),
          centerTitle: true,
        ),
        body: Stack(children: [
          OpenStreetMapSearchAndPick(
            locationPinText: "Pick Reminder Location",
            buttonTextColor: Colors.black,
            center: LatLong(Llatii, Llongi),
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
              Lati = pickedData.latLong.latitude;
              Longi = pickedData.latLong.longitude;
              address = pickedData.address;
              widget.name == "FarmerMap" || widget.name == "ConsumerMap"
                  ? Navigator.of(context).pop()
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => widget.name == "consumer"
                          ? ConsumerInfo(
                              address: address,
                            )
                          : widget.name == "delivery"
                              ? DileveryInfo(cuuAddress: address)
                              : FarmerInfo(address: address)));
            },
          ),
        ]));
  }
}
