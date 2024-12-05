import 'package:flutter/material.dart';
import 'package:platzi_store/abs_normal_state.dart';

import 'utils/pull_to_refresh_widget.dart';

class AbsNormalView extends StatelessWidget {
  final AbsNormalStatus absNormalStatus;
  final List<dynamic>? data;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? noDataWidget;
  final Widget child;
  final void Function() onTapToRefresh;
  final bool isToEnablePullToRefresh;

  const AbsNormalView({
    Key? key,
    required this.absNormalStatus,
    required this.onTapToRefresh,
    required this.child,
    this.data,
    this.errorWidget,
    this.loadingWidget,
    this.noDataWidget,
    this.isToEnablePullToRefresh = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.initial:
        return const SizedBox.shrink();
      case AbsNormalStatus.loading:
        if (loadingWidget != null) {
          return loadingWidget!;
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      case AbsNormalStatus.error:
        if (errorWidget != null) {
          return errorWidget!;
        } else {
          return const Text('Failed error');
          // return SomethingWentWrong(
          //   onPressed: onTapToRefresh,
          // );
        }
      case AbsNormalStatus.success:
        return data != null && data!.isEmpty
            ? Center(
                child: noDataWidget ?? const Text("No Data"),
              )
            : isToEnablePullToRefresh
                ? SmartPullToRefresh(
                    isToEnablePullToRefresh: isToEnablePullToRefresh,
                    onRefresh: onTapToRefresh,
                    child: child,
                  )
                : child;
      default:
        return const SizedBox.shrink();
    }
  }
}
