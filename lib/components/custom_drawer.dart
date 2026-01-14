import 'package:budget_app/components/app_text.dart';
import 'package:budget_app/view-model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../helper/url_launch_method.dart';
import '../shared/sizedbox.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(authViewModelProvider);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: CircleAvatar(
                radius: 180,
                backgroundColor: Colors.white,
                child: Image(
                  height: 100,
                  image: AssetImage('assets/logo.png'),
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          10.spaceY,
          MaterialButton(
            elevation: 20,
            color: Colors.black,
            height: 50,
            minWidth: 200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              //   elevation: 20,
            ),
            onPressed: () async => await viewModelProvider.logout(),
            child: OpenSans(text: 'Logout', fontSize: 20, color: Colors.white),
          ),
          20.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async => launchUrlMethod(
                  'https://www.instagram.com/maaz.514?utm_source=qr&igsh=aHh1cDV0bDE2eW11',
                ),
                icon: SvgPicture.asset(
                  'assets/instagram.svg',
                  width: 35,
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
              IconButton(
                onPressed: () async =>
                    launchUrlMethod('https://x.com/MaazKha65069365'),
                icon: SvgPicture.asset(
                  'assets/twitter.svg',
                  width: 35,
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
