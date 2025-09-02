import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'voice_cal_app.dart';

void main() async {
  //to fix test in release mode
  await ScreenUtil.ensureScreenSize();
  runApp(const VoiceCalApp());
}
