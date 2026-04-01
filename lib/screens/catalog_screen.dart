// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';
import 'package:recipes/screens/video_catalog_screen.dart';
import '../domain/recipes.dart';
import '../utils_files/responsive_utils.dart';
import 'recipe_detail_screen.dart';


class Catalogs extends StatelessWidget {
   const Catalogs({super.key});

  @override
  Widget build (BuildContext context){
    final provider = Provider.of<RecipeProvider>(context);

    Widget buildMedia(Recipe recipe) {
  if (recipe.type == MediaType.image) {
    return Image.network(
      recipe.url,
      fit: BoxFit.cover,
      width: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const AspectRatio(
          aspectRatio: 4 / 3, // fallback to avoid layout jumps
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  } else {
    // Video: Show thumbnail with play icon
    return Stack(
      alignment: Alignment.center,
      children: [
        // Use video's first frame or a poster image (many video APIs provide thumbnails)
        Image.network(
          recipe.url,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const Center(
          child: Icon(
            Icons.play_circle_fill,
            size: 64,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

    // Load recipes once when screen appears
    if (provider.recipes.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.loadRecipes();
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                // Navigate to search screen
                showSearch(
                context: context,
                delegate: RecipeSearchDelegate(provider),
              );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 1, // How much the shadow spreads
                      blurRadius: 3, // The softness of the shadow
                      offset: Offset(1, 1), // Moves the shadow down by 3 pixels
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey,),
                    SizedBox(width: 10),
                    Text(
                      'Search recipes...',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
        Expanded(
          child: Consumer<RecipeProvider>(
          builder: (context, provider, child) {
            if (provider.recipes.isEmpty) {
              return const Center(child: CircularProgressIndicator(color: Colors.grey,));
            }
        
            return RefreshIndicator(
              onRefresh: provider.loadRecipes,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MasonryGridView.builder(
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getGridCrossAxisCount(context),
                  ),
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  itemCount: provider.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = provider.recipes[index];
                    return GestureDetector(
                      onTap: () {
                        if (recipe.type == MediaType.image){
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                        } else {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerPage(
                               videoUrl: recipe.url,        // from url list
                          ),
                        ),
                      );
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                buildMedia(recipe),
                              ],
                            ),
                          ),
                          Text(
                            recipe.title,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
          )
          ],
        )
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate<String> {
  final RecipeProvider provider;

  RecipeSearchDelegate(this.provider);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear,),
        onPressed: () {
          query = '';
          provider.setSearchQuery('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back,),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    provider.setSearchQuery(query);
    return _buildSearchResultGrid(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    provider.setSearchQuery(query);
    return _buildSearchResultGrid(context);
  }

  Widget _buildSearchResultGrid(BuildContext context) {
    final filtered = provider.recipes;

    if (filtered.isEmpty) {
      return const Center(child: Text("No recipes found"));
    }

    return Padding(
                padding: const EdgeInsets.all(12.0),
                child: MasonryGridView.builder(
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getGridCrossAxisCount(context),
                  ),
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final recipe = filtered[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: recipe),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              recipe.url,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
       );
  }
}