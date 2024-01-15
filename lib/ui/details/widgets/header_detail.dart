import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveler_guide/core/notifiers/detail_screen_notifier.dart';

import '../../../core/widgets/button.dart';

class HeaderDetail extends StatelessWidget {
  const HeaderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailScreenNotifier>(
        builder: (context, notifier, _) => Stack(
              children: [
                Hero(
                  tag: 'image${notifier.attraction!.id}',
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      child: Image.network(
                        notifier.attraction!.headerImage,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.45,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Button(
                          icon: Icons.arrow_back_ios,
                          alignment: Alignment.centerRight,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
                        Button(icon: Icons.favorite_border, onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
