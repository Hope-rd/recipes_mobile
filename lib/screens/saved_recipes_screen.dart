import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';

class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<RecipeProvider>(context).savedRecipes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: const Text("Bookmarks",style: TextStyle(),),
        iconTheme: const IconThemeData(),
        ),
      body: favorites.isEmpty
          ? const Center(child: Text("No saved recipes yet ❤️"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (ctx, i) {
                final r = favorites[i];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(r.url)),
                  title: Text(r.title),
                  trailing: IconButton(
                    icon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.primary),
                    onPressed: () => Provider.of<RecipeProvider>(context, listen: false).toggleSaved(r),
                  ),
                );
              },
            ),
    );
  }
}