import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onCatalog, onApi;
  const HomeScreen({super.key, required this.onCatalog, required this.onApi});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(16,14,16,24), children: [
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(11),
      border: Border.all(color: const Color(0xFFE7EAF0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('BIENVENIDO A ZM TECHNOLOGY', style: TextStyle(color: zmBlue, fontSize: 10, letterSpacing: 1.1, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('La tecnología que buscas, al mejor nivel.',
          style: TextStyle(color: zmNavy, fontSize: 23, height: 1.15, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('Computadoras, PC Gamer y componentes para trabajar, estudiar y jugar.',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.45)),
        const SizedBox(height: 17),
        SizedBox(width: double.infinity, child: FilledButton(
          onPressed: onCatalog,
          style: FilledButton.styleFrom(backgroundColor: zmRed, foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(vertical: 13)),
          child: const Text('VER PRODUCTOS', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: .4)))),
      ])),
    const SizedBox(height: 22),
    const _SectionHeading(title: 'Compra por categoría', subtitle: 'Encuentra lo que necesitas'),
    const SizedBox(height: 12),
    GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.55,
      children: const [_CategoryTile(Icons.sports_esports,'PC Gamer'), _CategoryTile(Icons.laptop_mac,'Laptops'),
        _CategoryTile(Icons.memory,'Componentes'), _CategoryTile(Icons.monitor,'Monitores')]),
    const SizedBox(height: 20),
    Card(child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      leading: const CircleAvatar(backgroundColor: Color(0xFFE5F4FC), child: Icon(Icons.tune, color: zmBlue)),
      title: const Text('Arma tu PC', style: TextStyle(fontWeight: FontWeight.w800, color: zmNavy)),
      subtitle: const Text('Consulta componentes y solicita una cotización personalizada.'),
      trailing: const Icon(Icons.chevron_right), onTap: onApi)),
    const SizedBox(height: 18),
    const _SectionHeading(title: 'Atención y soporte', subtitle: 'Estamos listos para ayudarte'),
    const SizedBox(height: 10),
    Card(child: ListTile(leading: const Icon(Icons.location_on_outlined, color: zmBlue),
      title: const Text('Visita nuestra tienda', style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: const Text('Cotocollao · Quito, Ecuador'), trailing: const Icon(Icons.open_in_new, size: 18),
      onTap: ContactService.openMaps)),
    const SizedBox(height: 8),
    SizedBox(width: double.infinity, child: OutlinedButton.icon(
      onPressed: () => ContactService.openWhatsApp(), icon: const Icon(Icons.chat, color: Color(0xFF128C7E)),
      label: const Text('Escríbenos por WhatsApp'),
      style: OutlinedButton.styleFrom(foregroundColor: zmNavy, side: const BorderSide(color: Color(0xFFD9E1EA)),
        padding: const EdgeInsets.symmetric(vertical: 13)))),
  ]);
}

class _SectionHeading extends StatelessWidget {
  final String title, subtitle;
  const _SectionHeading({required this.title, required this.subtitle});
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: zmNavy, fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
  ]);
}
class _CategoryTile extends StatelessWidget {
  final IconData icon; final String title;
  const _CategoryTile(this.icon,this.title);
  @override Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE7EAF0))),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: zmBlue, size: 26), const SizedBox(width: 9),
      Flexible(child: Text(title, style: const TextStyle(color: zmNavy, fontWeight: FontWeight.w800, fontSize: 12))),
    ]));
}
