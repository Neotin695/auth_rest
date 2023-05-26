import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  RxString userId = RxString('');

  Future<bool> sendCode(email) async {
    final response = await http.post(
      Uri.parse('localhost:8000/api/v1/auth/forgotPassword'),
      body: {
        'email': email.toString().trim(),
      },
    );

    return response.statusCode == 200;
  }

  Future<String> checkCode(code) async {
    final response = await http
        .post(Uri.parse('localhost:8000/api/v1/auth/verifyResetCode/$code'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'invalide code';
    }
  }

  Future<bool> resetPassword( confirmPassword, passowrd) async {
    final response = await http.post(
      Uri.parse('localhost:8000/api/v1/auth/resetPassword/$userId'),
      body: {
        "password": passowrd.toString().trim(),
        "confirmPassword": confirmPassword.toString().trim(),
      },
    );
    return response.statusCode == 200;
  }
}
