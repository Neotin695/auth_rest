import 'package:auth_rest/view/auth/controller/auth_controller.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends GetWidget<AuthController> {
  ForgotPasswordView({super.key});

  final TextEditingController emailCN = TextEditingController();
  final TextEditingController passwordCN = TextEditingController();
  final TextEditingController confirmPasswordCN = TextEditingController();
  final TextEditingController codeCN = TextEditingController();
  final GlobalKey<FormState> forgot = GlobalKey();
  final PageController pageCN = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: pageCN,
        children: [
          Form(
            key: forgot,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text('Welcome'),
                const SizedBox(
                  height: 200,
                ),
                TextFormField(
                  controller: emailCN,
                  decoration: const InputDecoration(hintText: 'email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your email';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (!forgot.currentState!.validate()) {
                        return;
                      }
                      controller.sendCode(emailCN.text).then((value) {
                        if (value) {
                          pageCN.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                      });
                    },
                    child: const Text('send code'))
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text('Welcome'),
              const SizedBox(
                height: 200,
              ),
              TextFormField(
                controller: codeCN,
                decoration: const InputDecoration(hintText: 'reset code'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your code';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.checkCode(emailCN.text).then((value) {
                      if (value != 'invalide code') {
                        controller.userId.value = value;
                        pageCN.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      } else {
                        CoolAlert.show(
                            context: context, type: CoolAlertType.error);
                      }
                    });
                  },
                  child: const Text('send code'))
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text('Welcome'),
              const SizedBox(
                height: 200,
              ),
              TextFormField(
                controller: passwordCN,
                decoration: const InputDecoration(hintText: 'password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmPasswordCN,
                decoration: const InputDecoration(hintText: 'confirm password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    controller
                        .resetPassword(confirmPasswordCN.text, passwordCN.text)
                        .then((value) {});
                  },
                  child: const Text('reset password'))
            ],
          ),
        ],
      ),
    );
  }
}
