part of 'product_bloc.dart';

enum ProductStateStatus { initial, loading, success, error }

enum CategoryStatus { initial, loading, success, error }

class ProductState extends Equatable {
  final List<ProductDetailsModel> productList;
  final List<CategoryModel> categoryList;
  final ProductStateStatus status;
  final CategoryStatus categorystatus;
  const ProductState(
      {required this.productList,
      required this.status,
      required this.categorystatus,
      required this.categoryList});

  @override
  List<Object> get props => [productList, categoryList, categorystatus];
  ProductState copyWith(
      {final List<ProductDetailsModel>? productList,
      final List<CategoryModel>? categoryList,
      final CategoryStatus? categorystatus,
      final ProductStateStatus? status}) {
    return ProductState(
        productList: productList ?? this.productList,
        categoryList: categoryList ?? this.categoryList,
        categorystatus: categorystatus ?? this.categorystatus,
        status: status ?? this.status);
  }
}

final class ProductInitial extends ProductState {
  ProductInitial()
      : super(
            productList: [],
            categoryList: [],
            categorystatus: CategoryStatus.initial,
            status: ProductStateStatus.initial);
}
