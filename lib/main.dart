import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_providers.dart';
import 'package:recipes/theme/theme_Provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/main_screen.dart';
import 'package:recipes/theme/theme.dart';

void main(){
  runApp(
    MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context)  => RecipeProvider(),),
   ChangeNotifierProvider (create: (context)  => NavigationProvider(),),
   ChangeNotifierProvider (create: (context)  => ThemeProvider(),),
  ],
  child: const MyApp(),
),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build (BuildContext context){
    return  Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
        return MaterialApp(
      title: 'Recipes',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeProvider.themeMode,
      home: Mainscreen(),
    );
      }
      );
  }
}

/* 
A ToDo!

1. implement the video player
2. connect categories to their respective catalog types.
*/