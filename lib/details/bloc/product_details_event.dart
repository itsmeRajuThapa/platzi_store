part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final int id;

  GetProductDetailsEvent({required this.id});
}
