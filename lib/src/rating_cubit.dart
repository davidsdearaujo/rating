// ignore_for_file: unused_catch_stack

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/rating_criterion_model.dart';
import 'models/rating_model.dart';
import 'rating_state.dart';

export 'rating_state.dart';

typedef IgnoreForEverCallback = Future<void> Function();
typedef SaveRatingCallback = Future<void> Function(int rate, List<RatingCriterionModel> selectedCriterions);

class RatingCubit extends Cubit<RatingState> {
  final IgnoreForEverCallback _ignoreForEverCallback;
  final SaveRatingCallback _saveRatingCallback;
  final RatingModel model;

  RatingCubit(this.model, this._ignoreForEverCallback, this._saveRatingCallback) : super(IdleState());

  final selectedCriterions = <RatingCriterionModel>{};

  Future<void> ignoreForEver() async {
    try {
      emit(LoadingState("Cancelando..."));
      await _ignoreForEverCallback.call();
      emit(CloseDialogState(true));
    } catch (ex, stack) {
      debugPrint('$ex');
      // addError(ex);
      emit(CloseDialogState(false));
    }
  }

  void selectedCriterionsUpdate(RatingCriterionModel criterion, bool isAdded) {
    if (isAdded) selectedCriterions.add(criterion);
    if (!isAdded) selectedCriterions.removeWhere((item) => item.id == criterion.id);
    emit(SelectedCriterionsState(selectedCriterions));
  }

  void saveRate(int rate) async {
    try {
      emit(LoadingState("Enviando Avaliação..."));
      await _saveRatingCallback.call(rate, selectedCriterions.toList());
      emit(CloseDialogState(false));
    } catch (ex, stack) {
      debugPrint('$ex');
      // addError(ex);
      emit(CloseDialogState(false));
    }
  }
}
