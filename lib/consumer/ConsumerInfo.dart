import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helping_hands/constants/constansts/FilePicker.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/constants/constansts/MapScreen.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/users/authContoller.dart';

class ConsumerInfo extends ConsumerStatefulWidget {
  final dynamic address;
  ConsumerInfo({required this.address, super.key});
  @override
  ConsumerState<ConsumerInfo> createState() {
    return _UserInfoScreen();
  }
}

class _UserInfoScreen extends ConsumerState<ConsumerInfo> {
  File? bannerFile;
  final TextEditingController Namecontroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController PhoneNumberContoller = TextEditingController();

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
    super.initState();
    GetPermission();
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
    }
  }

  void sendInfoConsumer({
    required String name,
    required String emailAddress,
    required String PhoneNumberl,
    required String Address,
    required String ConsumereLati,
    required String ConsumereLogi,
    required File profilePic,
  }) { 
    ref.watch(AuthContoller.notifier).sendConsumerInfo(
        ConsumerLati: ConsumereLati,
        ConsumerLogi: ConsumereLogi,
        name: name,
        emailAddress: emailAddress,
        PhoneNumberl: PhoneNumberl,
        Address: Address,
        context: context,
        profilePic: profilePic);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();

    PhoneNumberContoller.dispose();
    Namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic add = widget.address;
    final size = MediaQuery.of(context).size;
    final TextEditingController addressContoller =
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
                          controller: addressContoller,
                          decoration: InputDecoration(
                            hintText: "Delivery Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => MapScreen(
                                            name: "consumer",
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
                        sendInfoConsumer(
                            ConsumereLati: latitudeCurr.toString(),
                            ConsumereLogi: longitudeCurr.toString(),
                            name: Namecontroller.text,
                            emailAddress: emailController.text,
                            PhoneNumberl: PhoneNumberContoller.text,
                            Address: addressContoller.text,
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
                      controller: PhoneNumberContoller,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email-Address",
                      ),
                    )
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
