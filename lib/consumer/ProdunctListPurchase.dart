import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Dilevery/OrderDetails.dart';
import 'package:helping_hands/Orders/orderModule.dart';
import 'package:helping_hands/consumer/ProductDetailsPurchase.dart';

class ProductDetailsPurchase extends ConsumerStatefulWidget {
  final OrderModule orderModule;
  ProductDetailsPurchase({super.key, required this.orderModule});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProductPurchase();
  }
}

class ProductPurchase extends ConsumerState<ProductDetailsPurchase> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ProductDetailsPurchaseList(
                orderModule: widget.orderModule,
              ))),
      child: Column(
        children: [
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 24,
          ),
          Container(
              child: Row(
            children: [
              CircleAvatar(
                  child: Image.network(
                widget.orderModule.productModule.productProfile,
              )),
              Column(
                children: [
                  Text(
                    widget.orderModule.productModule.productName,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.orderModule.productModule.ProductDetails,
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
            ],
          )),
          SizedBox(
            height: 25,
          ),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
    




//     return GestureDetector(
//       child: ListTile(
//         leading: CircleAvatar(
//             child: Image.network(
//           widget.orderModule.productModule.productProfile,
//         )),
//         trailing: Column(
//           children: [
//             Text(
//               widget.orderModule.productModule.productName,
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               widget.orderModule.productModule.ProductDetails,
//               style: TextStyle(color: Colors.white60),
//             )
//           ],
//         ),
        
//       ),
//        onTap: () =>
//                           ProductDetailsPurchaseList(orderId: 'fk'),
                    
//     );
//   }
// }
