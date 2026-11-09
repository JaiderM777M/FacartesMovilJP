import 'package:flutter/material.dart';
import '../core.dart';
import 'assistant_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'upload_flow.dart';

/// Contenedor con la barra de navegación inferior (4 pestañas reales).
class Shell extends StatelessWidget {
  const Shell({super.key});

  static const _pages = [HomeScreen(), AssistantScreen(), UploadScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int>(
        valueListenable: tabIndex,
        builder: (context, i, _) => Scaffold(
          body: SafeArea(child: IndexedStack(index: i, children: _pages)),
          bottomNavigationBar: NavigationBar(
            selectedIndex: i,
            onDestinationSelected: (v) => tabIndex.value = v,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: kPrimary), label: 'Galería'),
              NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble, color: kPrimary), label: 'Asistente'),
              NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle, color: kPrimary), label: 'Subir'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: kPrimary), label: 'Perfil'),
            ],
          ),
        ),
      );
}
