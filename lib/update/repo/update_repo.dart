import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/services/api_handling/decode_api_response.dart';
import 'package:platzi_store/services/api_handling/network_reponse.dart';

class UpdateProductRepo {
  static const String _update = '/api/v1/products/';
  FutureDynamicFailure updateProductDetails(
      {required String title, required String price, required int id}) async {
    final repo = await ApiResponse.getResponse(
        endPoint: "$_update$id",
        apiMethods: ApiMethods.put,
        body: {"title": title, "price": price});
    return decodingApi(repo, fromJson: ProductDetailsModel.fromJson);
  }
}
