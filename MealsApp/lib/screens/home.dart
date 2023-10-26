import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  final List<Meal> _favoriteMeals = [];

  void _onSelectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _onToggleMealToFavorite(Meal meal) {
    bool isContaing = _favoriteMeals.contains(meal);

    if (isContaing) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("${meal.title} has been removed from favorites");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("${meal.title} has been added to favorites");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CategoriesScreen(
      onToggleMealToFavorite: _onToggleMealToFavorite,
    );
    String appBarTitle = 'Categories';

    if (_selectedTabIndex == 1) {
      content = MealsScreen(
        meals: _favoriteMeals,
        onToggleMealToFavorite: _onToggleMealToFavorite,
      );

      appBarTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _onSelectTab(index);
        },
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
