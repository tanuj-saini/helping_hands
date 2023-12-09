import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helping_hands/constants/constansts/FilePicker.dart';
import 'package:helping_hands/constants/constansts/MapScreen.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/users/authContoller.dart';

class FarmerInfo extends ConsumerStatefulWidget {
  final dynamic address;
  FarmerInfo({required this.address, super.key});
  @override
  ConsumerState<FarmerInfo> createState() {
    return _UserInfoScreen();
  }
}

class _UserInfoScreen extends ConsumerState<FarmerInfo> {
  final TextEditingController Namecontroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController PhoneNumberContoller = TextEditingController();
  final TextEditingController upiIDcontroller = TextEditingController();
  File? bannerFile;
  void sendInfoFarmer({
    required String name,
    required String emailAddress,
    required String PhoneNumberl,
    required String Address,
    required File profilePic,
    required String FarmerLati,
    required String FarmerLogi,
    required String upiId,
  }) async {
    ref.watch(AuthContoller.notifier).sendFarmerInfo(
        FarmerLati: FarmerLati,
        FarmerLogi: FarmerLogi,
        upiId: upiId,
        name: name,
        emailAddress: emailAddress,
        PhoneNumberl: PhoneNumberl,
        Address: Address,
        context: context,
        profilePic: profilePic);
  }

  void selectedbannerImage() async {
    final res = await pickkImage();
    print(res);
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    GetPermission();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    PhoneNumberContoller.dispose();

    Namecontroller.dispose();
  }

  double latitudeCurr = 23.258793662844607;
  double longitudeCurr = 72.64952768698122;
  void GetPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showSnackBar("Permission Not Allowed", context);
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Latitiude" + currentLocation.latitude.toString());
      print("Latitiude" + currentLocation.longitude.toString());
      setState(() {
        latitudeCurr = currentLocation.latitude;

        longitudeCurr = currentLocation.longitude;
      });

      //Geolocator.distanceBetween(currentLocation.latitude,currentLocation.longitude, endLatitude, endLongitude)
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dynamic add = widget.address;
    final TextEditingController sellingAddressContoller =
        TextEditingController(text: add.isNotEmpty ? "$add" : "");

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(children: [
                bannerFile == null
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2paNURw1DBfUC5w4I3m3EoIo7vHLpWxtXCg&usqp=CAU'),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(bannerFile!),
                      ),
                Positioned(
                    child: IconButton(
                        onPressed: selectedbannerImage,
                        icon: const Icon(Icons.add)))
              ]),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: sellingAddressContoller,
                          decoration: InputDecoration(
                            hintText: "Delivery Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => MapScreen(
                                            name: "farmer",
                                            latitude: latitudeCurr,
                                            longitude: longitudeCurr,
                                          )));
                                },
                                icon: Icon(Icons.location_on_outlined)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: Namecontroller,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Name",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        sendInfoFarmer(
                            FarmerLati: latitudeCurr.toString(),
                            FarmerLogi: longitudeCurr.toString(),
                            upiId: upiIDcontroller.text,
                            name: Namecontroller.text,
                            emailAddress: emailController.text,
                            PhoneNumberl: PhoneNumberContoller.text,
                            Address: sellingAddressContoller.text,
                            profilePic: bannerFile!);
                      },
                      icon: const Icon(Icons.done)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email-Address",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: upiIDcontroller,
                      decoration: InputDecoration(
                        hintText: "Upi-Id",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: PhoneNumberContoller,
                      decoration: InputDecoration(
                        hintText: "PhoneNumber",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
