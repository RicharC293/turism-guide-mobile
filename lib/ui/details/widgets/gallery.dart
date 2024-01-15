import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';
import 'package:traveler_guide/core/notifiers/detail_screen_notifier.dart';
import 'package:traveler_guide/core/utils/extensions.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.onSurface.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        child: Selector<DetailScreenNotifier, List<String>>(
            selector: (_, notifier) => notifier.attraction?.images ?? [],
            builder: (context, listImages, _) {
              if (listImages.isEmpty) return const Offstage();
              return Row(
                children: [
                  ...listImages
                      .map(
                        (e) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                  height:
                                      (MediaQuery.of(context).size.width - 64) /
                                          4,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      .toList(),
                  if (listImages.length > 4)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                listImages[4],
                                fit: BoxFit.cover,
                                height:
                                    (MediaQuery.of(context).size.width - 64) /
                                        4,
                              ),
                              Positioned.fill(
                                child: Container(
                                  color: Colors.white.withOpacity(0.5),
                                  child: Center(
                                    child: Text(
                                      '+${listImages.length - 4}',
                                      style: context.textTheme.labelMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }
}
