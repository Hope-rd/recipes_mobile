// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';
import 'package:recipes/screens/video_catalog_screen.dart';
import '../domain/recipes.dart';
import '../providers/visibility_provider.dart';
import '../utils_files/responsive_utils.dart';
import 'recipe_detail_screen.dart';
import 'package:recipes/providers/scroll_controller.dart';


class Catalogs extends StatelessWidget {
   const Catalogs({super.key});

  @override
  Widget build (BuildContext context){
    final provider = Provider.of<RecipeProvider>(context);
    final scrollController = Provider.of<ScrollControllerProvider>(context, listen: false).scrollController;
    final visibilityProvider = Provider.of<NavVisibilityProvider>(context, listen: false);

    _setupScrollListener(scrollController, visibilityProvider);
    const double searchHeight = 84.0;

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
          recipe.thumbnailUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.withValues(alpha: 0.7),
            shape: BoxShape.circle
          ),
          child: Center(
            child: Icon(
              Icons.play_arrow_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.secondary,
            ),
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
        if (!scrollController.hasListeners) {
        scrollController.addListener(() {
          visibilityProvider.onScroll(scrollController);
        });
      }
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        minimum: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ValueListenableBuilder<bool>(
              valueListenable: visibilityProvider.isVisible, 
              builder: (context, isVisible, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  height: isVisible ? searchHeight : 0,
                  curve: Curves.easeOut,
                  child: isVisible
                  ? Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   mainAxisSize: MainAxisSize.max,
                   children: [
                    TextButton(
                  onPressed: () {
                    provider.loadRecipes();
                  }, 
                  child: Text("All",
                  style: Theme.of(context).textTheme.headlineSmall,)
                ),

                    GestureDetector(
                onTap: (){
                  // Navigate to search screen
                  showSearch(
                  context: context,
                  delegate: RecipeSearchDelegate(provider),
                );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  margin: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[600],),
                      SizedBox(width: 10),
                      Text(
                        'Search recipes...',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),

              Stack(
                  alignment: Alignment.topRight,
                   children: [
                     IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.notifications_active_outlined, color: Colors.grey[900],)
                    ),
                     Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle
                      ),
                      child: Center(child: Text("10", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),)),
                     )
                   ],
              ),
                   ], 
                  )
              : const SizedBox.shrink(),
                  );
              }
              ),
              ],
            ),
        
        Expanded(
          child: Consumer<RecipeProvider>(
          builder: (context, provider, child) {
            if (provider.recipes.isEmpty) {
              return  Center(
                child: CircularProgressIndicator(color: Colors.blueGrey.withValues(alpha: 0.7),)
                );
            }
        
            return RefreshIndicator(
              onRefresh: provider.loadRecipes,
              child: MasonryGridView.builder(
                controller: scrollController,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getGridCrossAxisCount(context),
                ),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 0.0,
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
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  );
                },
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

// ==================== SCROLL LISTENER HELPER ====================
  void _setupScrollListener(ScrollController controller, NavVisibilityProvider visibilityProvider) {
  // Prevent adding the listener multiple times
  if (controller.hasListeners) return;

  double lastOffset = 0.0;
  const double threshold = 10.0;   // ← Tune this (20-40 works well)

  controller.addListener(() {
    if (!controller.hasClients) return;

    final currentOffset = controller.offset;
    final direction = controller.position.userScrollDirection;

    bool shouldHide = visibilityProvider.isVisible.value; // current state

    if (direction == ScrollDirection.reverse) {
      if (currentOffset - lastOffset > threshold) {
        shouldHide = true;
      }
    } else if (direction == ScrollDirection.forward) {
      if (lastOffset - currentOffset > threshold) {
        shouldHide = false;
      }
    }

    if (shouldHide != visibilityProvider.isVisible.value) {
      visibilityProvider.onScroll(controller);
    }

    lastOffset = currentOffset;
  });
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