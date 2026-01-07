import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/app_text.dart';
import '../components/common_textform_field.dart';
import '../view-model/view_model.dart';

class LoginViewWeb extends HookConsumerWidget {
  const LoginViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCont = useTextEditingController();
    final passwordCont = useTextEditingController();
    final viewModelProvider = ref.watch(viewModel);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                  SizedBox(height: 40),
                  CommonTextFormField(
                    controller: emailCont,
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  CommonTextFormField(
                    controller: passwordCont,
                    hintText: 'Password',
                    obscureText: viewModelProvider.isObscure,
                    prefixIcon: viewModelProvider.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onPrefixIconPressed: viewModelProvider.toggleObscure,
                  ),
                  SizedBox(height: 30),
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () =>
                              viewModelProvider.createUserWithEmailAndPassword(
                                context,
                                emailCont.text.trim(),
                                passwordCont.text.trim(),
                              ),
                          child: OpenSans(
                            text: 'Register',
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      OpenSans(text: 'Or'),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () =>
                              viewModelProvider.signInWithEmailAndPassword(
                                context,
                                emailCont.text.trim(),
                                passwordCont.text.trim(),
                              ),
                          child: OpenSans(
                            text: 'Login',
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: MaterialButton(
                      splashColor: Colors.grey,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        if (kIsWeb) {
                          viewModelProvider.signInWithGoogleWeb(
                            context,
                            emailCont.text.trim(),
                            passwordCont.text.trim(),
                          );
                        } else {
                          viewModelProvider.signInWithGoogleMobile(
                            context,
                            emailCont.text.trim(),
                            passwordCont.text.trim(),
                          );
                        }
                      },
                      child: OpenSans(
                        text: 'Google',
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
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
