import 'package:flutter_getx_module/count_test/view.dart';
import 'package:flutter_getx_module/pages/video_conference.dart';
import 'package:get/get.dart';

import '../main.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = '/';

  static const VIDEO_CONFERENCE_HOME = '/video_conference_home';
  static const PROVIDER = "/provider";

  static final pages = [
    GetPage(name: INITIAL,
    page: () => MyHomePage(title: 'Flutter Demo Home Page'),),
    GetPage(
      name: VIDEO_CONFERENCE_HOME,
      page: () => VideoConferenceHomePage(),
    ),
    GetPage(name: PROVIDER, page: () => CountTestPage()),
  ];
}
