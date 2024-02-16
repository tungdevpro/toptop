import 'package:presentation/features/feed/bloc/feed_bloc.dart';
import 'package:presentation/import.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends CoreViewState<FeedPage, FeedBloc> {
  @override
  FeedBloc get initBloc => FeedBloc.to;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(),
    );
  }
}
