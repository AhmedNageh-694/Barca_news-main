/// Model representing a news article
class ArticleModel {
  final String? image;
  final String title;
  final String? subtitle;

  const ArticleModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  /// Factory constructor to create an ArticleModel from JSON
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['urlToImage'] as String?,
      title: json['title'] as String? ?? '',
      subtitle: json['description'] as String?,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {'urlToImage': image, 'title': title, 'description': subtitle};
  }

  @override
  String toString() => 'ArticleModel(title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ArticleModel &&
        other.image == image &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ subtitle.hashCode;
}
