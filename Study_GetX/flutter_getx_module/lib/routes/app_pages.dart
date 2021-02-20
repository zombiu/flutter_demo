import 'package:flutter_getx_module/count_test/view.dart';
import 'package:flutter_getx_module/pages/video_conference.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.HOME;

  static const PROVIDER = "/provider";

  static final pages = [
    GetPage(
      name: Routes.VIDEO_CONFERENCE_HOME,
      page: () => VideoConferenceHomePage(),
    ),
    GetPage(name: PROVIDER, page: () => CountTestPage()),
  ];
}
