import 'rating_config_model.dart';

class RatingModel {
  final int id;
  final String? title;
  final String? subtitle;
  final RatingConfigModel ratingConfig;

  RatingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.ratingConfig,
  });

  RatingModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    RatingConfigModel? ratingConfig,
  }) {
    return RatingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      ratingConfig: ratingConfig ?? this.ratingConfig,
    );
  }
}
