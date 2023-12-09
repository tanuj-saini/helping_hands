import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/ListOfProduct.dart';
import 'package:helping_hands/users/authContoller.dart';

class ConsumerScreen extends ConsumerStatefulWidget {
  ConsumerScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ConsumerScreen();
  }
}

class _ConsumerScreen extends ConsumerState<ConsumerScreen> {
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
          centerTitle: true,
          title: Text("Farmers Name"),
        ),
        body: StreamBuilder(
            stream: ref.watch(AuthContoller.notifier).getAllFarmer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoderScreen();
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No List Of Farmers"),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final famer = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ListOfProducts(
                              farmerModulel: famer,
                              farmerUId: famer.FarmerUid)));
                    },
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.white,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(famer.ProfilePic),
                          ),
                          title: Text(famer.name),
                        ),
                        Divider(
                          color: Colors.white,
                        )
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
