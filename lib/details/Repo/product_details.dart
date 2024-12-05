import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/services/api_handling/decode_api_response.dart';
import 'package:platzi_store/services/api_handling/network_reponse.dart';

class ProductDetailsRepo {
  static const String _productDetails = "/api/v1/products/";
  FutureDynamicFailure fetchProductDetails({required int id}) async {
    final response = await ApiResponse.getResponse(
        endPoint: "$_productDetails$id", apiMethods: ApiMethods.get);

    return decodingApi(response);
  }
}
