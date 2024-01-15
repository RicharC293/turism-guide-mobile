import 'package:flutter/material.dart';
import 'package:traveler_guide/core/models/attraction_model.dart';
import 'package:traveler_guide/core/models/category_model.dart';
import 'package:traveler_guide/core/services/services.dart';

import '../models/city_model.dart';

class HomeScreenNotifier extends ChangeNotifier {
  /// Crea el constructor de la clase HomeScreenNotifier y se inyecta la dependencia
  HomeScreenNotifier(this._services);

  final Services _services;

  /// Crear las variables de estado
  List<CityModel>? _cities;

  List<CategoryModel>? _categories;

  CityModel? _selectedCity;

  CategoryModel? _selectedCategory;

  List<AttractionModel>? _attractions;

  /// Crear los getters de las variables de estado

  List<CityModel>? get cities => _cities;

  CityModel? get selectedCity => _selectedCity;

  List<CategoryModel>? get categories => _categories;

  CategoryModel? get selectedCategory => _selectedCategory;

  List<AttractionModel>? get attractions => _attractions;

  /// Crear los setters de las variables de estado en caso de que se requiera

  /// Crear los métodos que modifican las variables de estado

  Future<void> initHomeScreen() async {
    await Future.wait([
      getCities(),
      getCategories(),
    ]);

    _selectedCity = _cities!.firstOrNull;
    _selectedCategory = _categories!.firstOrNull;

    if (_selectedCity == null || _selectedCategory == null) {
      debugPrint('No hay ciudades o categorías');
      _attractions = [];
      notifyListeners();
      return;
    }

    getAttractionsByCityAndCategory(
      cityId: _selectedCity!.id,
      categoryId: _selectedCategory!.id,
    );
  }

  Future<void> getCities() async {
    try {
      _cities = await _services.getCities();
    } catch (err) {
      _cities = [];
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getCategories() async {
    try {
      _categories = await _services.getCategories();
    } catch (err) {
      _categories = [];
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAttractionsByCityAndCategory({
    required int cityId,
    required int categoryId,
  }) async {
    try {
      _attractions = await _services.getAttractionsWithFilters(
        cityId: cityId,
        categoryId: categoryId,
      );
    } catch (err) {
      _attractions = [];
    } finally {
      notifyListeners();
    }
  }

  Future<void> onSelectedCityChanged(CityModel city) async {
    _selectedCity = city;
    _attractions = null;
    notifyListeners();
    if (_selectedCategory == null) return;
    await getAttractionsByCityAndCategory(
      cityId: _selectedCity!.id,
      categoryId: _selectedCategory!.id,
    );
  }

  Future<void> onSelectedCategoryChanged(CategoryModel category) async {
    _selectedCategory = category;
    _attractions = null;
    notifyListeners();
    await getAttractionsByCityAndCategory(
      cityId: _selectedCity!.id,
      categoryId: _selectedCategory!.id,
    );
  }
}
