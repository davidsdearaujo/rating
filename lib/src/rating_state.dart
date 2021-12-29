import 'package:meta/meta.dart';

import 'models/rating_criterion_model.dart';

@immutable
abstract class RatingState {}

class IdleState extends RatingState {}

class LoadingState extends RatingState {
  final String message;
  LoadingState(this.message);
}

class CloseDialogState extends RatingState {
  final bool isIgnored;

  CloseDialogState(this.isIgnored);
}

class SelectedCriterionsState extends RatingState {
  final Set<RatingCriterionModel> selectedCriterions;
  SelectedCriterionsState(this.selectedCriterions);
}

class RateState extends RatingState {
  final int rateCount;
  final List<RatingCriterionModel> criterions;

  RateState({required this.rateCount, required this.criterions});
}
