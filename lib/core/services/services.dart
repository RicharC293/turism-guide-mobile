import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:traveler_guide/core/models/category_model.dart';
import 'package:traveler_guide/core/models/city_model.dart';

import '../models/attraction_model.dart';

class Services {
  static final Services _instance = Services._internal();

  factory Services() {
    return _instance;
  }

  Services._internal();

  final _dio = Dio(BaseOptions(
      baseUrl: 'https://turism-guide-backend-cb48da8a6315.herokuapp.com/api'));

  Future<List<CityModel>> getCities() async {
    try {
      const url = '/cities';
      const queryParameters = {'populate': '*'};
      final response = await _dio.get(url, queryParameters: queryParameters);
      return List<CityModel>.from(response.data["data"]
          .map((city) => CityModel.fromJson(city))
          .toList());
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      const url = '/categories';
      const queryParameters = {'populate': '*'};
      final response = await _dio.get(url, queryParameters: queryParameters);
      return List<CategoryModel>.from(response.data["data"]
          .map((city) => CategoryModel.fromJson(city))
          .toList());
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }

  Future<List<AttractionModel>> getAttractionsWithFilters({
    int? cityId,
    int? categoryId,
    String? query,
  }) async {
    try {
      const url = '/attractions';
      final queryParameters = {
        'populate': '*',
        if (cityId != null) 'filters[city][id][\$eq]': cityId,
        if (categoryId != null) 'filters[categories][id][\$eq]': categoryId,
        if (query != null) 'filters[name][\$contains]': query,
        if (query != null) '[\$or]filters[name][\$contains]': query,
      };
      final response = await _dio.get(url, queryParameters: queryParameters);

      return List<AttractionModel>.from(response.data["data"]
          .map((attraction) => AttractionModel.fromJson(attraction))
          .toList());
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }

  Future<AttractionModel> getAttraction(int id) async {
    try {
      final url = '/attractions/$id';
      const queryParameters = {'populate': '*'};
      final response = await _dio.get(url, queryParameters: queryParameters);
      return AttractionModel.fromJson(response.data["data"]);
    } catch (err) {
      debugPrint('Error: $err');
      rethrow;
    }
  }
}
