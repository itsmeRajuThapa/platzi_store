part of 'internet_cubit.dart';

enum ConnectStatus { connected, unconnected }

class InternetState extends Equatable {
  final ConnectStatus status;
  const InternetState({required this.status});

  @override
  List<Object> get props => [status];
  InternetState copyWith({ConnectStatus? status}) {
    return InternetState(status: status ?? this.status);
  }
}

final class InternetInitial extends InternetState {
  InternetInitial() : super(status: ConnectStatus.connected);
}
