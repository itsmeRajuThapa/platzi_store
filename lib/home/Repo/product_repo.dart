import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/service/failuer.dart';
import 'package:platzi_store/services/api_handling/decode_api_response.dart';
import 'package:platzi_store/services/api_handling/network_reponse.dart';

class ProductRepo {
  static const String _product = "/api/v1/products/";
  static const String _category = "/api/v1/categories/";

  FutureDynamicFailure fetchAllProducts(
      {required String min,
      required String max,
      required String categoryId}) async {
    final response = await ApiResponse.getResponse(
        endPoint: _product,
        apiMethods: ApiMethods.get,
        queryParams: {
          'price_min': min,
          'price_max': max,
          'categoryId': categoryId
        });
    return decodingApi(response, fromJson: ProductDetailsModel.fromJson);
  }

  Future<Either<dynamic, Failure>> fetchAllCategorys() async {
    final response = await ApiResponse.getResponse(
        endPoint: _category, apiMethods: ApiMethods.get);
    return decodingApi(response, fromJson: CategoryModel.fromJson);
  }
}
