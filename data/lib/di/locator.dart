import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final locator = GetIt.instance..allowReassignment = true;

@InjectableInit(
  initializerName: 'initData',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => locator.initData();
