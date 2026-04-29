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
        title: "recipe video!",
        description: "#chef alice.",
        prepTime: '',
        rate: 4.5,
        url: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        type: MediaType.video,
        thumbnailUrl: "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe"
      ),
      Recipe(
        id: 'r1',
        title: "recipes!",
        description: "#chef alice.",
        prepTime: '',
        rate: 4.5,
        url: "https://www.youtube.com/shorts/kjpwOGfA3to?feature=share.mp4",
        type: MediaType.video,
        thumbnailUrl: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624"
      ),
      Recipe(
        id: 'r1',
        title: "Easy One-Pot Beef Stew Favourite Dinner",
        description: "Easy One-Pot Beef Stew for a cozy family Favourite Dinner",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image

      ),
      Recipe(
        id: 'r2',
        title: "Sea Food Pasta",
        description: "Delicious seafood pasta with a rich tomato sauce",
        prepTime: '10 mins',
        rate: 4.8,
        url: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r3',
        title: "USA Trending Food Meals",
        description: "This popular Usa meals will blow your mind! || This is a very long description to test the overflow handling in the UI. It should be truncated with an ellipsis if it exceeds the available space.",
        prepTime: '5 mins',
        rate: 3.2,
        url: "https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjh8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r4',
        title: "Home Made Yummy!",
        description: "Sweet crispy sauce burger",
        prepTime: '45 mins',
        rate: 4.7,
        url: "https://images.unsplash.com/photo-1432139555190-58524dae6a55?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r5',
        title: "Classic Dinnner!",
        description: "Spicy tomato-based rice with veggies",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://images.unsplash.com/photo-1484980972926-edee96e0960d?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzF8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r6',
        title: "Saused Pasta!",
        description: "Delicious || saucy || Yummy",
        prepTime: '15 mins',
        rate: 4.5,
        url: "https://plus.unsplash.com/premium_photo-1673809798970-30c14cfd0ab6?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzd8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r7',
        title: "Meatball subs",
        description: "Rich cheesy & saucy meatbal sub delicacy",
        prepTime: '5 mins',
        rate: 5.0,
        url: "https://images.unsplash.com/photo-1432139509613-5c4255815697?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDN8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r8',
        title: "Jollof alike!",
        description: "Sweet chill time dripping dopped",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDZ8fGZvb2R8ZW58MHx8MHx8fDA%3D",
        type: MediaType.image
      ),
      Recipe(
        id: 'r9',
        title: "Ice filled!",
        description: "refill your rest time, stay energized.",
        prepTime: '30 mins',
        rate: 4.5,
        url: "https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzZ8fGZvb2R8ZW58MHx8MHx8fDA%3D",
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