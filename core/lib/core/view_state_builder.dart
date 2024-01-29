import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bloc/base_state.dart';

typedef InitialBuilder = Widget Function(BuildContext context);
typedef LoadingBuilder<T> = Widget Function(BuildContext context, T? data);
typedef SuccessBuilder<T> = Widget Function(BuildContext context, T data);
typedef EmptyBuilder = Widget Function(BuildContext context);
typedef ErrorBuilder = Widget Function(BuildContext context, Object error);
typedef RefreshingBuilder<T> = Widget Function(BuildContext context, T? data);

class ViewStateBuilder<B extends BlocBase<BaseState>> extends BlocBuilder<B, BaseState> {
  ViewStateBuilder({
    Key? key,
    B? bloc,
    InitialBuilder? onNone,
    LoadingBuilder? onLoading,
    SuccessBuilder? onSuccess,
    RefreshingBuilder? onRefreshing,
    EmptyBuilder? onEmpty,
    ErrorBuilder? onError,
    Widget child = const SizedBox.shrink(),
  }) : super(
          key: key,
          bloc: bloc,
          builder: (context, state) {
            if (state is ViewState) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: _buildTransition,
                child: Builder(
                  builder: (context) {
                    switch (state.status) {
                      case ViewStateStatus.none:
                        return onNone?.call(context) ?? child;
                      case ViewStateStatus.loading:
                        return onLoading?.call(context, state.data) ?? child;
                      case ViewStateStatus.refreshing:
                        return onRefreshing?.call(context, state.data) ?? child;
                      case ViewStateStatus.success:
                        return onSuccess?.call(context, state.data) ?? child;
                      case ViewStateStatus.empty:
                        return onEmpty?.call(context) ?? child;
                      case ViewStateStatus.error:
                        return onError?.call(context, state.error) ?? child;
                    }
                  },
                ),
              );
            }
            return child;
          },
        );
}

Widget _buildTransition(Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child);
