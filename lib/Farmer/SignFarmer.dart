import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Farmer/LoginFarmer.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/LoginConsumer.dart';
import 'package:helping_hands/users/authContoller.dart';
import 'package:helping_hands/users/authRepo.dart';

class SignFarmer extends ConsumerStatefulWidget {
  SignFarmer({super.key});
  @override
  ConsumerState<SignFarmer> createState() {
    return _SignConsumer();
  }
}

class _SignConsumer extends ConsumerState<SignFarmer> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController nameContoller = TextEditingController();

  void sendSignFarmer({required String email, required String password}) async {
    ref
        .watch(AuthContoller.notifier)
        .SignInFarmer(email: email, password: password, context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    PasswordController.dispose();
    nameContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoding=ref.watch(AuthContoller);
    return Scaffold(
      
      body: isLoding?LoderScreen():
      Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign in as FarmerConsumer"),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: nameContoller,
                  decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: PasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    sendSignFarmer(
                        email: emailController.text,
                        password: PasswordController.text);
                  },
                  child: Text("SigIn")),
              SizedBox(
                height: 50,
              ),
              Text("Already have a account"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => LoginFarmer()));
                },
                child: Text("Login In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
