import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_space_01/common/common.dart';
import 'package:safe_space_01/features/auth/controller/auth_controller.dart';
import 'package:safe_space_01/features/auth/view/signup_view.dart';
import 'package:safe_space_01/features/home/view/home_view.dart';
import 'package:safe_space_01/theme/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Safe Space',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                print("user id:" + user.$id);
                return const HomeView();
              }
              return const SignupView();
            },
            error: (error, st) => ErrorPage(
              error: error.toString(),
            ),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
