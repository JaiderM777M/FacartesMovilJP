import 'package:flutter/material.dart';
import 'core.dart';
import 'screens/shell.dart';

void main() => runApp(const FacartesApp());

class FacartesApp extends StatelessWidget {
  const FacartesApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FACARTES Móvil',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const Shell(),
      );
}
