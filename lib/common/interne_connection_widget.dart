import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_store/auth/Internet_cubit/cubit/internet_cubit.dart';

class InternatConnectionWidget extends StatelessWidget {
  final Widget onlineWidget;
  final Widget offlineWidget;
  const InternatConnectionWidget(
      {super.key, required this.onlineWidget, required this.offlineWidget});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(builder: (ctx, state) {
      return state.status == ConnectStatus.connected
          ? onlineWidget
          : offlineWidget;
    });
  }
}
