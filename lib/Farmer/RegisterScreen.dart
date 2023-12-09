import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Farmer/RegisterProductScreen.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/users/authContoller.dart';

class FarmerProductRegister extends ConsumerStatefulWidget {
  FarmerProductRegister({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerProductRegister();
  }
}


class _FarmerProductRegister extends ConsumerState<FarmerProductRegister> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List of Products"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: ref.watch(AuthContoller.notifier).getProductList(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return Center(
                  child: Text("No Product is Selected"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoderScreen();
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var re = snapshot.data![index];
                        return ListTile(
                          title: Text(re.productName),
                        );
                      },
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => RegisterProductScreen()));
                      },
                      icon: Icon(Icons.save),
                      label: Text("Register")),
                ],
              );
            }));
  }
}
