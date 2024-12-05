import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';

Map<String, String> apiDefaultHeaders() {
  String? token = locator<SharedPrefsServices>().getString(key: 'token');
  String header = "Bearer $token";
  Map<String, String> headers;
  headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    if (token != null) "Authorization": header,
  };
  print(headers.toString());

  return headers;
}
