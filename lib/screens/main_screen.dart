import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/navigation_provider.dart';
import 'package:recipes/screens/catalog_screen.dart';
import 'package:recipes/screens/profile_screen.dart';
import '../providers/scroll_controller.dart';
import '../providers/visibility_provider.dart';

class Mainscreen extends StatelessWidget{
   Mainscreen({super.key});
   bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 720;
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= 720;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width <= 720;
}

  final List <Widget> screens = [
    const Catalogs(),
    const SizedBox(),
    const ProfileScreen(),
  ];

  void _showCategoriesDialog(BuildContext context){
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context, 
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text('Choose Categories', style: Theme.of(context).textTheme.bodySmall,)),
            ),
            ListTile(
              leading: const Icon(Icons.fastfood_outlined),
              title: const Text('Quick'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility_new_outlined),
              title: const Text('Trending'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: const Text('Nigeria'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.smart_toy_outlined),
              title: const Text('Smart Suggestion (Ai)'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
  }

  @override
  Widget build (BuildContext context){
    final bool desktop = isDesktop(context);
    final provider = Provider.of<NavigationProvider>(context);
    final scrollController = Provider.of<ScrollControllerProvider>(context, listen: false).scrollController;
    final visibilityProvider = Provider.of<NavVisibilityProvider>(context, listen: false);

     _setupScrollListener(scrollController, visibilityProvider);
     const double bottomNavHeight = 80.0;

   return Scaffold(
      // ── Navigation ────────────────────────────────────────
      body: Row(
        children: [
          if (desktop) ...[
            NavigationRail(
              selectedIndex: provider.currentIdex, 
              onDestinationSelected: (index){
                final provider = context.read<NavigationProvider>();
                if (index == 1){
                  if (provider.currentIdex != 0){
                    provider.changeIdex(0);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showCategoriesDialog(context);
                     });
                  } else {
                    _showCategoriesDialog(context);
                  }
                } else {
                  provider.changeIdex(index);
                }
              },
              labelType: NavigationRailLabelType.all, // or .selected
              selectedIconTheme: Theme.of(context).iconTheme,
              selectedLabelTextStyle: TextStyle(color: Colors.deepPurple[50]),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.restaurant_menu_outlined),
                  selectedIcon: Icon(Icons.restaurant_menu_outlined),
                  label: Text('Categories'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outlined),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 5, width: 3),
          ],

          // Main content
          Expanded(
            child: screens [provider.currentIdex],
          ),
        ],
      ),

      // ── Only show bottom bar on mobile ────────────────────
      bottomNavigationBar: desktop
          ? null
          : ValueListenableBuilder<bool>(
              valueListenable: visibilityProvider.isVisible, 
              builder: (context, isVisible, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  height: isVisible ? bottomNavHeight : 0,
                  curve: Curves.easeInOut,
                  child: isVisible
                  ? NavigationBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
                selectedIndex: provider.currentIdex,
                onDestinationSelected: (index){
                  final provider = context.read<NavigationProvider>();
                  if (index == 1){
                    if (provider.currentIdex != 0){
                      provider.changeIdex(0);
            
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showCategoriesDialog(context);
                       });
                    } else {
                      _showCategoriesDialog(context);
                    }
                  } else {
                    provider.changeIdex(index);
                  }
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.food_bank_outlined),
                    selectedIcon: Icon(Icons.restaurant_menu_outlined),
                    label: 'Categories',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outlined),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              )
              : const SizedBox.shrink(),
                  );
              }
              ),
    );
  }
}

// ==================== SCROLL LISTENER HELPER ====================
  void _setupScrollListener(ScrollController controller, NavVisibilityProvider visibilityProvider) {
    controller.addListener(() {
      if (!controller.hasClients) return;

      final direction = controller.position.userScrollDirection;

      if (direction == ScrollDirection.reverse) {
        visibilityProvider.updateVisibility(false);
      } else if (direction == ScrollDirection.forward) {
        visibilityProvider.updateVisibility(true);
      }
    });
  }