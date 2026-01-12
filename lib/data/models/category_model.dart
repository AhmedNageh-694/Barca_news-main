/// Model representing a news category
class CategoryModel {
  final String image;
  final String categoryName;

  const CategoryModel({required this.image, required this.categoryName});

  /// Factory constructor to create a CategoryModel from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      image: json['image'] as String,
      categoryName: json['categoryName'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {'image': image, 'categoryName': categoryName};
  }

  /// Create a copy with modified fields
  CategoryModel copyWith({String? image, String? categoryName}) {
    return CategoryModel(
      image: image ?? this.image,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  String toString() => 'CategoryModel(categoryName: $categoryName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel &&
        other.image == image &&
        other.categoryName == categoryName;
  }

  @override
  int get hashCode => image.hashCode ^ categoryName.hashCode;
}
