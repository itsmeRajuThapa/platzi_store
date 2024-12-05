import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:platzi_store/update/repo/update_repo.dart';
part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<UpdateProductEvent>(_updateProductEvent);
  }

  FutureOr<void> _updateProductEvent(
      UpdateProductEvent event, Emitter<UpdateState> emit) async {
    emit(state.copyWith(status: updatestatus.loading));

    final UpdateProductRepo data = UpdateProductRepo();
    await data.updateProductDetails(
        title: event.title, price: event.price, id: event.id);
    emit(state.copyWith(status: updatestatus.success));
  }
}
