import 'package:budget_app/components/app_text.dart';
import 'package:budget_app/view-model/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewMobile extends HookConsumerWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCont = useTextEditingController();
    final passwordCont = useTextEditingController();
    final viewModelProvider = ref.watch(viewModel);
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height / 5.5),
              Image.asset('assets/logo.png', fit: BoxFit.contain, width: 210),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: emailCont,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 30,
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.openSans(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: passwordCont,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () => viewModelProvider.toggleObscure(),
                      icon: Icon(
                        viewModelProvider.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),

                    hintText: 'Password',
                    hintStyle: GoogleFonts.openSans(),
                  ),
                  obscureText: viewModelProvider.isObscure,
                ),
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
      ),
    );
  }
}
