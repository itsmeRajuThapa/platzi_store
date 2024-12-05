// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';

// enum ApiMethods { get, post }

// class ApiResponse {
//   static final ApiManager _apiManger = locator<ApiManager>();

//   static Future<Response?> getResponse(
//       {required String endPoint,
//       required ApiMethods apiMethods,
//       Map<String, dynamic>? queryParams,
//       dynamic body,
//       Options? options,
//       bool shouldCache = false}) async {
//     Response? response;
//     try {
//       if (apiMethods == ApiMethods.post) {
//         response = await _apiManger.dio!.post(
//           endPoint,
//           data: body,
//           queryParameters: queryParams,
//           options: options ?? Options(headers: apiDefaultHeaders()),
//         );
//       } else {
//         response = await _apiManger.dio!
//             .get(endPoint, queryParameters: queryParams, options: options);
//       }
//       if (response.statusCode == 200 && shouldCache) {
//         locator<SharedPrefsServices>()
//             .setString(key: endPoint, value: response.data);
//       }
//     } on SocketException catch (_) {
//       log(_.message);

//       return AppToasts()
//           .showToast(message: 'No Internet Connection', isSuccess: false);
//     } on DioError catch (e) {
//       return e.response;
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//     return response;
//   }
// }
// Map<String, String> apiDefaultHeaders() {
//   // String? token = locator<SharedPrefsServices>().getString(
//   //   key: AppConstants.accessToken,
//   // );
//  // String header = "Bearer $token";

//   Map<String, String> headers;
//   headers = {
//     "Content-Type": "application/json",
//     "Accept": "application/json",
//   //  if (token != null) "Authorization": header,
//   };
//   print(headers.toString());

//   return headers;
// }
