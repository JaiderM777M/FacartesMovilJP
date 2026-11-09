import 'package:flutter/material.dart';
import '../core.dart';

void openDetail(BuildContext c, Artwork a) =>
    Navigator.push(c, MaterialPageRoute(builder: (_) => DetailScreen(a)));

class DetailScreen extends StatefulWidget {
  final Artwork a;
  const DetailScreen(this.a, {super.key});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool liked = false, saved = false;
  @override
  Widget build(BuildContext context) {
    final a = widget.a;
    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        Stack(children: [
          SizedBox(
            height: 320, width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: ArtThumb(a, radius: 0),
            ),
          ),
          Positioned(
            left: 12, top: MediaQuery.of(context).padding.top + 8,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: kInk)),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const CircleAvatar(radius: 20, backgroundColor: Color(0xFFE3C9B8), child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(a.artist, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(color: kPrimary.withOpacity(.12), borderRadius: BorderRadius.circular(20)),
                    child: Text(a.dept, style: const TextStyle(color: kPrimary, fontSize: 11.5, fontWeight: FontWeight.w600)),
                  ),
                ]),
              ),
              IconButton(
                onPressed: () => setState(() { liked = !liked; a.likes += liked ? 1 : -1; }),
                icon: Icon(liked ? Icons.favorite : Icons.favorite_border, color: kPrimary),
              ),
              Text('${a.likes}', style: const TextStyle(fontWeight: FontWeight.w700)),
              IconButton(
                onPressed: () => setState(() => saved = !saved),
                icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border, color: kInk),
              ),
            ]),
            const SizedBox(height: 18),
            Text(a.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(a.desc, style: const TextStyle(height: 1.5, color: Color(0xFF4A4541))),
            const SizedBox(height: 16),
            Wrap(spacing: 8, runSpacing: 8, children: [for (final e in a.tags.asMap().entries) TagChip(e.value, e.key)]),
            const SizedBox(height: 20),
            Card16(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Detalles', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 12),
                _row(Icons.calendar_today_outlined, 'Año', a.year),
                _row(Icons.brush_outlined, 'Técnica', a.technique),
                _row(Icons.straighten, 'Dimensiones', a.size),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _row(IconData i, String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(children: [
          Icon(i, size: 18, color: kPrimary),
          const SizedBox(width: 10),
          Text('$k: ', style: const TextStyle(color: kMuted)),
          Expanded(child: Text(v, style: const TextStyle(fontWeight: FontWeight.w600))),
        ]),
      );
}
