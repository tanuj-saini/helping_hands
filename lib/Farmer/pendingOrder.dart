import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/users/authContoller.dart';

class PendingOrderList extends ConsumerStatefulWidget {
  final String OrderId;
  PendingOrderList({required this.OrderId, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PendingOrderList();
  }
}

class _PendingOrderList extends ConsumerState<PendingOrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.OrderId.isNotEmpty
            ? StreamBuilder(
                stream: ref
                    .watch(AuthContoller.notifier)
                    .getFarmerOrderList(OrderId: widget.OrderId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoderScreen();
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final varu = snapshot.data![index];
                      return ListTile(title: Text(varu.ConsumerName));
                    },
                  );
                },
              )
            : Center(
                child: Text("No Pending Orders"),
              ));
  }
}
