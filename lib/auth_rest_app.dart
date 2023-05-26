import 'package:auth_rest/core/helper/binding.dart';
import 'package:auth_rest/view/auth/screens/forgot_password_page.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';

class AuthRestApp extends GetMaterialApp {
   AuthRestApp({super.key}) : super(
    initialBinding: Binding(),
    home: const ForgotPasswordPage());
}
