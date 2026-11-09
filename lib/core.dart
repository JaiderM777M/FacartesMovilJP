import 'package:flutter/material.dart';

const kPrimary = Color(0xFFC25B34);
const kBg = Color(0xFFFAF5EC);
const kInk = Color(0xFF2B2B2B);
const kMuted = Color(0xFF8A817A);

ThemeData buildTheme() {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none);
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: kPrimary, primary: kPrimary, surface: kBg),
    scaffoldBackgroundColor: kBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: kBg, elevation: 0, scrolledUnderElevation: 0,
      foregroundColor: kInk, centerTitle: false,
      titleTextStyle: TextStyle(color: kInk, fontSize: 20, fontWeight: FontWeight.w700),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: kPrimary.withOpacity(.14),
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: Colors.white, border: border, enabledBorder: border,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: kPrimary, width: 1.5)),
      hintStyle: const TextStyle(color: kMuted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kPrimary, minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class Artwork {
  final String title, artist, dept, technique, year, size, desc, category;
  final List<String> tags;
  final List<Color> colors;
  final IconData icon;
  final bool mine;
  int likes;
  Artwork({
    required this.title, required this.artist, this.dept = 'Artes Visuales',
    required this.technique, required this.year, required this.size,
    required this.desc, required this.category, required this.tags,
    required this.colors, required this.icon, this.mine = false, this.likes = 0,
  });
}

const _lorem =
    'Una composición que explora la luz del atardecer sobre el paisaje andino, con pinceladas amplias y una paleta cálida que dialoga con la arquitectura del lugar.';

final artworks = ValueNotifier<List<Artwork>>([
  Artwork(title: 'Atardecer en Pasto', artist: 'Daniel Rojas', technique: 'Óleo sobre lienzo', year: '2023', size: '80 x 60 cm', desc: _lorem, category: 'Pintura', tags: ['Pintura', 'Óleo', 'Paisaje', 'Realismo', 'Arquitectura'], colors: [const Color(0xFFE9A36B), const Color(0xFF7A3B2E)], icon: Icons.landscape, likes: 128),
  Artwork(title: 'Raíces', artist: 'Laura Mora', technique: 'Cerámica', year: '2024', size: '40 x 25 cm', desc: _lorem, category: 'Escultura', tags: ['Escultura', 'Cerámica'], colors: [const Color(0xFFB9856A), const Color(0xFF5B3A2E)], icon: Icons.account_balance, likes: 74),
  Artwork(title: 'Neón Andino', artist: 'Dani Cuaran', technique: 'Arte digital', year: '2025', size: '3000 x 2000 px', desc: _lorem, category: 'Arte digital', tags: ['Digital', 'Color'], colors: [const Color(0xFF6C5CE7), const Color(0xFFE17055)], icon: Icons.blur_on, likes: 96),
  Artwork(title: 'Niebla Matutina', artist: 'Camila Erazo', technique: 'Acuarela', year: '2022', size: '50 x 35 cm', desc: _lorem, category: 'Pintura', tags: ['Acuarela', 'Paisaje'], colors: [const Color(0xFF9DB8B0), const Color(0xFF3F5C5A)], icon: Icons.cloud, likes: 51),
  Artwork(title: 'Autorretrato I', artist: 'Jaider Paredes', technique: 'Carboncillo', year: '2024', size: '45 x 60 cm', desc: _lorem, category: 'Dibujo', tags: ['Retrato', 'Dibujo'], colors: [const Color(0xFF8D8D8D), const Color(0xFF2D2D2D)], icon: Icons.face, mine: true, likes: 33),
  Artwork(title: 'Fachada Colonial', artist: 'Jaider Paredes', technique: 'Óleo sobre lienzo', year: '2024', size: '70 x 50 cm', desc: _lorem, category: 'Pintura', tags: ['Arquitectura', 'Óleo'], colors: [const Color(0xFFD9B26F), const Color(0xFF8A4B2A)], icon: Icons.home_work, mine: true, likes: 61),
  Artwork(title: 'Volcán Galeras', artist: 'Jaider Paredes', technique: 'Acrílico', year: '2023', size: '90 x 60 cm', desc: _lorem, category: 'Pintura', tags: ['Paisaje', 'Acrílico'], colors: [const Color(0xFF6E8CA0), const Color(0xFFB5543A)], icon: Icons.terrain, mine: true, likes: 48),
  Artwork(title: 'Pixel Mercado', artist: 'Jaider Paredes', technique: 'Arte digital', year: '2025', size: '2000 x 2000 px', desc: _lorem, category: 'Arte digital', tags: ['Digital'], colors: [const Color(0xFF00B894), const Color(0xFFFDCB6E)], icon: Icons.grid_view, mine: true, likes: 29),
  Artwork(title: 'Manos', artist: 'Jaider Paredes', technique: 'Yeso', year: '2022', size: '30 x 20 cm', desc: _lorem, category: 'Escultura', tags: ['Escultura'], colors: [const Color(0xFFE5DCCB), const Color(0xFF9C8E7A)], icon: Icons.back_hand, mine: true, likes: 17),
  Artwork(title: 'Bodegón Rojo', artist: 'Jaider Paredes', technique: 'Óleo sobre lienzo', year: '2023', size: '60 x 40 cm', desc: _lorem, category: 'Pintura', tags: ['Óleo', 'Bodegón'], colors: [const Color(0xFFC25B34), const Color(0xFF4A1F14)], icon: Icons.local_florist, mine: true, likes: 60),
]);

int publishedCount = 0;

class ArtThumb extends StatelessWidget {
  final Artwork art;
  final double radius;
  const ArtThumb(this.art, {super.key, this.radius = 16});
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(colors: art.colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(child: Icon(art.icon, color: Colors.white.withOpacity(.55), size: 44)),
      );
}

class AiBadge extends StatelessWidget {
  final String text;
  const AiBadge({super.key, this.text = 'Generado por IA'});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: kPrimary.withOpacity(.12), borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.auto_awesome, size: 12, color: kPrimary),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 10.5, color: kPrimary, fontWeight: FontWeight.w600)),
        ]),
      );
}

class TagChip extends StatelessWidget {
  final String text;
  final int i;
  const TagChip(this.text, this.i, {super.key});
  static const _c = [Color(0xFFF3D9CC), Color(0xFFDDE7D5), Color(0xFFF1E3B8), Color(0xFFD6E1EA), Color(0xFFE6D5E8)];
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(color: _c[i % _c.length], borderRadius: BorderRadius.circular(20)),
        child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kInk)),
      );
}

class Card16 extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const Card16({super.key, required this.child, this.padding = const EdgeInsets.all(16)});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12, offset: const Offset(0, 4)),
        ]),
        child: child,
      );
}

/// Pestaña activa de la navegación inferior (0 Galería, 1 Asistente, 2 Subir, 3 Perfil).
final tabIndex = ValueNotifier<int>(0);

/// Acción aún no implementada en el prototipo.
void soon(BuildContext c) => ScaffoldMessenger.of(c)
    .showSnackBar(const SnackBar(content: Text('Próximamente')));
