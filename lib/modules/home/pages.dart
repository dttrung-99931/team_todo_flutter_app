import 'package:get/get.dart';
import '../../constants/routes.dart';
import '../team/child_pages.dart';
import 'binding.dart';
import 'screen.dart';

final homePages = GetPage(
  name: RouteNames.HOME,
  page: () => HomeScreen(),
  binding: HomeBinding(),
  children: teamChildPages,
);
