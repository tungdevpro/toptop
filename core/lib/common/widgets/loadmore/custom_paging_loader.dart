import 'dart:async';

import 'package:flutter/material.dart';

part 'theme_paging_loader.dart';

typedef FutureBooleanCallBack = Future<bool> Function();

enum CustomPagingLoaderStatusState {
  idle('Scroll to load more'),
  loading('Loading...'),
  failed('Failed to load items'),
  finished('No more items');

  const CustomPagingLoaderStatusState(this.text);
  final String text;
}

class _BuilderLocationNotification extends Notification {}

class CustomPagingLoader extends StatefulWidget {
  final double loadingWidgetContainerHeight;
  final Color loadingWidgetColor;
  final String? idleStatusText;
  final String? loadingStatusText;
  final String? failedStatusText;
  final String? finishedStatusText;
  final Color? statusTextColor;
  final bool isFinished;
  final FutureBooleanCallBack onLoadMore;
  final Widget child;

  const CustomPagingLoader({
    Key? key,
    this.loadingWidgetContainerHeight = CustomPagingLoaderDefaultTheme.containerHeight,
    this.loadingWidgetColor = CustomPagingLoaderDefaultTheme.color,
    this.idleStatusText,
    this.loadingStatusText,
    this.failedStatusText,
    this.finishedStatusText,
    this.statusTextColor,
    this.isFinished = false,
    required this.onLoadMore,
    required this.child,
  }) : super(key: key);

  @override
  State<CustomPagingLoader> createState() => _CustomPagingLoaderState();
}

class _CustomPagingLoaderState extends State<CustomPagingLoader> {
  @override
  Widget build(BuildContext context) {
    if (widget.child is! ListView) {
      return const SizedBox.shrink();
    }

    return _buildListView(widget.child as ListView)!;
  }

  Widget? _buildListView(ListView listView) {
    var delegate = listView.childrenDelegate;

    if (delegate is SliverChildBuilderDelegate) {
      SliverChildBuilderDelegate delegate = listView.childrenDelegate as SliverChildBuilderDelegate;

      int viewCount = (delegate.estimatedChildCount ?? 0) + 1;

      Widget builder(context, index) {
        if (index == viewCount - 1) {
          return _buildLoadMoreView();
        }

        return delegate.builder(context, index) ?? const SizedBox.shrink();
      }

      return ListView.builder(
        itemBuilder: builder,
        addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
        addRepaintBoundaries: delegate.addRepaintBoundaries,
        addSemanticIndexes: delegate.addSemanticIndexes,
        dragStartBehavior: listView.dragStartBehavior,
        semanticChildCount: listView.semanticChildCount,
        itemCount: viewCount,
        cacheExtent: listView.cacheExtent,
        controller: listView.controller,
        itemExtent: listView.itemExtent,
        key: listView.key,
        padding: listView.padding,
        physics: listView.physics,
        primary: listView.primary,
        reverse: listView.reverse,
        scrollDirection: listView.scrollDirection,
        shrinkWrap: listView.shrinkWrap,
      );
    }

    return listView;
  }

  CustomPagingLoaderStatusState status = CustomPagingLoaderStatusState.idle;

  Widget _buildLoadMoreView() {
    if (widget.isFinished == true) {
      status = CustomPagingLoaderStatusState.finished;
    } else {
      if (status == CustomPagingLoaderStatusState.finished) {
        status = CustomPagingLoaderStatusState.idle;
      }
    }
    return NotificationListener<_BuilderLocationNotification>(
      onNotification: _onLoadMoreBuild,
      child: __CustomPagingLoaderContent(
        status: status,
        containerHeight: widget.loadingWidgetContainerHeight,
        color: widget.loadingWidgetColor,
        idleStatusText: widget.idleStatusText ?? CustomPagingLoaderStatusState.idle.text,
        loadingStatusText: widget.loadingStatusText ?? CustomPagingLoaderStatusState.loading.text,
        failedStatusText: widget.failedStatusText ?? CustomPagingLoaderStatusState.finished.text,
        finishedStatusText: widget.finishedStatusText ?? CustomPagingLoaderStatusState.finished.text,
        statusTextColor: widget.statusTextColor,
      ),
    );
  }

  bool _onLoadMoreBuild(_BuilderLocationNotification notification) {
    switch (status) {
      case CustomPagingLoaderStatusState.idle:
        loadMore();
      case CustomPagingLoaderStatusState.loading:
      case CustomPagingLoaderStatusState.failed:
      case CustomPagingLoaderStatusState.finished:
        return false;
      default:
        return false;
    }
    return false;
  }

  void _updateStatus(CustomPagingLoaderStatusState status) {
    if (mounted) setState(() => this.status = status);
  }

  void loadMore() {
    _updateStatus(CustomPagingLoaderStatusState.loading);

    widget.onLoadMore().then((v) {
      if (v == true) {
        _updateStatus(CustomPagingLoaderStatusState.idle);
      } else {
        _updateStatus(CustomPagingLoaderStatusState.failed);
      }
    });
  }
}

class __CustomPagingLoaderContent extends StatefulWidget {
  final CustomPagingLoaderStatusState status;

  final double containerHeight;
  final Color color;

  final String idleStatusText;
  final String loadingStatusText;
  final String failedStatusText;
  final String finishedStatusText;
  final Color? statusTextColor;

  const __CustomPagingLoaderContent({
    Key? key,
    required this.status,
    required this.containerHeight,
    required this.color,
    required this.idleStatusText,
    required this.loadingStatusText,
    required this.failedStatusText,
    required this.finishedStatusText,
    this.statusTextColor,
  }) : super(key: key);

  @override
  State<__CustomPagingLoaderContent> createState() => ___CustomPagingLoaderContentState();
}

class ___CustomPagingLoaderContentState extends State<__CustomPagingLoaderContent> {
  final buildNotification = _BuilderLocationNotification();

  @override
  Widget build(BuildContext context) {
    handleNotify();
    return Container(height: widget.containerHeight, alignment: Alignment.center, child: buildTextWidget());
  }

  Widget buildTextWidget() {
    if (widget.status == CustomPagingLoaderStatusState.failed ||
        widget.status == CustomPagingLoaderStatusState.idle ||
        widget.status == CustomPagingLoaderStatusState.finished) {
      return Text(widget.status.text, style: TextStyle(color: widget.statusTextColor));
    }

    if (widget.status == CustomPagingLoaderStatusState.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(widget.color))),
            Padding(padding: const EdgeInsets.only(left: 10.0), child: Text(widget.status.text)),
          ],
        ),
      );
    }
    return SizedBox.fromSize();
    // return Text(widget.status.text, style: TextStyle(color: widget.statusTextColor));
  }

  void handleNotify() async {
    await Future.delayed(const Duration(milliseconds: 16));
    if (widget.status == CustomPagingLoaderStatusState.idle) _notifyBuildProcess();
  }

  void _notifyBuildProcess() {
    if (!mounted) return;
    buildNotification.dispatch(context);
  }
}
