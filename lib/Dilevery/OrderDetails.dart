import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helping_hands/Dilevery/ConsumerLocation.dart';
import 'package:helping_hands/Dilevery/FarmerLocation.dart';
import 'package:helping_hands/Orders/orderModule.dart';
import 'package:helping_hands/constants/constansts/MapScreen.dart';

class OrderDetails extends ConsumerStatefulWidget {
  final OrderModule orderModule;
  OrderDetails({required this.orderModule, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OrderDetails();
  }
}

class _OrderDetails extends ConsumerState<OrderDetails> {
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

    String consumerLogi = widget.orderModule.ConsumerLogi;
    double ConsumerLogi = double.parse(consumerLogi);

    String ConsumerLati = widget.orderModule.ConsumerLati;
    double ConsumerConsumerLati = double.parse(ConsumerLati);
    double farmerDis = Geolocator.distanceBetween(
        dileveryLati, dileveryLongi, fileveryLati, farmerLogi);
    double cosumerDis = Geolocator.distanceBetween(
        dileveryLati, dileveryLongi, ConsumerConsumerLati, ConsumerLogi);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text("Distance Between Farmer and you is $farmerDis"),
            SizedBox(
              height: 30,
            ),
            Text("Distance Between Consumer and you is $cosumerDis "),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                              name: "FarmerMap",
                              latitude: fileveryLati,
                              longitude: farmerLogi)));
                    },
                    child: Text("FarmerLocation")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                              name: "ConsumerMap",
                              latitude: ConsumerConsumerLati,
                              longitude: ConsumerLogi)));
                    },
                    child: Text("ConsumerLocation")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
