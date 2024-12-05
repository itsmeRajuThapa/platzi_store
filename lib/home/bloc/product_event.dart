part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductList extends ProductEvent {
  final String? min;
  final String? categoryId;
  final String? max;

  const GetProductList({this.min, this.max, this.categoryId});
}

class GetProductCategoryList extends ProductEvent {
  final bool isRefresh;

  const GetProductCategoryList({this.isRefresh = true});
}
