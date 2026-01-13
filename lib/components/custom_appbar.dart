import 'package:budget_app/components/app_text.dart';
import 'package:budget_app/view-model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(homeViewModelProvider);
    return AppBar(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      centerTitle: true,
      title: OpenSans(text: 'Dashboard', fontSize: 20, color: Colors.white),
      actions: [
        IconButton(
          onPressed: () async {
            await viewModelProvider.reset();
          },
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
