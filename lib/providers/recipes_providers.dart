// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:recipes/domain/recipes.dart';


class RecipeProvider with ChangeNotifier {
  List<Recipe> _allRecipes = [];  // displays all lists
  List<Recipe> _filteredRecipes = []; // for searches
  List<Recipe> _savedRecipes = [];  // for saved recipes only

  String _searchQuery = '';

  // Getters
  List<Recipe> get recipes => _filteredRecipes;
  List<Recipe> get savedRecipes => _savedRecipes;
  

  bool isSaved(Recipe recipe) => _savedRecipes.any((r) => r.id == recipe.id);


  // Load local data (simulate delay)
  Future<void> loadRecipes() async {
    await Future.delayed(const Duration(seconds: 1));

    _allRecipes = [
      Recipe(
        id: 'r1',
        title: "Easy One-Pot Beef Stew Favourite Dinner",
        description: "Easy One-Pot Beef Stew for a cozy family Favourite Dinner",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://i.pinimg.com/1200x/3e/0e/2c/3e0e2c70609462eb5ff1cf392f653d4a.jpg",
        type: MediaType.video
      ),
      Recipe(
        id: 'r2',
        title: "StrawBerry Banana",
        description: "cool recipes after tough days",
        prepTime: '10 mins',
        rate: 4.8,
        url: "https://i.pinimg.com/1200x/b7/dd/90/b7dd90a9f66b52d51607565298a264fc.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r3',
        title: "USA Trending Food Meal",
        description: "Rich US rice delicacy",
        prepTime: '5 mins',
        rate: 3.2,
        url: "https://i.pinimg.com/736x/50/67/8e/50678e76bab3cd9a1623f6201b10cd6d.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r4',
        title: "Home Made Yummy!",
        description: "Sweet crispy sauce burger",
        prepTime: '45 mins',
        rate: 4.7,
        url: "https://i.pinimg.com/736x/5a/fd/83/5afd8349808ece4505e86a2ef91dc06b.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r5',
        title: "Classic Dinnner!",
        description: "Spicy tomato-based rice with veggies",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://i.pinimg.com/1200x/f7/77/b5/f777b5136f6bc47fe13d7ddd9350d67a.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r6',
        title: "BlackBerry Drinks",
        description: "BlackBerry || Drinks || Yummy",
        prepTime: '15 mins',
        rate: 4.5,
        url: "https://i.pinimg.com/736x/90/70/37/907037dd2bbe56e51073b2f9f5b2f916.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r7',
        title: "Meatball subs",
        description: "Rich cheesy & saucy meatbal sub delicacy",
        prepTime: '5 mins',
        rate: 5.0,
        url: "https://i.pinimg.com/1200x/85/c3/de/85c3dec46e77529ddc41c788d23193ef.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r8',
        title: "ChillDrips!",
        description: "Sweet chill time dripping dopped",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://i.pinimg.com/736x/3c/79/d3/3c79d31f1a4ac7780667d402385dd018.jpg",
        type: MediaType.image
      ),
      Recipe(
        id: 'r9',
        title: "Ice filled!",
        description: "Rest time enhancer",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://i.pinimg.com/736x/8f/b1/49/8fb14952b170d17fc022444f7bc7ccec.jpg",
        type: MediaType.image
      ),
      // Add more recipes...
    ];

    _filteredRecipes = List.from(_allRecipes);
    notifyListeners();
  }

  // Search
  void setSearchQuery(String query) {
  if (query == _searchQuery) return; // optional: avoid unnecessary work

  _searchQuery = query.toLowerCase();

  // Do the filtering synchronously (cheap operation)
  final newFiltered = _allRecipes.where((r) {
    return r.title.toLowerCase().contains(_searchQuery) ||
           r.description.toLowerCase().contains(_searchQuery);
  }).toList();

  // But notify **after** current frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _filteredRecipes = newFiltered;
    notifyListeners();
  });
}

  // Favorite toggle
  void toggleSaved(Recipe recipe) {
    if (isSaved(recipe)) {
      _savedRecipes.removeWhere((r) => r.id == recipe.id);
    } else {
      _savedRecipes.add(recipe..isSaved = true);
    }
    notifyListeners();
  }

}