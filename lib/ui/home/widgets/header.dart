import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/utils/extensions.dart';
import 'package:traveler_guide/ui/search/search_screen.dart';

import '../../../core/notifiers/search_notifier.dart';
import '../../../core/widgets/button.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.theme.colorScheme.background,
            child: const Text('RC'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bienvenido', style: context.textTheme.titleLarge),
                Text('Richar Cangui', style: context.textTheme.titleSmall),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Button(
              icon: Icons.search,
              onPressed: () {
                context.read<SearchNotifier>().clear();
                Navigator.pushNamed(context, SearchScreen.routeName);
              }),
        ],
      ),
    );
  }
}
