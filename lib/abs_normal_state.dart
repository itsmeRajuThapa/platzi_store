import 'package:equatable/equatable.dart';
import 'package:platzi_store/service/failuer.dart';

enum AbsNormalStatus {
  initial,
  loading,
  error,
  success,
}

abstract class AbsNormalState<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final AbsNormalStatus absNormalStatus;

  AbsNormalState({
    this.failure,
    this.data,
    required this.absNormalStatus,
  });
}

class AbsNormalStateImpl<T> extends AbsNormalState {
  AbsNormalStateImpl({
    super.failure,
    super.data,
    required super.absNormalStatus,
  });

  AbsNormalStateImpl<T> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
  }) {
    return AbsNormalStateImpl(
      failure: failure ?? this.failure,
      absNormalStatus: absNormalStatus ?? this.absNormalStatus,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        data,
        failure,
        absNormalStatus,
      ];
}

class AbsNormalInitialState<T> extends AbsNormalStateImpl<T> {
  AbsNormalInitialState()
      : super(
          absNormalStatus: AbsNormalStatus.initial,
        );
}
