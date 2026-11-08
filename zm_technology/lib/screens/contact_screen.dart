import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import '../main.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Contacto', style: TextStyle(color: zmNavy, fontSize: 23, fontWeight: FontWeight.w900)),
    const SizedBox(height: 5),
    const Text('Estamos para ayudarte con tu próxima compra.', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
    const SizedBox(height: 16),
    _Tile(icon: Icons.location_on_outlined, title: 'Visítanos',
      detail: 'Av. 25 de Mayo y Juan Garzón, Cotocollao, Quito', onTap: ContactService.openMaps),
    const SizedBox(height: 9),
    _Tile(icon: Icons.chat_outlined, title: 'WhatsApp', detail: '+593 96 857 1192',
      onTap: () => ContactService.openWhatsApp()),
    const SizedBox(height: 9),
    _Tile(icon: Icons.language, title: 'Página web', detail: 'zmtechnology.store',
      onTap: ContactService.openWebsite),
    const SizedBox(height: 20),
    SizedBox(width: double.infinity, child: FilledButton.icon(
      onPressed: () => ContactService.openWhatsApp(), icon: const Icon(Icons.chat), label: const Text('ESCRÍBENOS'),
      style: FilledButton.styleFrom(backgroundColor: zmRed, foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))))),
  ]);
}
class _Tile extends StatelessWidget {
  final IconData icon; final String title, detail; final VoidCallback onTap;
  const _Tile({required this.icon, required this.title, required this.detail, required this.onTap});
  @override Widget build(BuildContext context) => Card(child: ListTile(onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    leading: CircleAvatar(backgroundColor: const Color(0xFFE5F4FC), child: Icon(icon, color: zmBlue)),
    title: Text(title, style: const TextStyle(color: zmNavy, fontWeight: FontWeight.w800)),
    subtitle: Text(detail), trailing: const Icon(Icons.open_in_new, size: 17, color: Color(0xFF64748B))));
}
