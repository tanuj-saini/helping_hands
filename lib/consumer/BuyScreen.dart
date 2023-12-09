import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Farmer/FarmerModule.dart';
import 'package:helping_hands/Farmer/Productmodule.dart';
import 'package:helping_hands/consumer/PatymentScreen.dart';

class BuyScreen extends ConsumerStatefulWidget {
  final String productName;
  final FarmerModule farmerModule;
  final ProductModule productModule;
  BuyScreen(
      {required this.farmerModule,
      required this.productModule,
      required this.productName,
      super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BuyScreen();
  }
}

class _BuyScreen extends ConsumerState<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              child: Image.network(widget.productModule.productProfile),
              constraints: BoxConstraints.tight(Size.square(300))),
          Text(widget.productModule.productName),
          Text(widget.productModule.ProductDetails),
          Text(widget.productModule.PricePerKg),
          Text(widget.productModule.bestBefore),
          Text(widget.productModule.manufacutingDatel),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PaymentScreen(
                              farmerModule: widget.farmerModule,
                              productModule: widget.productModule,
                            )));
                  },
                  child: Text("Buy Now")),
              ElevatedButton(onPressed: () {}, child: Text("Add To Cart"))
            ],
          ),
        ],
      ),
    );
  }
}
