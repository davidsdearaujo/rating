Rating bottom sheet 

## Features
<img src="https://user-images.githubusercontent.com/16373553/147670616-6aae2ee5-ddcc-4029-8c84-fb63fc27d7b9.gif" width="47%" /> <img src="https://user-images.githubusercontent.com/16373553/147670635-4dd7e23b-19a2-4ee5-b5b9-0d2ca90a8bf4.gif" width="47%" />

## Getting started
**pubspec.yaml**
```yaml
rating: <lastest version>
```

## Usage
Implement the `RatingController`
```dart
class PrintRatingController extends RatingController {
  PrintRatingController(RatingModel ratingModel) : super(ratingModel);

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
```

Create one `RatingModel`
```dart
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
```

Show the `Rating Widget` using the custom **Rating Controller** `PrintRatingController` and the new `RatingModel`
```dart
showModalBottomSheet(
  context: context,
  builder: (context) => RatingWidget(controller: PrintRatingController(ratingModel)),
);
```
