import 'package:url_launcher/url_launcher.dart';
class ContactService {
 static const whatsapp='593968571192';
 static const website='https://zmtechnology.store/';
 static const maps='https://maps.app.goo.gl/SnEFWBFA6KVfnTTs5?g_st=ac';
 static Future<void> openWhatsApp({String message='Hola ZM TECHNOLOGY, deseo información sobre sus productos.'}) async {
  final u=Uri.parse('https://wa.me/$whatsapp?text=${Uri.encodeComponent(message)}');
  if(!await launchUrl(u,mode:LaunchMode.externalApplication)) throw Exception('No se pudo abrir WhatsApp.');
 }
 static Future<void> openWebsite()=>launchUrl(Uri.parse(website),mode:LaunchMode.externalApplication);
 static Future<void> openMaps()=>launchUrl(Uri.parse(maps),mode:LaunchMode.externalApplication);
}
