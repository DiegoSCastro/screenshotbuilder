import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';

import 'core/theme/theme_service.dart';
import 'features/sample/presentation/blocs/sample_bloc/sample_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [BlocProvider(create: (context) => getIt<SampleBloc>())],
      child: ValueListenableBuilder(
        valueListenable: ThemeService.isDarkThemeNotifier,
        builder: (context, isDark, child) {
          return MaterialApp.router(
            title: "App title",
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: theme.light(),
            darkTheme: theme.dark(),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
