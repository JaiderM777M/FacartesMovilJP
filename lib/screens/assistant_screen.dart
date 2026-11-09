import 'package:flutter/material.dart';
import '../core.dart';
import 'detail_screen.dart';

class _Msg {
  final bool user;
  final String text;
  final bool art;
  _Msg(this.user, this.text, {this.art = false});
}

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});
  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final ctrl = TextEditingController();
  final scroll = ScrollController();
  final msgs = <_Msg>[
    _Msg(true, 'Muéstrame obras de arquitectura recientes'),
    _Msg(false, 'Encontré estas obras relacionadas con arquitectura:', art: true),
    _Msg(true, '¿Qué técnica es el óleo sobre lienzo?'),
    _Msg(false, 'Es una técnica de pintura con pigmentos mezclados con aceite, aplicada sobre una tela tensada. Permite capas, transparencias y tiempos largos de secado.'),
  ];

  // TODO IA: reemplazar por llamada real al modelo.
  void _reply(String q) {
    final l = q.toLowerCase();
    final m = l.contains('arquitect')
        ? _Msg(false, 'Estas son algunas obras de arquitectura:', art: true)
        : _Msg(false, 'Por ahora soy un prototipo, pero pronto podré responder: "$q".');
    setState(() => msgs.add(m));
    _down();
  }

  void _down() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scroll.hasClients) scroll.animateTo(scroll.position.maxScrollExtent + 200, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      });

  void _send() {
    final t = ctrl.text.trim();
    if (t.isEmpty) return;
    ctrl.clear();
    setState(() => msgs.add(_Msg(true, t)));
    _down();
    Future.delayed(const Duration(milliseconds: 700), () => _reply(t));
  }

  @override
  Widget build(BuildContext context) {
    final arts = artworks.value.where((a) => a.tags.contains('Arquitectura')).followedBy(artworks.value).take(3).toList();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Row(children: const [
          SizedBox(width: 12),
          Text('Asistente FACARTES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          SizedBox(width: 8),
          Icon(Icons.auto_awesome, color: kPrimary, size: 20),
        ]),
      ),
      Expanded(
        child: ListView.builder(
          controller: scroll,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: msgs.length,
          itemBuilder: (_, k) {
            final m = msgs[k];
            final bubble = Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .78),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: m.user ? kPrimary : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: m.user ? null : [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 10, offset: const Offset(0, 3))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.text, style: TextStyle(color: m.user ? Colors.white : kInk, height: 1.35)),
                if (m.art) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 84,
                    child: Row(children: [
                      for (final a in arts)
                        Expanded(
                          child: GestureDetector(
                            onTap: () => openDetail(context, a),
                            child: Padding(padding: const EdgeInsets.only(right: 6), child: ArtThumb(a, radius: 12)),
                          ),
                        ),
                    ]),
                  ),
                ],
              ]),
            );
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Align(alignment: m.user ? Alignment.centerRight : Alignment.centerLeft, child: bubble),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: ctrl,
              onSubmitted: (_) => _send(),
              decoration: const InputDecoration(
                  hintText: 'Pregúntale algo al asistente...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _send,
            style: IconButton.styleFrom(backgroundColor: kPrimary, minimumSize: const Size(52, 52)),
            icon: const Icon(Icons.send_rounded, color: Colors.white),
          ),
        ]),
      ),
    ]);
  }
}
