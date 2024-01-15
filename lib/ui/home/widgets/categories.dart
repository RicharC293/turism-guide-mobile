import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/notifiers/home_screen_notifier.dart';
import 'package:traveler_guide/core/utils/extensions.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Categorías', style: context.textTheme.titleMedium),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: Consumer<HomeScreenNotifier>(builder: (context, notifier, _) {
            if (notifier.categories == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (notifier.categories!.isEmpty) {
              return Center(
                  child: Text(
                'No hay categorías disponibles',
                style: context.textTheme.labelSmall,
              ));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = notifier.categories![index];
                return GestureDetector(
                  onTap: () {
                    notifier.onSelectedCategoryChanged(category);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 120, maxHeight: 120),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              category.image,
                              width:
                                  MediaQuery.of(context).size.width * 0.4 + 8,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: context.textTheme.labelSmall?.copyWith(
                              fontWeight:
                                  notifier.selectedCategory?.id == category.id
                                      ? FontWeight.bold
                                      : null),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: notifier.categories!.length,
            );
          }),
        ),
      ],
    );
  }
}
