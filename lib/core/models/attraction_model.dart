class AttractionModel {
  final int id;
  final String name;
  final String headerImage;
  final List<String> images;
  final String description;
  final int rating;
  final String cityName;

  AttractionModel({
    required this.id,
    required this.name,
    required this.headerImage,
    required this.images,
    required this.description,
    required this.rating,
    required this.cityName,
  });

  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    return AttractionModel(
      id: json['id'],
      name: json['attributes']?['name'] ?? '',
      headerImage: json['attributes']?['header_image'] ?? '',
      images: List<String>.from(
          json['attributes']?['images']?["images"]?.map((x) => x) ?? []),
      description: json['attributes']?['description'] ?? '',
      rating: json['attributes']?['rating'] ?? 0,
      cityName:
          json['attributes']?['city']?['data']?["attributes"]?["name"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'headerImage': headerImage,
      'images': images,
      'description': description,
      'rating': rating,
      'cityName': cityName,
    };
  }

  AttractionModel copyWith({
    int? id,
    String? name,
    String? headerImage,
    List<String>? images,
    String? description,
    int? rating,
    String? cityName,
  }) {
    return AttractionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      headerImage: headerImage ?? this.headerImage,
      images: images ?? this.images,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      cityName: cityName ?? this.cityName,
    );
  }
}
