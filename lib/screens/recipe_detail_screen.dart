import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';
import 'package:recipes/domain/recipes.dart';
import '../utils_files/enum.dart';
import 'dart:ui' as ui;

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});
  
  void _onActionSelected(BuildContext context, MenuAction action){
  switch (action){
    case MenuAction.download:
    ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Download action triggered!')),
    );
    break;
    case MenuAction.share:
    ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Share action triggered!')),
    );
    break;
    case MenuAction.settings:
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: const IconThemeData(),
        elevation: 0,
        title: const Text('Recipes'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_horiz_outlined),
            onSelected: (MenuAction action) {
        _onActionSelected(context, action);
      },
            itemBuilder: (BuildContext context){
              return <PopupMenuEntry<MenuAction>>[
          const PopupMenuItem<MenuAction>(
            value: MenuAction.download,
            child: ListTile( // Use ListTile for a custom look
              leading: Icon(Icons.download),
              title: Text('Download'),
            ),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.share,
            child: ListTile( // Use ListTile for a custom look
              leading: Icon(Icons.share),
              title: Text('Share'),
            ),
          ),
        ];
            }
            )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                recipe.url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 120),
              ),
              
              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            recipe.title,
                                            style: Theme.of(context).textTheme.titleMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            recipe.description,
                                            style: Theme.of(context).textTheme.bodySmall,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.timer_outlined, size: 17,),
                                            const SizedBox(width: 5,),
                                            Text(
                                              recipe.prepTime,
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                        //const SizedBox(width: 18,),
                                        Row(
                                          children: [
                                           const Icon(Icons.star_border_outlined, size: 17,),
                                            const SizedBox(width: 5,),
                                            Text(
                                              recipe.rate.toString(),
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                           IconButton(
                                            onPressed: () {
                                             // code here 
                                            },
                                            icon: const Icon(Icons.thumb_up_outlined, size: 17,),
                                            ),
                                            const SizedBox(width: 5,),
                                            Text(
                                              recipe.rate.toString(),
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            provider.isSaved(recipe)
                                                ? Icons.bookmark
                                                : Icons.bookmark_border_outlined,
                                            color: provider.isSaved(recipe) ? Colors.deepPurple[200] : null,
                                            size: 18,
                                          ),
                                          onPressed: () => provider.toggleSaved(recipe),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget> [
                                        Text('View Steps', 
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500, 
                                                foreground: Paint()
                                                   ..shader = ui.Gradient.linear(
                                                    const Offset(150, 20),
                                                    const Offset(10, 20),
                                                    [const Color(0xFFE55275), const Color(0xFFA11F44),]
                                                   )
                                                ),
                                              ),
                                              //const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFFE55275),)
                                           IconButton(
                                            onPressed: (){
                                              // code here
                                            }, 
                                            icon: const Icon(Icons.keyboard_arrow_down_outlined,
                                            color: Color(0xFFE55275), 
                                            )
                                            )
                                      ],
                                    )
                                  ],
                                ),
                              ), 
            ],
          ),
        ),
      ),
    );
  }
}