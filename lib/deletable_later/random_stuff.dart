//.                    Note! everything here is just for reference purpose.

/* FOR COLORS:
 gradient: LinearGradient(
      colors: [
       Color(0xFFE55275),
       Color(0xFFA11F44),
      ],
    ),*/


    // dump junks


    /*import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build (BuildContext context){
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
              leading: const Icon(Icons.bookmark_border_outlined,),
              onTap: () {
          Navigator.pop(context); // close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SavedRecipesScreen()),
                  );
              },
              title: const Text('BookMarks'),
              ),
              ListTile(
              leading: const Icon(Icons.info_rounded,),
              onTap: () {
          // code here
              },
              title: const Text('About'),
              ),
              ListTile(
              leading: const Icon(Icons.logout,),
              onTap: () {
          // code here
              },
              title: const Text('Logout'),
              )
            ],
          ),
        ),
      );
  }
}

void _selectCategories(){
if (categories.Quick){
filter by time;
} else if (categories.Nigeria){
filter by location;
} else if (categories.SmartSuggestion){
request user inputs,
return suggestions;
} else if (categories.Trending){
filter by most popular;
} else {
return recipes;
}
}


Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.network(
                                  recipe.url,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                                ),
                                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined)),
                              ],
                            ),
*/

// To import a random image from the internet, just click on the image and copy the image address.