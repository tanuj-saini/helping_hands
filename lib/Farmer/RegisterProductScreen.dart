import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/FilePicker.dart';
import 'package:helping_hands/users/authContoller.dart';

class RegisterProductScreen extends ConsumerStatefulWidget {
  RegisterProductScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RegisterProductScreen();
  }
}

class _RegisterProductScreen extends ConsumerState<RegisterProductScreen> {
  final TextEditingController ProductNameContoller = TextEditingController();
  final TextEditingController PricePerKgController = TextEditingController();
  final TextEditingController MfgContoller = TextEditingController();
  final TextEditingController productDetailContoller = TextEditingController();
  final TextEditingController BestBeforeContoller = TextEditingController();
  File? bannerFile;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    PricePerKgController.dispose();
    ProductNameContoller.dispose();
    MfgContoller.dispose();
    BestBeforeContoller.dispose();
  }

  void sendProductRegister({
    required BuildContext context,
    required File productProfile,
    required String productName,
    required String PricePerKg,
    required String ProductDetails,
    required String manufacutingDatel,
    required String bestBefore,
  }) async {
    ref.watch(AuthContoller.notifier).sendProductRegister(
        ProductDetails: ProductDetails,
        context: context,
        productProfile: productProfile,
        productName: productName,
        PricePerKg: PricePerKg,
        manufacutingDatel: manufacutingDatel,
        bestBefore: bestBefore);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectedbannerImage,
                child: Container(
                  width: 400,
                  height: 200,
                  child: Center(
                    child: bannerFile == null
                        ? Text("Upload Product Image")
                        : DecoratedBox(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(bannerFile!)))),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color.fromARGB(
                          255, 63, 64, 65), // You can use any color you like.
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: ProductNameContoller,
                decoration: InputDecoration(
                  hintText: "Product Name",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: PricePerKgController,
                decoration: InputDecoration(
                  hintText: "PricePerKg",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: MfgContoller,
                decoration: InputDecoration(
                  hintText: "M.F.G",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                maxLines: 4,
                controller: productDetailContoller,
                decoration: InputDecoration(
                  hintText: "Product Details",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: BestBeforeContoller,
                decoration: InputDecoration(
                  hintText: "Months",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    sendProductRegister(
                        ProductDetails: productDetailContoller.text,
                        context: context,
                        productProfile: bannerFile!,
                        productName: ProductNameContoller.text,
                        PricePerKg: PricePerKgController.text,
                        manufacutingDatel: MfgContoller.text,
                        bestBefore: BestBeforeContoller.text);
                  },
                  child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
