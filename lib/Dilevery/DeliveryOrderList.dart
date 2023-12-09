import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Dilevery/OrderDetails.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/OrderListPage.dart';
import 'package:helping_hands/users/authContoller.dart';

class DeliveryScreenList extends ConsumerStatefulWidget {
  final String OrderId;
  DeliveryScreenList({required this.OrderId, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DeliveryOrderList();
  }
}

class _DeliveryOrderList extends ConsumerState<DeliveryScreenList> {
  @override
  Widget build(BuildContext context) {
    print(widget.OrderId);
    return Scaffold(
        body: widget.OrderId.isNotEmpty
            ? StreamBuilder(
                stream: ref
                    .watch(AuthContoller.notifier)
                    .getDeliveryOrderList(OrderId: widget.OrderId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoderScreen();
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final varu = snapshot.data![index];
                      return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      OrderDetails(orderModule: varu))),
                          child: ListTile(
                              title: Text(varu.productModule.productName)));
                    },
                  );
                },
              )
            : Center(
                child: Text("No Pending Orders"),
              ));
  }
}
