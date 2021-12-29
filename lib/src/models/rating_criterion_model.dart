class RatingCriterionModel {
  final int id;
  final String name;
  RatingCriterionModel({
    required this.id,
    required this.name,
  });

  RatingCriterionModel copyWith({
    int? id,
    String? name,
  }) {
    return RatingCriterionModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'RatingCriterionModel(id: $id, name: $name)';
}
