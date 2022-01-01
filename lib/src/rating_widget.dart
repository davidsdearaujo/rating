import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'rating_controller.dart';
import 'rating_cubit.dart';
import 'widgets/criterion_button_widget.dart';
import 'widgets/default_button.dart';
import 'widgets/stars_widget.dart';

class RatingWidget extends StatefulWidget {
  final RatingController controller;
  const RatingWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  final animationDuration = const Duration(milliseconds: 800);
  final animationCurve = Curves.ease;
  var review = tr('submit'),
  int selectedRate = 0;
  late RatingController controller = widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.listenStateChanges(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String get ratingSurvey {
    final options = [
      '',
      controller.ratingModel.ratingConfig.ratingSurvey1,
      controller.ratingModel.ratingConfig.ratingSurvey2,
      controller.ratingModel.ratingConfig.ratingSurvey3,
      controller.ratingModel.ratingConfig.ratingSurvey4,
      controller.ratingModel.ratingConfig.ratingSurvey5,
    ];
    return options.length > selectedRate ? options[selectedRate] : options.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingState>(
      bloc: controller.ratingCubit,
      buildWhen: (previous, current) => current is LoadingState || previous is LoadingState,
      builder: (context, state) {
        final isLoading = state is LoadingState;
        return IgnorePointer(
          ignoring: isLoading,
          child: AnimatedPadding(
            duration: animationDuration,
            curve: animationCurve,
            padding: EdgeInsets.symmetric(horizontal: selectedRate == 0 ? 50 : 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                if (controller.ratingModel.title != null) ...{
                  Text(
                    controller.ratingModel.title!,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                },
                const SizedBox(height: 10),
                if (controller.ratingModel.subtitle != null) ...{
                  Text(controller.ratingModel.subtitle!),
                },
                const SizedBox(height: 20),
                AnimatedContainer(
                  duration: animationDuration,
                  curve: animationCurve,
                  width: selectedRate == 0 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.4,
                  child: FittedBox(
                    child: StarsWidget(
                      selectedColor: Colors.amber,
                      selectedLenght: selectedRate,
                      unselectedColor: Colors.grey,
                      length: 5,
                      onChanged: (count) {
                        setState(() => selectedRate = count);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedAlign(
                  duration: animationDuration,
                  curve: animationCurve,
                  alignment: Alignment.topCenter,
                  heightFactor: selectedRate == 0 ? 0 : 1,
                  child: AnimatedOpacity(
                    duration: animationDuration,
                    curve: animationCurve,
                    opacity: selectedRate == 0 ? 0 : 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 14),
                        Text(
                          ratingSurvey,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.9,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.from(controller.ratingModel.ratingConfig.items.map(
                            (criterion) => CriterionButton(
                              text: criterion.name,
                              onSelectChange: (selected) => controller.ratingCubit.selectedCriterionsUpdate(criterion, selected),
                            ),
                          )),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    AnimatedOpacity(
                      duration: animationDuration,
                      curve: animationCurve,
                      opacity: selectedRate == 0 ? 0 : 1,
                      child: Center(
                        child: DefaultButton.text(
                          "submit",
                          textColor: Colors.white,
                          color: Theme.of(context).colorScheme.secondary,
                          outlineColor: Theme.of(context).colorScheme.secondary,
                          onPressed: () => controller.ratingCubit.saveRate(selectedRate),
                          isLoading: isLoading,
                        ),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: selectedRate != 0,
                      child: AnimatedOpacity(
                        duration: animationDuration,
                        curve: animationCurve,
                        opacity: selectedRate == 0 ? 1 : 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DefaultButton(
                            outline: false,
                            flat: true,
                            color: Colors.transparent,
                            textColor: const Color(0xFF2F333A),
                            onPressed: () => controller.ratingCubit.ignoreForEver(),
                            isLoading: isLoading,
                            child: const Text(
                              "back",
                              style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 12),
                            ).tr(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
