import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Farmer/FarmerModule.dart';
import 'package:helping_hands/Farmer/Productmodule.dart';
import 'package:helping_hands/Orders/orderModule.dart';
import 'package:helping_hands/constants/Storage.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/consumer/ConsumerInfo.dart';
import 'package:helping_hands/consumer/CosumerModule.dart';
import 'package:helping_hands/users/SignUpUser.dart';
import 'package:helping_hands/users/authRepo.dart';
import 'package:uuid/uuid.dart';

final AuthContoller =StateNotifierProvider<AuthController, bool>((ref) {
  final authRepo = ref.watch(AuthRepo);
  final Storage = ref.watch(StorageMethodProvider);
  return AuthController(
      storageMethod: Storage, ref: ref, authRepositry: authRepo);
});
final USerDetailsFormain = FutureProvider((ref) {
  final authRepo = ref.watch(AuthRepo);
  return authRepo.getUserDetails();
});
final productIdHome = FutureProvider((ref) {
  final authRepo = ref.watch(AuthRepo);
  return authRepo.getConsumerOrderDetails();
});

final productIdFarmer = FutureProvider((ref) {
  final authRepo = ref.watch(AuthRepo);
  return authRepo.getFarmerOrderDetails();
});
final productIdDelivery = FutureProvider((ref) {
  final authRepo = ref.watch(AuthRepo);
  return authRepo.getDeliveryOrderDetails();
});
final listOfUsers = StreamProvider.family((ref, String queue) {
  final authRepo = ref.watch(AuthRepo);
  return authRepo.UserName(queue);
});

class AuthController extends StateNotifier<bool> {
  final Ref ref;
  final AuthRepositry authRepositry;
  final StorageMethod storageMethod;

  AuthController(
      {required this.storageMethod,
      required this.ref,
      required this.authRepositry})
      : super(false);

  void SignInConsumer(
      {required String email,
      required String password,
      required BuildContext context}) {
        
        try{state=true;
          authRepositry.SignConsumer(
        email: email, context: context, password: password);
        state=false;}
        catch(e){}
    
  }

  void LoginInConsumer(
      {required String email,
      required String password,
      required BuildContext context}) {
        state=true;
    authRepositry.LoginConsumer(
        email: email, password: password, context: context);
        state=false;
  }

  void SignInFarmer(
      {required String email,
      required String password,
      required BuildContext context}) {
        state=true;
    authRepositry.SignFarmer(
        email: email, context: context, password: password);
        state=false;
  }

  void LoginInFarmer(
      {required String email,
      required String password,
      required BuildContext context}) {
        state=true;

    authRepositry.LoginFarmer(
        email: email, password: password, context: context);
        state=false;
  }

  void SignInDelivery(
      {required String email,
      required String password,
      required BuildContext context}) {
        state=true;
    authRepositry.SignDilivery(
        email: email, context: context, password: password);
        state=false;
  }

  void LoginInDelivery(
      {required String email,
      required String password,
      required BuildContext context}) {
        state=true;
    authRepositry.LoginDelivery(
        email: email, password: password, context: context);
        state=false;
  }

  void sendConsumerInfo(
      {required String name,
      required String emailAddress,
      required String PhoneNumberl,
      required String Address,
      required String ConsumerLati,
      required String ConsumerLogi,
      required BuildContext context,
      required File? profilePic}) async {
    if (profilePic != null) {
      state=true;
      var res = await storageMethod.uploadFile(
          uid: name,
          context: context,
          childname: "UserProfilePhoto",
          file: profilePic);

      authRepositry.SendConsumerInfo(
          ConsumerLati: ConsumerLati,
          ConsumerLogi: ConsumerLogi,
          name: name,
          emailAddress: emailAddress,
          PhoneNumberl: PhoneNumberl,
          Address: Address,
          ProfilePic: res,
          context: context);
          state=false;
          
    }
  }

  void sendFarmerInfo(
      {required String name,
      required String emailAddress,
      required String PhoneNumberl,
      required String Address,
      required BuildContext context,
      required String upiId,
      required String FarmerLati,
      required String FarmerLogi,
      required File? profilePic}) async {
    if (profilePic != null) {
      state=true;
      var res = await storageMethod.uploadFile(
          uid: name,
          context: context,
          childname: "UserProfilePhoto",
          file: profilePic);

      authRepositry.SendFarmerInfo(
          FarmerLogi: FarmerLogi,
          Farmerlati: FarmerLati,
          upiId: upiId,
          name: name,
          emailAddress: emailAddress,
          PhoneNumberl: PhoneNumberl,
          Address: Address,
          context: context,
          profilePic: res);
          state=false;
    }
  }

  Stream<List<FarmerModule>> getAllFarmer() {
    return authRepositry.getAllFarmerDetails();
  }

  Stream<List<ProductModule>> getAllProductFarmer({required String FarmerUid}) {
    return authRepositry.getProductFarmerList(farmerId: FarmerUid);
  }

  void sendDeliveryInfo(
      {required String name,
      required String emailAddress,
      required String PhoneNumberl,
      required String Address,
      required BuildContext context,
      required String DileveryLati,
      required String DileveryLongi,
      required File? profilePic}) async {
    if (profilePic != null) {
      state=true;
      var res = await storageMethod.uploadFile(
          uid: name,
          context: context,
          childname: "UserProfilePhoto",
          file: profilePic);

      authRepositry.SendDeliveryInfo(
          DileveryLati: DileveryLati,
          DileveryLongi: DileveryLongi,
          name: name,
          emailAddress: emailAddress,
          PhoneNumberl: PhoneNumberl,
          Address: Address,
          context: context,
          profilePic: res);
          state=false;
    }
  }

  void sendProductRegister({
    required BuildContext context,
    required File? productProfile,
    required String productName,
    required String PricePerKg,
    required String ProductDetails,
    required String manufacutingDatel,
    required String bestBefore,
  }) async {
    if (productProfile != null) {
      state=true;
      var res = await storageMethod.uploadFile(
          uid: "ProfilePic",
          context: context,
          childname: "UserProfilePhoto",
          file: productProfile);
      String ProductId = Uuid().v1();
      ProductModule productModule = ProductModule(
          ProductDetails: ProductDetails,
          productProfile: res,
          productName: productName,
          PricePerKg: PricePerKg,
          manufacutingDatel: manufacutingDatel,
          bestBefore: bestBefore,
          ProductId: ProductId,
          registerDate: DateTime.now());
      authRepositry.farmerProductDetails(
          productModule: productModule, context: context);
          state=false;
    } else {
      showSnackBar("Please Select Image", context);
    }
  }

  void sendOrderDetails({
    required ProductModule productModule,
    required String FarmerName,
    required String FarmerId,
    required String FarmerLati,
    required String FarmerLogi,
    required BuildContext context,
  }) async {
    state=true;
    authRepositry.sendOrderDetails(
        context: context,
        productModule: productModule,
        FarmerName: FarmerName,
        FarmerId: FarmerId,
        FarmerLati: FarmerLati,
        FarmerLogi: FarmerLogi);
        state=false;
  }

  Stream<List<ProductModule>> getProductList() {
    return authRepositry.getProductList();
  }

  Stream<List<OrderModule>> getOrderList({required String productId}) {
    return authRepositry.orderConsumerList(productId: productId);
  }

  Stream<List<OrderModule>> getFarmerOrderList({required String OrderId}) {
    return authRepositry.orderFarmerList(productId: OrderId);
  }

  Stream<List<OrderModule>> getDeliveryOrderList({required String OrderId}) {
    return authRepositry.orderDeliveryList(productId: OrderId);
  }
}
