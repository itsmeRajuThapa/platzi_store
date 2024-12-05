// ignore_for_file: camel_case_types

part of 'update_bloc.dart';

enum updatestatus { initial, loading, success, error }

class UpdateState extends Equatable {
  final updatestatus status;
  const UpdateState({required this.status});

  @override
  List<Object> get props => [status];
  UpdateState copyWith({final updatestatus? status}) {
    return UpdateState(status: status ?? this.status);
  }
}

final class UpdateInitial extends UpdateState {
  UpdateInitial() : super(status: updatestatus.initial);
}
