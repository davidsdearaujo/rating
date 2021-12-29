// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:rating/rating.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: const Text('Rating Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Rate with modal bottom sheet'),
              onPressed: () {
                final ratingModel = RatingModel(
                  id: 1,
                  title: null,
                  subtitle: 'Classifique nosso app:',
                  ratingConfig: RatingConfigModel(
                    id: 1,
                    ratingSurvey1: 'Em que podemos melhorar?',
                    ratingSurvey2: 'Em que podemos melhorar?',
                    ratingSurvey3: 'Em que podemos melhorar?',
                    ratingSurvey4: 'Em que podemos melhorar?',
                    ratingSurvey5: 'O que você mais gostou?',
                    items: [
                      RatingCriterionModel(id: 1, name: 'Qualidade do atendimento'),
                      RatingCriterionModel(id: 2, name: 'Competência dos atendentes'),
                      RatingCriterionModel(id: 3, name: 'Limpeza do ambiente'),
                      RatingCriterionModel(id: 4, name: 'Tempo de espera'),
                    ],
                  ),
                );
                showModalBottomSheet(
                  context: context,
                  builder: (context) => RatingWidget(controller: MockRatingController(ratingModel)),
                );
              },
            ),
            const SizedBox(height: 25),

            //To use custom duration, is necessary creating a new AnimationController.
            //The AnimationController needs the TickerProviderStateMixin mixin into current class
            ElevatedButton(
              child: const Text('Rate with Custom Duration'),
              onPressed: () {
                final ratingModel = RatingModel(
                  id: 1,
                  title: 'Deivão Store',
                  subtitle: 'Classifique este estabelecimento',
                  ratingConfig: RatingConfigModel(
                    id: 1,
                    ratingSurvey1: 'Em que podemos melhorar?',
                    ratingSurvey2: 'Em que podemos melhorar?',
                    ratingSurvey3: 'Em que podemos melhorar?',
                    ratingSurvey4: 'Em que podemos melhorar?',
                    ratingSurvey5: 'O que você mais gostou?',
                    items: [
                      RatingCriterionModel(id: 1, name: 'Qualidade do atendimento'),
                      RatingCriterionModel(id: 2, name: 'Competência dos atendentes'),
                      RatingCriterionModel(id: 3, name: 'Limpeza do ambiente'),
                      RatingCriterionModel(id: 4, name: 'Tempo de espera'),
                    ],
                  ),
                );
                scaffoldKey.currentState?.showBottomSheet(
                  (context) => RatingWidget(controller: MockRatingController(ratingModel)),
                  transitionAnimationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 500)),
                );
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              child: const Text('Rate with Scaffold Key'),
              onPressed: () {
                final ratingModel = RatingModel(
                  id: 1,
                  title: 'Deixe sua nota',
                  subtitle: 'Está gostando do app?',
                  ratingConfig: RatingConfigModel(
                    id: 1,
                    ratingSurvey1: 'Em que podemos melhorar?',
                    ratingSurvey2: 'Em que podemos melhorar?',
                    ratingSurvey3: 'Em que podemos melhorar?',
                    ratingSurvey4: 'Em que podemos melhorar?',
                    ratingSurvey5: 'O que você mais gostou?',
                    items: [
                      RatingCriterionModel(id: 1, name: 'Qualidade do atendimento'),
                      RatingCriterionModel(id: 2, name: 'Competência dos atendentes'),
                      RatingCriterionModel(id: 3, name: 'Limpeza do ambiente'),
                      RatingCriterionModel(id: 4, name: 'Tempo de espera'),
                    ],
                  ),
                );
                scaffoldKey.currentState?.showBottomSheet(
                  (context) => RatingWidget(controller: MockRatingController(ratingModel)),
                );
              },
            ),
            const SizedBox(height: 25),

            //For found the current Scaffold by the context, is necessary create a new context scope.
            //For create new context scope, we can use the Builder widget.
            Builder(builder: (context) {
              return ElevatedButton(
                child: const Text('Rate with current Scaffold'),
                onPressed: () {
                  final ratingModel = RatingModel(
                    id: 1,
                    title: null,
                    subtitle: 'Classifique nosso app:',
                    ratingConfig: RatingConfigModel(
                      id: 1,
                      ratingSurvey1: 'Em que podemos melhorar?',
                      ratingSurvey2: 'Em que podemos melhorar?',
                      ratingSurvey3: 'Em que podemos melhorar?',
                      ratingSurvey4: 'Em que podemos melhorar?',
                      ratingSurvey5: 'O que você mais gostou?',
                      items: [
                        RatingCriterionModel(id: 1, name: 'Qualidade do atendimento'),
                        RatingCriterionModel(id: 2, name: 'Competência dos atendentes'),
                        RatingCriterionModel(id: 3, name: 'Limpeza do ambiente'),
                        RatingCriterionModel(id: 4, name: 'Tempo de espera'),
                      ],
                    ),
                  );
                  Scaffold.of(context).showBottomSheet(
                    (context) => RatingWidget(controller: MockRatingController(ratingModel)),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class MockRatingController extends RatingController {
  MockRatingController(RatingModel ratingModel) : super(ratingModel);

  @override
  Future<void> ignoreForEverCallback() async {
    print('Rating ignored forever!');
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Future<void> saveRatingCallback(int rate, List<RatingCriterionModel> selectedCriterions) async {
    print('Rating saved!\nRate: $rate\nsSelectedItems: $selectedCriterions');
    await Future.delayed(const Duration(seconds: 3));
  }
}
