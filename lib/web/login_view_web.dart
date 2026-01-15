import 'package:budget_app/components/custom_button.dart';
import 'package:budget_app/shared/sizedbox.dart';
import 'package:budget_app/view-model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/app_text.dart';
import '../components/common_textform_field.dart';

class LoginViewWeb extends HookConsumerWidget {
  const LoginViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCont = useTextEditingController();
    final passwordCont = useTextEditingController();
    final viewModelProvider = ref.watch(authViewModelProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/login_image.png',
              fit: BoxFit.contain,
              width: width / 2.6,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height / 5.5),
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    width: 200,
                  ),
                  40.spaceY,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CommonTextFormField(
                          controller: emailCont,
                          hintText: 'Email',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) =>
                              text!.isEmpty ? 'Required' : null,
                        ),
                        20.spaceY,
                        CommonTextFormField(
                          controller: passwordCont,
                          hintText: 'Password',
                          obscureText: viewModelProvider.isObscure,
                          prefixIcon: viewModelProvider.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onPrefixIconPressed: viewModelProvider.toggleObscure,
                          validator: (text) =>
                              text!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                  30.spaceY,
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        title: 'Register',
                        fontSize: 25,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModelProvider.createUserWithEmailAndPassword(
                              emailCont.text.trim(),
                              passwordCont.text.trim(),
                            );
                          }
                        },
                      ),
                      OpenSans(text: 'Or'),
                      CustomButton(
                        title: 'Login',
                        fontSize: 25,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModelProvider.signInWithEmailAndPassword(
                              emailCont.text.trim(),
                              passwordCont.text.trim(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  30.spaceY,
                  CustomButton(
                    title: 'Google',
                    width: 350,
                    fontSize: 25,
                    onPressed: () {
                      viewModelProvider.signInWithGoogleWeb(
                        emailCont.text.trim(),
                        passwordCont.text.trim(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
