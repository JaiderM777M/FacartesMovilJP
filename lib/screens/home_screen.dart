import 'package:flutter/material.dart';
import '../core.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<List<Artwork>>(
        valueListenable: artworks,
        builder: (context, list, _) {
          final rec = list.take(3).toList();
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                child: Row(children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.palette, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text('FACARTES Móvil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const Spacer(),
                  IconButton(onPressed: () => soon(context), icon: const Icon(Icons.notifications_none, size: 28)),
                ]),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar obras, artistas, categorías...',
                    prefixIcon: Icon(Icons.search, color: kMuted),
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: _Title('Para ti ✨')),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: rec.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, k) => GestureDetector(
                    onTap: () => openDetail(context, rec[k]),
                    child: SizedBox(
                      width: 160,
                      child: Stack(children: [
                        Positioned.fill(child: ArtThumb(rec[k])),
                        const Positioned(left: 8, top: 8, child: AiBadge(text: 'Sugerido por IA')),
                        Positioned(
                          left: 12, right: 12, bottom: 12,
                          child: Text(rec[k].title,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: _Title('Explorar')),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: .78),
                itemCount: list.length,
                itemBuilder: (_, k) => GestureDetector(
                  onTap: () => openDetail(context, list[k]),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: SizedBox.expand(child: ArtThumb(list[k]))),
                    const SizedBox(height: 6),
                    Text(list[k].title, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    Text(list[k].technique, style: const TextStyle(color: kMuted, fontSize: 12.5)),
                  ]),
                ),
              ),
            ),
          ]);
        },
      );
}

class _Title extends StatelessWidget {
  final String t;
  const _Title(this.t);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        child: Text(t, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
      );
}
