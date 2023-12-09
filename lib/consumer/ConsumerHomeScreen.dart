import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/consumer/ConsumerScreen.dart';
import 'package:helping_hands/consumer/OrderListPage.dart';
import 'package:helping_hands/users/authContoller.dart';

class ConsumerHomeScreen extends ConsumerStatefulWidget {
  ConsumerHomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ConsumerScreen();
  }
}

class _ConsumerScreen extends ConsumerState<ConsumerHomeScreen> {
  int _currentIndex = 0; // To keep track of the selected tab.

  // Create a list of pages corresponding to each tab.

  @override
  Widget build(BuildContext context) {
    return ref.watch(productIdHome).when(
        data: (data) {
          final List<Widget> _pages = [
            ConsumerScreen(),
            data != null
                ? OrderListPage(
                    orderId: data.OrderId,
                  )
                : OrderListPage(orderId: "")
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
                  label: 'Farmer List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart_fill),
                  label: 'Order List',
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
