import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/notifiers/home_screen_notifier.dart';
import 'package:traveler_guide/ui/home/widgets/attractions.dart';
import 'package:traveler_guide/ui/home/widgets/categories.dart';
import 'package:traveler_guide/ui/home/widgets/city_selector.dart';
import 'package:traveler_guide/ui/home/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenNotifier>().initHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Crear el widget de header en esta vista y moverla a un widget externo para
            /// evidenciar la diferencia entre el código de la vista y el código del widget
            Header(),
            CitySelector(),
            Categories(),
            SizedBox(height: 16),
            Expanded(child: Attractions()),
          ],
        ),
      ),
    );
  }
}
