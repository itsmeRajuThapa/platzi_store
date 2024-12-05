import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/services/api_handling/decode_api_response.dart';
import 'package:platzi_store/services/api_handling/network_reponse.dart';

class LoginRepo {
  static const String _login = '/api/v1/auth/login';
  FutureDynamicFailure loginUser(
      {required String email, required String password}) async {
    final response = await ApiResponse.getResponse(
        endPoint: _login,
        apiMethods: ApiMethods.post,
        body: {"email": email, "password": password});
    return decodingApi(response);
  }
}
