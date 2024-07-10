import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];

  bool _isLoading = true;
  String? _serverError;

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  Future<void> _loadItems() async {
    final Uri url = Uri.https('flutter-groceries-6555c-default-rtdb.firebaseio.com', 'shopping-list.json');

    // the response can have an other error (e.g. no internet connection, or wrong domain)
    // so for that I should use try catch.
    // important, use try only on the code that could generate an error, not on the whole code
    try {
      final http.Response response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _serverError = "Failed to fetch data. Please try again later.";
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });

        return;
      }
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedData = [];

      for (final item in listData.entries) {
        final category =
            categories.entries
                .firstWhere((categoryItem) => categoryItem.value.name == item.value['category'])
                .value;
        loadedData.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: int.parse(item.value['quantity']),
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedData;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _serverError = "Something went wrong. Please try again later.";
      });
    }
  }

  Future<void> _addItem() async {
    var newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (BuildContext context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      // back button was pressed instead of save button
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  Future<void> _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final Uri url = Uri.https('flutter-groceries-6555c-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      /// Optional can show a snack bar with an error message
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No items added yet!"),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _groceryItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme
                  .of(context)
                  .colorScheme
                  .error,
            ),
            onDismissed: (direction) {
              _removeItem(_groceryItems[index]);
            },
            key: ValueKey(_groceryItems[index].id),
            child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text("${_groceryItems[index].quantity}"),
            ),
          );
        },
      );
    }

    if (_serverError != null) {
      content = Center(
        child: Text(_serverError!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
