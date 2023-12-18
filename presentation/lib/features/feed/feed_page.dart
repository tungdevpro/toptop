import 'package:core/core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/features/feed/feed.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends CoreViewState<FeedPage, FeedBloc> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
