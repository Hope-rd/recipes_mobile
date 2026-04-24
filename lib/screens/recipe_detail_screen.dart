//import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';
import 'package:recipes/domain/recipes.dart';
import 'package:recipes/screens/profile_screen.dart';
import '../utils_files/enum.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 120,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BackButton(),
            GestureDetector(
              onTap: () {
                // navigate to profile screen.
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1659354219028-cae11db067c4?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                radius: 12,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(),
        elevation: 0,
        title: const Text(''),
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
                                padding: const EdgeInsets.only(left: 18, right: 15, top: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            recipe.title,
                                            style: Theme.of(context).textTheme.titleLarge,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                        Text(
                                          recipe.description,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          color: Theme.of(context).cardTheme.color,
                                          //elevation: 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                            children: [
                                              const Icon(Icons.av_timer_outlined, size: 15,),
                                              Text(
                                                recipe.prepTime,
                                                style: Theme.of(context).textTheme.labelSmall,
                                              ),
                                            ],
                                             ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //const SizedBox(width: 3,),
                                        Card(
                                          color: Theme.of(context).cardTheme.color,
                                          //elevation: 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                             const Icon(Icons.star_rate_outlined, size: 15,),
                                              Text(
                                                recipe.rate.toString(),
                                                style: Theme.of(context).textTheme.labelSmall,
                                              ),
                                            ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //const SizedBox(width: 3,),
                                        Card(
                                          color: Theme.of(context).cardTheme.color,
                                          //elevation: 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                            children: [
                                               const Icon(Icons.remove_red_eye_sharp, size: 15,),
                                              Text(
                                                recipe.rate.toString(),
                                                style: Theme.of(context).textTheme.labelSmall,
                                              ),
                                            ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //const SizedBox(width: 3,),
                                        Card(
                                          color: Theme.of(context).cardTheme.color,
                                          //elevation: 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                            children: [
                                               GestureDetector(
                                                onTap: () {
                                                  // Handle like tap
                                                },
                                            child: Icon(
                                            color: Theme.of(context).iconTheme.color,
                                              Icons.thumb_up_alt_outlined, size: 15,
                                                ),
                                          ),
                                              Text(
                                                recipe.rate.toString(),
                                                style: Theme.of(context).textTheme.labelSmall,
                                              ),
                                            ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //const SizedBox(width: 3,),
                                        Card(
                                          color: Theme.of(context).cardTheme.color,
                                          //elevation: 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                            children: [
                                               GestureDetector(
                                                onTap: () {
                                                  // Handle comment tap
                                                },
                                            child: Icon(
                                            color: Theme.of(context).iconTheme.color,
                                              Icons.chat_bubble_outline_rounded, size: 15,
                                                ),
                                          ),
                                              Text(
                                                recipe.rate.toString(),
                                                style: Theme.of(context).textTheme.labelSmall,
                                              ),
                                            ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //const SizedBox(width: 3,),
                                        Card(
                                          color: Theme.of(context).cardTheme.color,
                                          //elevation: 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              onTap: () => provider.toggleSaved(recipe),
                                            child: Icon(
                                            provider.isSaved(recipe)
                                                ? Icons.bookmark_added_rounded
                                                : Icons.bookmark_add_outlined,
                                            color: provider.isSaved(recipe) ? Colors.deepOrange : null,
                                            size: 20,
                                                ),
                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: (){}, 
                                          child: const Text('Save', style: TextStyle(color: Colors.white),)
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                      width: double.infinity,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Ingredients:', style: Theme.of(context).textTheme.bodySmall,),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                              Text('Small Chops'),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      width: double.infinity,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Preparation:', style: Theme.of(context).textTheme.bodySmall,),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                              Text('Preparation will be precise and clear.'),
                                            ],
                                          ),
                                        )
                                      ),
                                    )
            ],
          ),
        ),
      ),
    );
  }
}