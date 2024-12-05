part of 'update_bloc.dart';

sealed class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductEvent extends UpdateEvent {
  final String title;
  final String price;
  final int id;

  UpdateProductEvent(
      {required this.title, required this.price, required this.id});
}
