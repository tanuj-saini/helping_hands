import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Dilevery/DeliveryList.dart';
import 'package:helping_hands/Dilevery/DeliveryOrderList.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/users/authContoller.dart';

class DeliveryScreen extends ConsumerStatefulWidget {
  DeliveryScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ConsumerScreen();
  }
}

class _ConsumerScreen extends ConsumerState<DeliveryScreen> {
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

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ref.watch(productIdDelivery).when(
        data: (data) {
          final List<Widget> _pages = [
            DeliveryList(),
            data != null
                ? DeliveryScreenList(OrderId: data.OrderId)
                : DeliveryScreenList(OrderId: "")
          ];

          return Scaffold(
            body: _pages[_currentIndex], // Display the selected page.
            bottomNavigationBar: CupertinoTabBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_2_fill),
                  label: 'Register Product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart_fill),
                  label: 'Order Pending List',
                ),
              ],
            ),
          );
        },
        error: (err, token) {
          return showSnackBar(err.toString(), context);
        },
        loading: () => LoderScreen());
  }
}
