import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/models/city_model.dart';
import 'package:traveler_guide/core/notifiers/home_screen_notifier.dart';
import 'package:traveler_guide/core/utils/extensions.dart';

class CitySelector extends StatelessWidget {
  const CitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      padding: const EdgeInsets.only(left: 4, bottom: 4, top: 4),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      height: 50,
      child: Consumer<HomeScreenNotifier>(builder: (context, notifier, _) {
        if (notifier.cities == null) {
          /// add skeleton
          return const Center(child: CircularProgressIndicator());
        }

        if (notifier.cities!.isEmpty) {
          return Center(
              child: Text(
            'No hay ciudades disponibles',
            style: context.textTheme.labelSmall,
          ));
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                notifier.onSelectedCityChanged(notifier.cities![index]);
              },
              child: Card(
                color: notifier.selectedCity?.id == notifier.cities![index].id
                    ? null
                    : context.theme.colorScheme.background,
                elevation:
                    notifier.selectedCity?.id == notifier.cities![index].id
                        ? 1
                        : 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(notifier.cities![index].name,
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.theme.colorScheme.primary)),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 4),
          itemCount: notifier.cities!.length,
        );
      }),
    );
  }
}
