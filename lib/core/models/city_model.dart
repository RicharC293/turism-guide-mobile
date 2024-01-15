import 'category_model.dart';

class CityModel {
  final int id;
  final String name;

  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['attributes']?['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  CityModel copyWith({
    int? id,
    String? name,
    List<CategoryModel>? categories,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
