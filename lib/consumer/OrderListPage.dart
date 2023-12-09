import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/constants/constansts/Search.dart';
import 'package:helping_hands/consumer/ProductDetailsPurchase.dart';
import 'package:helping_hands/consumer/ProdunctListPurchase.dart';
import 'package:helping_hands/users/authContoller.dart';

class OrderListPage extends ConsumerStatefulWidget {
  final String orderId;
  OrderListPage({required this.orderId, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OrderList();
  }
}

class _OrderList extends ConsumerState<OrderListPage> {
  final TextEditingController searchContoller = TextEditingController();
  @override
  void dispose() {
    searchContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      //its a function inbuild
                      context: context,
                      delegate:
                          SearchUserTweet(OrderId: widget.orderId, ref: ref));
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: widget.orderId.isNotEmpty
            ? SafeArea(
                child: StreamBuilder(
                  stream: ref
                      .watch(AuthContoller.notifier)
                      .getOrderList(productId: widget.orderId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoderScreen();
                    }
                    return
                        // Row(
                        //   children: [
                        //     TextFormField(
                        //       controller: searchContoller,
                        //       decoration: InputDecoration(
                        //           hintText: 'Search your order here'),
                        //     )
                        //   ],
                        // ),
                        ListView.builder(
                      itemBuilder: (context, index) {
                        final varu = snapshot.data![index];
                        return ProductDetailsPurchase(orderModule: varu);
                      },
                    );
                  },
                ),
              )
            : Center(
                child: Text("No Product Buy"),
              ));
  }
}
