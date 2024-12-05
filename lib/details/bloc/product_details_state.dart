part of 'product_details_bloc.dart';

enum ProductDetailsStatus { initial, loading, success, error }

class ProductDetailsState extends Equatable {
  final ProductDetailsModel productdetails;
  final ProductDetailsStatus status;
  const ProductDetailsState(
      {required this.productdetails, required this.status});

  @override
  List<Object> get props => [productdetails, status];
  ProductDetailsState copyWith({
    final ProductDetailsModel? productdetails,
    final ProductDetailsStatus? status,
  }) {
    return ProductDetailsState(
        productdetails: productdetails ?? this.productdetails,
        status: status ?? this.status);
  }
}

final class ProductDetailsInitial extends ProductDetailsState {
  ProductDetailsInitial()
      : super(
            productdetails: ProductDetailsModel(),
            status: ProductDetailsStatus.initial);
}
