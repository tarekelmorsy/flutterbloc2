import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp( BreakingApp(appRouter: AppRouter(),));
}

class BreakingApp extends StatelessWidget {
  final AppRouter appRouter;
  const BreakingApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRouter.generateRouter,

    );
  }
}
