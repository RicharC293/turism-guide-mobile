class CategoryModel {
  final int id;
  final String name;
  final String image;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['attributes']?['name'] ?? '',
      image: json['attributes']?['image_url'] ?? '',
      isActive: json['attributes']?['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isActive': isActive,
    };
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
    bool? isActive,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
    );
  }
}
