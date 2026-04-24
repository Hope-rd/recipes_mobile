import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_Provider.dart';

class Settings extends StatelessWidget{
  const Settings ({super.key});

  @override
  Widget build (BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Text('Appearance', style: TextStyle(fontSize: 18),),
                trailing: Switch(
                  value: isLight, 
                  onChanged: (_){
                    themeProvider.toggleTheme(); 
                    },
                    activeThumbColor: Colors.deepPurple[100],
                  )
                ),
                const Divider(height: 20, thickness: 0.0, indent: 15, endIndent: 15,),
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
                ),
                ListTile(
                leading: const Icon(Icons.report_problem,),
                onTap: () {
                  // code here
                },
                title: const Text('Report a Problem'),
                ),
            ],
          ),
        )
        ),
    );
  }
}