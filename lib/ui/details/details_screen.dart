import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';
import 'package:traveler_guide/ui/details/widgets/description.dart';
import 'package:traveler_guide/ui/details/widgets/gallery.dart';
import 'package:traveler_guide/ui/details/widgets/header_detail.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/notifiers/detail_screen_notifier.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<DetailScreenNotifier, AttractionModel?>(
          selector: (_, notifier) => notifier.attraction,
          builder: (context, attraction, _) {
            if (attraction == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<DetailScreenNotifier>().refreshAttraction();
              },
              child: ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: const [
                  HeaderDetail(),
                  Description(),
                  Gallery(),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String url;
          const phone = '593983736422';
          const text =
              'Hola, me gustaría reservar una visita para el día 10 de octubre';
          if (Platform.isIOS) {
            url = "https://wa.me/$phone/?text=$text";
          } else {
            url =
                "https://api.whatsapp.com/send?phone=$phone&text=${text ?? ''}";
          }
          final Uri uri = Uri.tryParse(url)!;
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            debugPrint('Could not launch $url');
          }
        },
        icon: const Icon(Icons.calendar_today),
        label: const Text('Reservar'),
      ),
    );
  }
}
