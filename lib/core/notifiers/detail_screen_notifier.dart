import 'package:flutter/material.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';

import '../services/services.dart';

class DetailScreenNotifier extends ChangeNotifier {
  DetailScreenNotifier(this._services);

  final Services _services;

  AttractionModel? _attraction;

  AttractionModel? get attraction => _attraction;

  void setAttraction(AttractionModel attraction) {
    _attraction = attraction;
  }

  Future<void> refreshAttraction() async {
    try {
      if (_attraction == null) return;
      _attraction = await _services.getAttraction(_attraction!.id);
    } catch (err) {
      debugPrint("REFRESH_ATTRACTION $err");
    } finally {
      notifyListeners();
    }
  }
}
