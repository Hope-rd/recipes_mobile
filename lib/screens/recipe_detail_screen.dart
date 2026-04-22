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
                                padding: const EdgeInsets.only(left: 18, top: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            recipe.title,
                                            style: Theme.of(context).textTheme.headlineSmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          color: Theme.of(context).colorScheme.surface,
                                          elevation: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                          children: [
                                            const Icon(Icons.timer_outlined, size: 17,),
                                            const SizedBox(width: 5,),
                                            Text(
                                              recipe.prepTime,
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 11,),
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
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        Card(
                                          color: Theme.of(context).colorScheme.surface,
                                          elevation: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                          children: [
                                            const Text('Views', style: TextStyle(fontSize: 12),),
                                            const SizedBox(width: 5,),
                                            Text(
                                              recipe.rate.toString(),
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        Card(
                                          color: Theme.of(context).colorScheme.surface,
                                          elevation: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                          children: [
                                            const  Icon(Icons.thumb_up_alt_outlined, size: 17,),
                                            const SizedBox(width: 35,),
                                            const  Icon(Icons.message_outlined, size: 17,),
                                            const SizedBox(width: 35,),
                                            Icon(
                                            provider.isSaved(recipe)
                                                ? Icons.bookmark
                                                : Icons.bookmark_border_outlined,
                                            color: provider.isSaved(recipe) ? Colors.deepPurple[100] : null,
                                            size: 17,
                                          ),
                                          ],
                                        ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3,),
                                        Text(
                                          recipe.description,
                                          style: Theme.of(context).textTheme.labelSmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    /*Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                         onPressed: () {
                                          // code here 
                                         },
                                         child: Row(
                                          children: const [
                                             Icon(Icons.thumb_up_alt_outlined, size: 20,),
                                             SizedBox(width: 3,),
                                             Text('react')
                                          ],
                                         ),
                                         ),
                                         const SizedBox(width: 5,),
                                         ElevatedButton(
                                         onPressed: () => provider.toggleSaved(recipe),
                                         child: Row(
                                          children: [
                                             Icon(
                                            provider.isSaved(recipe)
                                                ? Icons.bookmark
                                                : Icons.bookmark_border_outlined,
                                            color: provider.isSaved(recipe) ? Colors.deepPurple[100] : null,
                                            size: 20,
                                          ),
                                            const SizedBox(width: 3,),
                                            const Text('save')
                                          ],
                                         ),
                                         ),
                                        /*IconButton(
                                          icon: Icon(
                                            provider.isSaved(recipe)
                                                ? Icons.bookmark
                                                : Icons.bookmark_border_outlined,
                                            color: provider.isSaved(recipe) ? Colors.deepPurple[200] : null,
                                            size: 20,
                                          ),
                                          onPressed: () => provider.toggleSaved(recipe),
                                        ),*/
                                      ],
                                    ),*/
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