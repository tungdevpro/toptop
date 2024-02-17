import 'package:domain/model/config_model.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final ConfigModel? config;
  final bool hasCheckNetworkGlobal;
  final bool isDarkTheme;
  final bool hasSkipIntro;

  const AppState({this.config, this.hasCheckNetworkGlobal = true, this.isDarkTheme = false, this.hasSkipIntro = false});

  AppState copyWith({ConfigModel? config, bool? hasCheckNetworkGlobal, String? token, bool? isDarkTheme, bool? hasSkipIntro}) {
    return AppState(
      config: config ?? this.config,
      hasCheckNetworkGlobal: hasCheckNetworkGlobal ?? this.hasCheckNetworkGlobal,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      hasSkipIntro: hasSkipIntro ?? this.hasSkipIntro,
    );
  }

  @override
  List<Object?> get props => [config, hasCheckNetworkGlobal, isDarkTheme, hasSkipIntro];
}
