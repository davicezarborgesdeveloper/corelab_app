import 'package:corelab_app_challenge/src/pages/categories/categories_page.dart';
import 'package:corelab_app_challenge/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(
            () {
              _pageIndex = index;
            },
          );
        },
        children: _buildPageViewChildren(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: _buildItems(),
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        currentIndex: _pageIndex,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }

  List<Widget> _buildPageViewChildren() {
    return [
      const HomePage(),
      const CategoriesPage(),
      Container(color: Colors.blue),
      Container(color: Colors.yellow),
      Container(color: Colors.purple),
    ];
  }

  List<BottomNavigationBarItem> _buildItems() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.red,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.grid_view_outlined),
        activeIcon: Icon(Icons.grid_view_rounded),
        label: 'Categorias',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined),
        label: 'Anunciar',
        backgroundColor: Colors.green,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline),
        label: 'Favoritos',
        backgroundColor: Colors.yellow,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_outlined),
        label: 'Conta',
        backgroundColor: Colors.yellow,
      ),
    ];
  }
}
