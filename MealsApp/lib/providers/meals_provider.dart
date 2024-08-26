import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dumy_data.dart';
import 'package:meals_app/models/meal.dart';

final Provider<List<Meal>> mealsProvider = Provider(
  ((ref) => dummyMeals),
); // this mealProviders it provides to me the data i need for the meals, in this case the dummy data which contains the data about the meal
