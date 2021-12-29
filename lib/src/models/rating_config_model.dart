import 'rating_criterion_model.dart';

class RatingConfigModel {
  final int id;
  final String ratingSurvey1;
  final String ratingSurvey2;
  final String ratingSurvey3;
  final String ratingSurvey4;
  final String ratingSurvey5;
  final List<RatingCriterionModel> items;
  RatingConfigModel({
    required this.id,
    required this.ratingSurvey1,
    required this.ratingSurvey2,
    required this.ratingSurvey3,
    required this.ratingSurvey4,
    required this.ratingSurvey5,
    required this.items,
  });

  RatingConfigModel copyWith({
    int? id,
    String? ratingSurvey1,
    String? ratingSurvey2,
    String? ratingSurvey3,
    String? ratingSurvey4,
    String? ratingSurvey5,
    List<RatingCriterionModel>? items,
  }) {
    return RatingConfigModel(
      id: id ?? this.id,
      ratingSurvey1: ratingSurvey1 ?? this.ratingSurvey1,
      ratingSurvey2: ratingSurvey2 ?? this.ratingSurvey2,
      ratingSurvey3: ratingSurvey3 ?? this.ratingSurvey3,
      ratingSurvey4: ratingSurvey4 ?? this.ratingSurvey4,
      ratingSurvey5: ratingSurvey5 ?? this.ratingSurvey5,
      items: items ?? this.items,
    );
  }
}
