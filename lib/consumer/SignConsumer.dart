import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/LoginConsumer.dart';
import 'package:helping_hands/users/authContoller.dart';

class SignConsumer extends ConsumerStatefulWidget {
  SignConsumer({super.key});
  @override
  ConsumerState<SignConsumer> createState() {
    return _SignConsumer();
  }
}

class _SignConsumer extends ConsumerState<SignConsumer> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController nameContoller = TextEditingController();

  void sendSignConsumer(
      {required String email, required String password}) async {
    ref
        .watch(AuthContoller.notifier)
        .SignInConsumer(email: email, password: password, context: context);
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
      body: isLoding?LoderScreen(): Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign in as Consumer"),
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
                    sendSignConsumer(
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => LoginConsumer()));
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
