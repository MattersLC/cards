import 'package:credit_cards_app/core/theme/theme.dart';
import 'package:credit_cards_app/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/cards_page.dart';
import 'package:credit_cards_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<CardsBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credit Cards App',
      theme: AppTheme.darkModeTheme,
      home: const CardsPage(),
    );
  }
}
