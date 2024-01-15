import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/notifiers/detail_screen_notifier.dart';
import 'package:traveler_guide/core/notifiers/home_screen_notifier.dart';
import 'package:traveler_guide/core/utils/extensions.dart';
import 'package:traveler_guide/ui/details/details_screen.dart';

class Attractions extends StatelessWidget {
  const Attractions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Atracciones', style: context.textTheme.titleMedium),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Consumer<HomeScreenNotifier>(builder: (context, notifier, _) {
            if (notifier.attractions == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (notifier.attractions!.isEmpty) {
              return Center(
                child: Text(
                  'Ups... No hay atracciones',
                  style: context.textTheme.titleLarge?.copyWith(
                      color:
                          context.theme.colorScheme.primary.withOpacity(0.5)),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final attraction = notifier.attractions![index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<DetailScreenNotifier>()
                        .setAttraction(attraction);
                    Navigator.of(context).pushNamed(DetailsScreen.routeName);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Hero(
                    tag: 'image${attraction.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        attraction.headerImage,
                        width: MediaQuery.of(context).size.width * 0.4 + 8,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: notifier.attractions!.length,
            );
          }),
        ),
      ],
    );
  }
}
