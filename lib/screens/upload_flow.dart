import 'dart:async';
import 'package:flutter/material.dart';
import '../core.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Widget opt(IconData i, String t, VoidCallback f) => GestureDetector(
          onTap: f,
          child: Card16(
            padding: const EdgeInsets.symmetric(vertical: 36),
            child: Column(children: [
              CircleAvatar(radius: 30, backgroundColor: kPrimary.withOpacity(.12), child: Icon(i, size: 30, color: kPrimary)),
              const SizedBox(height: 12),
              Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            ]),
          ),
        );
    void analyze() => Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalyzingScreen()));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => tabIndex.value = 0),
        title: const Text('Subir obra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          opt(Icons.photo_camera_outlined, 'Tomar foto', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CameraScreen()))),
          const SizedBox(height: 16),
          opt(Icons.image_outlined, 'Elegir de la galería', analyze),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(Icons.auto_awesome, size: 16, color: kPrimary),
            SizedBox(width: 6),
            Flexible(
              child: Text('La IA analizará tu obra automáticamente para sugerirte etiquetas y descripción',
                  textAlign: TextAlign.center, style: TextStyle(color: kMuted, fontSize: 13)),
            ),
          ]),
        ]),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool video = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Positioned.fill(child: Container(color: const Color(0xFF1C1917))),
          Center(
            child: Container(
              width: 300, height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF5A3A2A), width: 10),
                gradient: const LinearGradient(colors: [Color(0xFFE9A36B), Color(0xFF7A3B2E)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: const Icon(Icons.landscape, size: 90, color: Colors.white38),
            ),
          ),
          Center(
            child: Container(
              width: 330, height: 410,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white70, width: 2)),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                IconButton(onPressed: () => soon(context), icon: const Icon(Icons.flash_off, color: Colors.white)),
              ]),
            ),
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
              color: Colors.black54,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (final e in ['Foto', 'Video'].asMap().entries)
                    GestureDetector(
                      onTap: () => setState(() => video = e.key == 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(e.value,
                            style: TextStyle(fontWeight: FontWeight.w700, color: (video ? 1 : 0) == e.key ? Colors.white : Colors.white54)),
                      ),
                    ),
                ]),
                const SizedBox(height: 18),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.photo_library_outlined, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnalyzingScreen())),
                    child: Container(
                      width: 76, height: 76,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4)),
                      padding: const EdgeInsets.all(5),
                      child: Container(decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimary)),
                    ),
                  ),
                  IconButton(onPressed: () => soon(context), icon: const Icon(Icons.flip_camera_ios_outlined, color: Colors.white, size: 30)),
                ]),
              ]),
            ),
          ),
        ]),
      );
}

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});
  // TODO IA: reemplazar por el resultado real del modelo de visión.
  static const tags = ['Pintura', 'Óleo', 'Paisaje', 'Realismo', 'Montaña', 'Arquitectura'];
  static const aiDesc =
      'Paisaje montañoso al atardecer con tonos cálidos y pinceladas realistas. Se aprecian construcciones en primer plano que dialogan con el entorno natural.';
  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen> {
  List<String> get tags => AnalyzingScreen.tags;
  String get aiDesc => AnalyzingScreen.aiDesc;
  int shown = 0;
  Timer? t;
  double get progress => shown / (tags.length + 1);

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(milliseconds: 600), (x) {
      if (shown > tags.length) { x.cancel(); return; }
      setState(() => shown++);
    });
  }

  @override
  void dispose() { t?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final done = shown > tags.length;
    final cover = artworks.value.first;
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: const Text('Analizando obra')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        SizedBox(height: 190, child: ArtThumb(cover)),
        const SizedBox(height: 16),
        Card16(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.auto_awesome, color: kPrimary),
              const SizedBox(width: 8),
              Text(done ? 'Análisis completo' : 'Analizando con IA...', style: const TextStyle(fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(value: done ? 1 : progress, minHeight: 6, color: kPrimary, backgroundColor: kPrimary.withOpacity(.12)),
            ),
          ]),
        ),
        const SizedBox(height: 20),
        const Text('Etiquetas sugeridas', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (var k = 0; k < tags.length; k++)
            AnimatedOpacity(opacity: k < shown ? 1 : 0, duration: const Duration(milliseconds: 400), child: TagChip(tags[k], k)),
        ]),
        const SizedBox(height: 20),
        AnimatedOpacity(
          opacity: done ? 1 : .35,
          duration: const Duration(milliseconds: 400),
          child: Card16(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Descripción generada por IA', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(done ? aiDesc : '...', style: const TextStyle(height: 1.45)),
              const SizedBox(height: 10),
              const AiBadge(),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: done ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishScreen(AnalyzingScreen.aiDesc))) : null,
          child: const Text('Continuar'),
        ),
      ]),
    );
  }
}

class PublishScreen extends StatefulWidget {
  final String desc;
  const PublishScreen(this.desc, {super.key});
  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final title = TextEditingController(), tech = TextEditingController(), dims = TextEditingController(), year = TextEditingController();
  late final desc = TextEditingController(text: widget.desc);
  String cat = 'Pintura';
  String? err;

  Widget label(String t, {bool ai = false}) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Row(children: [
          Text(t, style: const TextStyle(fontWeight: FontWeight.w700)),
          const Spacer(),
          if (ai) const AiBadge(text: 'IA'),
        ]),
      );

  void publish() {
    if (title.text.trim().isEmpty) {
      setState(() => err = 'Escribe un título para tu obra');
      return;
    }
    final base = artworks.value.first;
    artworks.value = [
      Artwork(
        title: title.text.trim(), artist: 'Jaider Paredes', category: cat,
        technique: tech.text.isEmpty ? '—' : tech.text, year: year.text.isEmpty ? '—' : year.text,
        size: dims.text.isEmpty ? '—' : dims.text, desc: desc.text,
        tags: AnalyzingScreen.tags.take(5).toList(), colors: base.colors, icon: Icons.landscape, mine: true,
      ),
      ...artworks.value,
    ];
    publishedCount++;
    final m = ScaffoldMessenger.of(context);
    Navigator.of(context).popUntil((r) => r.isFirst);
    tabIndex.value = 0;
    m.showSnackBar(const SnackBar(content: Text('¡Obra publicada!')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Confirmar y publicar')),
        body: ListView(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), children: [
          SizedBox(height: 120, child: ArtThumb(artworks.value.first)),
          label('Título'),
          TextField(controller: title, decoration: InputDecoration(hintText: 'Escribe un título para tu obra', errorText: err)),
          label('Descripción', ai: true),
          TextField(controller: desc, maxLines: 4),
          label('Categoría', ai: true),
          DropdownButtonFormField<String>(
            value: cat,
            decoration: const InputDecoration(),
            items: ['Pintura', 'Escultura', 'Arte digital', 'Dibujo', 'Fotografía']
                .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => cat = v!),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 8),
          const Text('Detalles de la obra (ingresa tú)', style: TextStyle(fontWeight: FontWeight.w800, color: kPrimary)),
          label('Técnica'),
          TextField(controller: tech, decoration: const InputDecoration(hintText: 'Ej: Óleo sobre lienzo')),
          label('Dimensiones'),
          TextField(controller: dims, decoration: const InputDecoration(hintText: 'Ej: 80 x 60 cm')),
          label('Año de creación'),
          TextField(controller: year, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'Ej: 2025')),
          const SizedBox(height: 24),
          FilledButton(onPressed: publish, child: const Text('Publicar')),
        ]),
      );
}
