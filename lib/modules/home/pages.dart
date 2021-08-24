import 'package:get/get.dart';

import 'binding.dart';
import 'screen.dart';

final homePages = GetPage(
  name: "/",
  page: () => HomeScreen(),
  binding: HomeBinding(),
);
