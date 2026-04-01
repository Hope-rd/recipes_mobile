import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';
import 'package:recipes/screens/settings_screen.dart';
import 'saved_recipes_screen.dart';
import '../utils_files/enum.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  void _onActionSelected(BuildContext context, ActionsMenu action){
  switch (action){
    case ActionsMenu.settings:
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (_) => const Settings()),
      );
    break;
  }
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final savedCount = provider.savedRecipes.length;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton(
            icon: const Icon(Icons.more_horiz_outlined),
            onSelected: (ActionsMenu action) {
        _onActionSelected(context, action);
      },
            itemBuilder: (BuildContext context){
              return <PopupMenuEntry<ActionsMenu>>[
          const PopupMenuItem<ActionsMenu>(
            value: ActionsMenu.settings,
            child: ListTile( // Use ListTile for a custom look
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ),
        ];
            }
            )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://media.licdn.com/dms/image/v2/D4D03AQFbjy1W2H_tsw/profile-displayphoto-crop_800_800/B4DZgjez68HAAI-/0/1752941937247?e=1776297600&v=beta&t=FODw9PkoppD_5Ll31207rTE20JNJTlsvZiQidVCuCpU'), // placeholder
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Hope rd',  // or pull from future auth
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lagos, Nigeria • Learning to cook better',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SavedRecipesScreen()),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.bookmark),
                          title: const Text('Saved Recipes'),
                          trailing: Text('$savedCount'),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'More features coming: notes, ratings, video lessons...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}