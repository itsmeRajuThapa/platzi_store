import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/details/Repo/product_details.dart';

import 'package:platzi_store/home/model/productModel.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<GetProductDetailsEvent>(_getProductDetailsEvent);
  }

  FutureOr<void> _getProductDetailsEvent(
      GetProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    // try {
    emit(state.copyWith(status: ProductDetailsStatus.loading));
    ProductDetailsRepo repo = ProductDetailsRepo();
    DynamicFailure response = await repo.fetchProductDetails(id: event.id);
    response.fold((l) {
      emit(state.copyWith(
          status: ProductDetailsStatus.success,
          productdetails: ProductDetailsModel.fromJson(l['data'])));
    }, (r) {
      emit(state.copyWith(status: ProductDetailsStatus.error));
    });
  }
}
