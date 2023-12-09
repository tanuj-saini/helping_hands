import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Dilevery/SignDilevery.dart';
import 'package:helping_hands/Farmer/LoginFarmer.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/LoginConsumer.dart';
import 'package:helping_hands/consumer/SignConsumer.dart';
import 'package:helping_hands/users/authContoller.dart';

class LoginDilevery extends ConsumerStatefulWidget {
  LoginDilevery({super.key});
  @override
  ConsumerState<LoginDilevery> createState() {
    return _LoginUser();
  }
}

class _LoginUser extends ConsumerState<LoginDilevery> {
  void sendDileveryLogin(
      {required String email, required String password}) async {
    ref
        .watch(AuthContoller.notifier)
        .LoginInDelivery(email: email, password: password, context: context);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    PasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final isLoding=ref.watch(AuthContoller);
    return Scaffold(
      body: isLoding?LoderScreen(): Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login in as Dilevery"),
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
                  controller: PasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => LoginConsumer()));
                      },
                      child: Text("Consumer")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => LoginFarmer()));
                      },
                      child: Text("Farmer")),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    sendDileveryLogin(
                        email: emailController.text,
                        password: PasswordController.text);
                  },
                  child: Text("LoginIn")),
              SizedBox(
                height: 50,
              ),
              Text("Don't have a account"),
              ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => SignDilevery())),
                child: Text("Sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
