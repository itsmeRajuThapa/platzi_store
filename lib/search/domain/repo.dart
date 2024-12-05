import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/services/api_handling/decode_api_response.dart';
import 'package:platzi_store/services/api_handling/network_reponse.dart';

class SearchRepo {
  static const String minMax = 'api/v1/products/';
  FutureDynamicFailure filterProductList(
      {required int min, required int max}) async {
    final response = await ApiResponse.getResponse(
        endPoint: minMax,
        apiMethods: ApiMethods.get,
        queryParams: {'price_min': min, 'price_max': max});
    return decodingApi(response);
  }
}
