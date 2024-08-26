import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTabIndex = 0;

  final List<Meal> _favoriteMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilters;

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
    bool isContaining = _favoriteMeals.contains(meal);

    if (isContaining) {
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

  void _onSelectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final Map<Filters, bool>? _preferences = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (BuildContext context) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = _preferences ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> meals = ref.watch(mealsProvider);

    final List<Meal> _availableMeals = meals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }

      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget content = CategoriesScreen(
      onToggleMealToFavorite: _onToggleMealToFavorite,
      availableMeals: _availableMeals,
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
      drawer: MainDrawer(
        onSelectScreen: _onSelectScreen,
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
