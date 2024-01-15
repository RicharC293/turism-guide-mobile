import 'package:flutter/material.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';
import 'package:traveler_guide/core/services/services.dart';

class SearchNotifier extends ChangeNotifier {
  final Services _services;

  SearchNotifier(this._services);

  bool _isLoading = false;

  List<AttractionModel>? _attractions;

  List<AttractionModel>? get attractions => _attractions;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set attractions(List<AttractionModel>? value) {
    _attractions = value;
    notifyListeners();
  }

  Future<void> search(String query) async {
    try {
      if (_isLoading) return;
      _isLoading = true;
      _attractions = await _services.getAttractionsWithFilters(query: query);
    } catch (err) {
      debugPrint("SEARCH $err");
      _attractions = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _attractions = null;
    _isLoading = false;
  }
}
