import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_description.dart';
import 'package:meals_app/widgets/meals_list_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    Key? key,
    this.title,
    required this.meals,
    required this.onToggleMealToFavorite,
  }) : super(key: key);

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleMealToFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return MealDescriptionScreen(
          meal: meal,
          onToggleMealToFavorite: onToggleMealToFavorite,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh ... there are no favorite meals available",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting some favorite meals",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: meals.length,
        itemBuilder: (BuildContext context, int index) {
          return MealsListItem(
            meal: meals[index],
            onSelectMeal: () {
              _selectMeal(
                context,
                meals[index],
              );
            },
          );
        },
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
