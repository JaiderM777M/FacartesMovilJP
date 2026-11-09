import 'package:flutter/material.dart';
import '../core.dart';
import 'detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int tab = 0;
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<List<Artwork>>(
        valueListenable: artworks,
        builder: (context, list, _) {
          final mine = list.where((a) => a.mine).toList();
          final shown = tab == 0 ? mine : list.where((a) => !a.mine).toList();
          final likes = 248 + publishedCount * 5;
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Column(children: [
                Align(alignment: Alignment.centerRight, child: IconButton(onPressed: () => soon(context), icon: const Icon(Icons.settings_outlined))),
                Stack(children: [
                  const CircleAvatar(radius: 52, backgroundColor: Color(0xFFE3C9B8), child: Icon(Icons.person, size: 56, color: Colors.white)),
                  Positioned(
                    right: 0, bottom: 0,
                    child: CircleAvatar(radius: 16, backgroundColor: kPrimary, child: const Icon(Icons.photo_camera, size: 16, color: Colors.white)),
                  ),
                ]),
                const SizedBox(height: 12),
                const Text('Jaider Paredes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const Text('Artes Visuales', style: TextStyle(color: kMuted)),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _stat('${12 + publishedCount}', 'Obras subidas'),
                    const VerticalDivider(width: 40, thickness: 1),
                    _stat('$likes', 'Me gusta recibidos'),
                  ]),
                ),
                const SizedBox(height: 16),
                Row(children: [
                  for (final e in ['Mis obras', 'Guardadas'].asMap().entries)
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => tab = e.key),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: tab == e.key ? kPrimary : Colors.black12, width: 2.5))),
                          child: Text(e.value, textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w700, color: tab == e.key ? kPrimary : kMuted)),
                        ),
                      ),
                    ),
                ]),
                const SizedBox(height: 12),
              ]),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemCount: shown.length,
                itemBuilder: (_, k) => GestureDetector(onTap: () => openDetail(context, shown[k]), child: ArtThumb(shown[k], radius: 12)),
              ),
            ),
          ]);
        },
      );

  Widget _stat(String n, String l) => Column(children: [
        Text(n, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        Text(l, style: const TextStyle(color: kMuted, fontSize: 12.5)),
      ]);
}
