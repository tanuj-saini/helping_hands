import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Farmer/FarmerModule.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/BuyScreen.dart';
import 'package:helping_hands/users/authContoller.dart';

class ListOfProducts extends ConsumerStatefulWidget {
  final String farmerUId;
  final FarmerModule farmerModulel;
  ListOfProducts(
      {required this.farmerModulel, required this.farmerUId, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ListOfProducts();
  }
}

class _ListOfProducts extends ConsumerState<ListOfProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Of Product"),
      ),
      body: StreamBuilder(
        stream: ref
            .watch(AuthContoller.notifier)
            .getAllProductFarmer(FarmerUid: widget.farmerUId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoderScreen();
          }
          if (snapshot.hasData == false) {
            return Center(
              child: Text("No Products to sell"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              final priceOfProduct = product.PricePerKg;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => BuyScreen(
                            farmerModule: widget.farmerModulel,
                            productName: product.productName,
                            productModule: product,
                          )));
                },
                child: Column(
                  children: [
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      title: Text(product.productName),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(product.productProfile),
                      ),
                      trailing: Text(
                        "₹$priceOfProduct",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
