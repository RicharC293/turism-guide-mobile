import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';
import 'package:traveler_guide/core/notifiers/detail_screen_notifier.dart';
import 'package:traveler_guide/core/utils/extensions.dart';

import '../../../core/widgets/rating.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Selector<DetailScreenNotifier, AttractionModel>(
          selector: (_, notifier) => notifier.attraction!,
          builder: (context, attraction, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attraction.name, style: context.textTheme.titleLarge),
                const SizedBox(height: 4),
                Rating(rating: attraction.rating),
                const SizedBox(height: 4),
                SelectableText(
                  attraction.description,
                  style: context.textTheme.labelSmall,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: attraction.description));
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Descripción copiada'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: context.theme.colorScheme.primary,
                          ),
                        );
                      },
                      child: Text(
                        'Copiar descripción',
                        style: context.textTheme.labelSmall
                            ?.copyWith(fontSize: 10),
                      )),
                )
              ],
            );
          }),
    );
  }
}
