import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_service.dart';
import 'features/editor/presentation/blocs/editor_bloc/editor_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<EditorBloc>()),
      ],
      child: ValueListenableBuilder(
        valueListenable: ThemeService.isDarkThemeNotifier,
        builder: (context, isDark, child) {
          return MaterialApp.router(
            title: 'Screenshot Builder',
            debugShowCheckedModeBanner: false,
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
