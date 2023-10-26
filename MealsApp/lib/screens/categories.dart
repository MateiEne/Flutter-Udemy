import 'package:flutter/material.dart';
import 'package:meals_app/data/dumy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/categories_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    required this.onToggleMealToFavorite,
    Key? key,
  }) : super(key: key);

  final void Function(Meal meal) onToggleMealToFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> categoriesMeals = dummyMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: categoriesMeals,
          onToggleMealToFavorite: onToggleMealToFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: availableCategories
          .map(
            (categoryItem) => CategoriesGridItem(
              category: categoryItem,
              onSelectCategory: () {
                _selectCategory(
                  context,
                  categoryItem,
                );
              },
            ),
          )
          .toList(),
    );
  }
}
