import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Orders/orderModule.dart';

class ProductDetailsPurchaseList extends ConsumerStatefulWidget {
  final OrderModule orderModule;
  ProductDetailsPurchaseList({required this.orderModule, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProductDetails();
  }
}

class _ProductDetails extends ConsumerState<ProductDetailsPurchaseList> {
  @override
  Widget build(BuildContext context) {
    String OrderId = widget.orderModule.OrderId;
    String SellerName = widget.orderModule.FarmerName;
    String PriceOfProduct = widget.orderModule.productModule.PricePerKg;
    DateTime Date = widget.orderModule.createdAt;
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Divider(
                color: Colors.white,
              ),
              Text('Order ID - $OrderId'),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.orderModule.productModule.ProductDetails,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Seller: $SellerName '),
                        Text(
                          '₹ $PriceOfProduct',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )
                      ],
                    ),
                    CircleAvatar(
                      child: Image.network(
                        widget.orderModule.productModule.productProfile,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Align(
                child: Text("Order Confirmed, $Date"),
              )
            ],
          ),
        ));
  }
}
