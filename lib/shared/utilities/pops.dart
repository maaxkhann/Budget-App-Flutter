import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Pops {
  // ignore: strict_top_level_inference
  static init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle
          .custom //EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.grey.withValues(alpha: 0.9)
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withValues(alpha: 0.5)
      ..userInteractions = false
      // ..loadingStyle=EasyLoadingStyle.light
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
  }

  static Future<void> showToast(
    String status, {
    Duration? duration,
    EasyLoadingToastPosition? toastPosition,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) async {
    await EasyLoading.showToast(
      status,
      duration: duration,
      toastPosition: toastPosition,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static Future<void> startLoading({
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear,
    bool? dismissOnTap,
  }) async {
    await EasyLoading.show(
      status: status,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static Future<void> stopLoading({bool animation = true}) async {
    await EasyLoading.dismiss(animation: animation);
  }

  static Future<void> showWarning(
    String status, {
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) async {
    await EasyLoading.showError(
      status,
      duration: duration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static Future<void> showError(
    String status, {
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) async {
    await EasyLoading.showError(
      status,
      duration: duration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static Future<void> showInfo(
    String status, {
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) async {
    await EasyLoading.showInfo(
      status,
      duration: duration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }
}
