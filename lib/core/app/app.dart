import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/notifiers/detail_screen_notifier.dart';
import 'package:traveler_guide/core/notifiers/home_screen_notifier.dart';
import 'package:traveler_guide/core/services/services.dart';
import 'package:traveler_guide/ui/details/details_screen.dart';
import 'package:traveler_guide/ui/home/home_screen.dart';
import 'package:traveler_guide/ui/search/search_screen.dart';

import '../notifiers/search_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Aquí se registran los providers
        ChangeNotifierProvider(create: (_) => HomeScreenNotifier(Services())),
        ChangeNotifierProvider(create: (_) => DetailScreenNotifier(Services())),
        ChangeNotifierProvider(create: (_) => SearchNotifier(Services())),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF204EAB),
            secondary: Colors.red,
            onSurface: const Color(0xFF43A7E2),
            background: const Color(0xFFE9EFF7),
          ),
          scaffoldBackgroundColor: const Color(0xFFF2F3F6),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF204EAB),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF204EAB),
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF204EAB),
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF204EAB),
            ),
            labelLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF204EAB),
            ),
            labelSmall: TextStyle(
              fontSize: 14,
              color: Color(0xFF204EAB),
            ),
          ),
          cardTheme: const CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          DetailsScreen.routeName: (context) => const DetailsScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
        },
      ),
    );
  }
}
