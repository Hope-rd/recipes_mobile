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
              padding: const EdgeInsets.all(12.0),
              child: Center(child: Text('Choose Categories', style: Theme.of(context).textTheme.bodySmall,)),
            ),
            ListTile(
              leading: const Icon(Icons.flash_on_outlined),
              title: Text('FastFood', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.whatshot_outlined),
              title: Text('Trending', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pin_drop_outlined),
              title: Text('Local Recipes', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.psychology_outlined),
              title: Text('Smart Suggestion (Ai)', style: Theme.of(context).textTheme.bodyLarge),
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
                  label: Text('You'),
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
                  duration: const Duration(milliseconds: 280),
                  height: isVisible ? bottomNavHeight : 0,
                  curve: Curves.easeOut,
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
                    icon: Icon(Icons.fastfood_outlined),
                    label: 'Categories',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outlined),
                    selectedIcon: Icon(Icons.person),
                    label: 'You',
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
  // Prevent adding the listener multiple times
  if (controller.hasListeners) return;

  double lastOffset = 0.0;
  const double threshold = 25.0;   // ← Tune this (20-40 works well)

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