import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helping_hands/Dilevery/DeliveryModule.dart';
import 'package:helping_hands/Dilevery/Deliveryinfo.dart';
import 'package:helping_hands/Dilevery/DeliveryHomeScreen.dart';
import 'package:helping_hands/Farmer/FarmerHomeScreen.dart';
import 'package:helping_hands/Farmer/FarmerInfo.dart';
import 'package:helping_hands/Farmer/FarmerModule.dart';
import 'package:helping_hands/Farmer/Productmodule.dart';
import 'package:helping_hands/Farmer/RegisterScreen.dart';
import 'package:helping_hands/Orders/orderModule.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/consumer/ConsumerHomeScreen.dart';
import 'package:helping_hands/consumer/ConsumerInfo.dart';
import 'package:helping_hands/consumer/ConsumerScreen.dart';
import 'package:helping_hands/consumer/CosumerModule.dart';
import 'package:helping_hands/consumer/OrderListPage.dart';
import 'package:uuid/uuid.dart';

final AuthRepo = Provider((ref) => AuthRepositry(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance));

class AuthRepositry {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepositry({required this.firebaseAuth, required this.firebaseFirestore});

  void SignConsumer(
      {required String email,
      required BuildContext context,
      required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      showSnackBar("Succesfully Created Consumer", context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ConsumerInfo(
                address: "",
              )));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void triggerNotification(
      {required String text, required String reminderbody}) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 778899,
      channelKey: "778899",
      title: text,
      body: reminderbody,
    ));
  }

  void LoginConsumer(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      showSnackBar("Succesfully Login Consumer", context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => ConsumerHomeScreen()));
    } on FirebaseAuthException catch (e) {}
  }

  Future<FarmerModule?> getFarmerDetails() async {
    var userData = await firebaseFirestore
        .collection('farmer')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    FarmerModule? user;
    if (userData.data() != null) {
      user = FarmerModule.fromMap(userData.data()!);
    }

    return user;
  }

  Future<ConsumerModule?> getConsumerDetails() async {
    var userData = await firebaseFirestore
        .collection('consumer')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    ConsumerModule? user;
    if (userData.data() != null) {
      user = ConsumerModule.fromMap(userData.data()!);
    }

    return user;
  }

  Future<DeliveryModule?> getUserDetails() async {
    var userData = await firebaseFirestore
        .collection(
          'delivery',
        )
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    DeliveryModule? user;
    if (userData.data() != null) {
      user = DeliveryModule.fromMap(userData.data()!);
    }

    return user;
  }

  void SignFarmer(
      {required String email,
      required BuildContext context,
      required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      showSnackBar("Succesfully Created Farmer", context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => FarmerInfo(
                address: "",
              )));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void LoginFarmer(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      showSnackBar("Succesfully Login Farmer", context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => FarmerHomeScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void SignDilivery(
      {required String email,
      required BuildContext context,
      required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      showSnackBar("Succesfully Created Delivery", context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => DileveryInfo(
                cuuAddress: "",
              )));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void LoginDelivery(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      showSnackBar("Succesfully Login Delivery", context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => DeliveryScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void SendConsumerInfo(
      {required String name,
      required String emailAddress,
      required String PhoneNumberl,
      required String Address,
      required String ConsumerLati,
      required String ConsumerLogi,
      required String ProfilePic,
      required BuildContext context}) async {
    try {
      ConsumerModule consumerModule = ConsumerModule(
          ConsumerLati: ConsumerLati,
          ConsumerLogi: ConsumerLogi,
          ConsumerId: firebaseAuth.currentUser!.uid,
          name: name,
          emailAddress: emailAddress,
          PhoneNumberl: PhoneNumberl,
          Address: Address,
          ProfilePic: ProfilePic);
      await firebaseFirestore
          .collection("consumer")
          .doc(firebaseAuth.currentUser!.uid)
          .set(consumerModule.toMap());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => ConsumerHomeScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void SendFarmerInfo(
      {required String name,
      required String emailAddress,
      required String PhoneNumberl,
      required String Address,
      required String upiId,
      required String Farmerlati,
      required String FarmerLogi,
      required BuildContext context,
      required String profilePic}) async {
    try {
      FarmerModule farmerModule = FarmerModule(
          FarmerLogi: FarmerLogi,
          Farmerlati: Farmerlati,
          upiId: upiId,
          name: name,
          emailAddress: emailAddress,
          SeelingAddress: Address,
          FarmerUid: firebaseAuth.currentUser!.uid,
          PhoneNumber: PhoneNumberl,
          ProfilePic: profilePic);
      await firebaseFirestore
          .collection("farmer")
          .doc(firebaseAuth.currentUser!.uid)
          .set(farmerModule.toMap());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => FarmerHomeScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void SendDeliveryInfo(
      {required String name,
      required String emailAddress,
      required String PhoneNumberl,
      required String Address,
      required String DileveryLati,
      required String DileveryLongi,
      required BuildContext context,
      required String profilePic}) async {
    try {
      DeliveryModule deliveryModule = DeliveryModule(
          DileveryLati: DileveryLati,
          DileveryLongi: DileveryLongi,
          name: name,
          PhoneNumber: PhoneNumberl,
          emailAddress: emailAddress,
          DeliveryUid: firebaseAuth.currentUser!.uid,
          DeliveryProfilePic: profilePic);

      await firebaseFirestore
          .collection("delivery")
          .doc(firebaseAuth.currentUser!.uid)
          .set(deliveryModule.toMap());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => DeliveryScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void farmerProductDetails(
      {required ProductModule productModule,
      required BuildContext context}) async {
    try {
      await firebaseFirestore
          .collection('farmer')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("ProductRegister")
          .doc(productModule.ProductId)
          .set(productModule.toMap());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => FarmerHomeScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Stream<List<FarmerModule>> getAllFarmerDetails() {
    return firebaseFirestore.collection('farmer').snapshots().map((event) {
      final List<FarmerModule> listFM = [];
      for (var document in event.docs) {
        listFM.add(FarmerModule.fromMap(document.data()));
      }
      return listFM;
    });
  }

  Stream<List<ProductModule>> getProductFarmerList({required String farmerId}) {
    return firebaseFirestore
        .collection("farmer")
        .doc(farmerId)
        .collection("ProductRegister")
        .snapshots()
        .map((event) {
      final List<ProductModule> product = [];
      for (var document in event.docs) {
        product.add(ProductModule.fromMap(document.data()));
      }
      return product;
    });
  }

  void sendOrderDetails({
    required ProductModule productModule,
    required String FarmerName,
    required String FarmerId,
    required String FarmerLati,
    required String FarmerLogi,
    required BuildContext context,
  }) async {
    List<ConsumerModule> lis = [];
    List<DeliveryModule> dm = [];

    try {
      final consumerQuerySnapshot = await firebaseFirestore
          .collection("consumer")
          .where('ConsumerId', isEqualTo: firebaseAuth.currentUser!.uid)
          .get();

      for (var document in consumerQuerySnapshot.docs) {
        lis.add(ConsumerModule.fromMap(document.data()));
      }

      final deliveryQuerySnapshot =
          await firebaseFirestore.collection("delivery").get();

      for (var document in deliveryQuerySnapshot.docs) {
        dm.add(DeliveryModule.fromMap(document.data()));
      }

      double distance = 10000000;
      int x = 0;

      for (int i = 0; i < dm.length; i++) {
        double Dlati = double.parse(dm[i].DileveryLati);
        double Dlongi = double.parse(dm[i].DileveryLongi);
        double Flati = double.parse(FarmerLati);
        double Flogi = double.parse(FarmerLogi);
        double dis = Geolocator.distanceBetween(Dlati, Dlongi, Flati, Flogi);
        if (distance > dis) {
          distance = dis;
          x = i;
        }
      }
      String OrderId = Uuid().v1();

      OrderModule orderModule = OrderModule(
        OrderId: OrderId,
        createdAt: DateTime.now(),
        productModule: productModule,
        FarmerName: FarmerName,
        FarmerLogi: FarmerLogi,
        FarmerLati: FarmerLati,
        FarmerId: FarmerId,
        ConsumerId: lis[0].ConsumerId,
        ConsumerName: lis[0].name,
        ConsumerLogi: lis[0].ConsumerLogi,
        ConsumerLati: lis[0].ConsumerLati,
        DileveryName: dm[x].name,
        DileveryLati: dm[x].DileveryLati,
        DileveryLongi: dm[x].DileveryLongi,
        DileveryId: dm[x].DeliveryUid,
      );

      await firebaseFirestore
          .collection("Orders")
          .doc(OrderId)
          .set(orderModule.toMap());

      triggerNotification(
        text: "New Order has Come",
        reminderbody: lis[0].PhoneNumberl,
      );

      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => OrderListPage(
                orderId: OrderId,
              )));
    } catch (e) {}
  }

  Stream<List<OrderModule>> orderConsumerList({required String productId}) {
    return firebaseFirestore
        .collection("Orders")
        .where('ConsumerId', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((event) {
      final List<OrderModule> ordersList = [];
      for (var document in event.docs) {
        ordersList.add(OrderModule.fromMap(document.data()));
      }
      return ordersList;
    });
  }

  Stream<List<OrderModule>> orderFarmerList({required String productId}) {
    return firebaseFirestore
        .collection("Orders")
        .where('FarmerId', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((event) {
      final List<OrderModule> ordersList = [];
      for (var document in event.docs) {
        ordersList.add(OrderModule.fromMap(document.data()));
      }
      return ordersList;
    });
  }

  Stream<List<OrderModule>> orderDeliveryList({required String productId}) {
    return firebaseFirestore
        .collection("Orders")
        .where('DileveryId', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((event) {
      final List<OrderModule> ordersList = [];
      for (var document in event.docs) {
        ordersList.add(OrderModule.fromMap(document.data()));
      }
      return ordersList;
    });
  }

  Future<OrderModule?> getConsumerOrderDetails() async {
    var userData = await firebaseFirestore
        .collection('Orders')
        .where("ConsumerId", isEqualTo: firebaseAuth.currentUser!.uid)
        .get();
    OrderModule? orderModule;
    for (var document in userData.docs) {
      orderModule = OrderModule.fromMap(document.data());
    }
    //   FarmerModule? user;
    //   if (userData.data() != null) {
    //     user = FarmerModule.fromMap(userData.data()!);
    //   }

    //   return user;
    // }
    return orderModule;
  }

  Future<OrderModule?> getFarmerOrderDetails() async {
    var userData = await firebaseFirestore
        .collection('Orders')
        .where("FarmerId", isEqualTo: firebaseAuth.currentUser!.uid)
        .get();
    OrderModule? orderModule;
    for (var document in userData.docs) {
      orderModule = OrderModule.fromMap(document.data());
    }

    return orderModule;
  }

  Future<OrderModule?> getDeliveryOrderDetails() async {
    var userData = await firebaseFirestore
        .collection('Orders')
        .where("DileveryId", isEqualTo: firebaseAuth.currentUser!.uid)
        .get();
    OrderModule? orderModule;
    for (var document in userData.docs) {
      orderModule = OrderModule.fromMap(document.data());
    }

    return orderModule;
  }

  Stream<List<OrderModule>> UserName(String queue) {
    return firebaseFirestore
        .collection('Orders')
        .where('productModule.productName',
            isGreaterThanOrEqualTo: queue.isEmpty ? 0 : queue,
            isLessThan: queue.isEmpty
                ? null
                : queue.substring(0, queue.length - 1) +
                    String.fromCharCode(
                      queue.codeUnitAt(queue.length - 1) + 1,
                    ))
        .snapshots()
        .map((event) {
      List<OrderModule> commuinties = [];
      for (var document in event.docs) {
        var commuinty = OrderModule.fromMap(document.data());
        commuinties.add(commuinty);
      }
      return commuinties;
    });
  }

  Stream<List<ProductModule>> getProductList() {
    return firebaseFirestore
        .collection("farmer")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("ProductRegister")
        .snapshots()
        .map((event) {
      final List<ProductModule> product = [];
      for (var document in event.docs) {
        product.add(ProductModule.fromMap(document.data()));
      }
      return product;
    });
  }
}
