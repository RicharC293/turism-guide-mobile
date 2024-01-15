import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';
import 'package:traveler_guide/core/notifiers/detail_screen_notifier.dart';
import 'package:traveler_guide/core/notifiers/search_notifier.dart';
import 'package:traveler_guide/core/utils/extensions.dart';
import 'package:traveler_guide/core/widgets/button.dart';

import '../details/details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Button(
                    icon: Icons.arrow_back_ios,
                    alignment: Alignment.centerRight,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text('Buscar atracciones',
                        style: context.textTheme.titleLarge),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: context.textTheme.labelLarge,
                onChanged: (value) {
                  if (value.length > 3) {
                    context.read<SearchNotifier>().search(value);
                    return;
                  }
                  context.read<SearchNotifier>().attractions = [];
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Selector<SearchNotifier, List<AttractionModel>?>(
                    selector: (_, notifier) => notifier.attractions,
                    builder: (context, attractions, _) {
                      if (attractions == null) {
                        return Center(
                          child: Text(
                            'Ingresa el nombre de una atracción',
                            style: context.textTheme.titleLarge?.copyWith(
                                color: context.theme.colorScheme.primary
                                    .withOpacity(0.5)),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      if (attractions.isEmpty) {
                        return Center(
                          child: Text(
                            'Ups... No hay atracciones con ese nombre',
                            style: context.textTheme.titleLarge?.copyWith(
                                color: context.theme.colorScheme.primary
                                    .withOpacity(0.5)),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final attraction = attractions[index];
                          return ListTile(
                            onTap: () {
                              context
                                  .read<DetailScreenNotifier>()
                                  .setAttraction(attraction);
                              Navigator.of(context)
                                  .pushNamed(DetailsScreen.routeName);
                            },
                            leading: Hero(
                              tag: 'image${attraction.id}',
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(attraction.headerImage),
                              ),
                            ),
                            title: Text(attraction.name,
                                style: context.textTheme.titleSmall),
                            subtitle: Text(
                              attraction.description,
                              style: context.textTheme.labelSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,
                                size: 16,
                                color: context.theme.colorScheme.primary),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemCount: attractions.length,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
