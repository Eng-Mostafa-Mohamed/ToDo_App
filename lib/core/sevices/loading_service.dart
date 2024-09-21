import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configloading() {
  EasyLoading.instance
    ..indicatorColor = const Color(0xFF5D9CEC)
    ..backgroundColor = Colors.white
    ..indicatorSize = 45.0
    ..loadingStyle = EasyLoadingStyle.custom
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..userInteractions = false
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.black
    ..radius = 10.0;
}
