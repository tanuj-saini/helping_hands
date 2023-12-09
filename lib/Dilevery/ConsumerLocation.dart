import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Orders/orderModule.dart';

class ConsumerLocation extends ConsumerStatefulWidget {
  final OrderModule orderModule;

  ConsumerLocation({required this.orderModule, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ConsumerLocation();
  }
}

class _ConsumerLocation extends ConsumerState<ConsumerLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
