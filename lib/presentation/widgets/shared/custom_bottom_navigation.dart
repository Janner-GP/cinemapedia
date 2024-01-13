import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max_outlined), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categorias'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_outlined), label: 'Favoritos'),
      ],
    );
  }
}