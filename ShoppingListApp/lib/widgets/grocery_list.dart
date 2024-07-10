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

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  Future<void> _loadItems() async {
    final Uri url = Uri.https('flutter-groceries-6555c-default-rtdb.firebaseio.com', 'shopping-list.json');

    final http.Response response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);

    print(response.body);

    final List<GroceryItem> loadedData = [];

    for (final item in listData.entries) {
      final category =
          categories.entries.firstWhere((categoryItem) => categoryItem.value.name == item.value['category']).value;
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
    });
  }

  Future<void> _addItem() async {
    var newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (BuildContext context) => const NewItem(),
      ),
    );

    if (newItem == null) {   // back button was pressed instead of save button
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No items added yet!"),
    );

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _groceryItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).colorScheme.error,
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
