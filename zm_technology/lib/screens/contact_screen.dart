import 'package:flutter/material.dart';
import '../services/contact_service.dart';
class ContactScreen extends StatelessWidget {const ContactScreen({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
 Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:const Color(0xFF101B35),borderRadius:BorderRadius.circular(18)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('ZM TECHNOLOGY',style:TextStyle(color:Colors.white,fontWeight:FontWeight.w900,fontSize:24)),SizedBox(height:8),Text('Tu tienda de tecnología en Quito, Ecuador.',style:TextStyle(color:Colors.white70))])),
 const SizedBox(height:14),
 Card(child:ListTile(leading:const Icon(Icons.location_on,color:Colors.red),title:const Text('Visítanos'),subtitle:const Text('Av. 25 de Mayo y Juan Garzón, Cotocollao, Quito'),onTap:ContactService.openMaps)),
 Card(child:ListTile(leading:const Icon(Icons.phone,color:Colors.green),title:const Text('WhatsApp / Teléfono'),subtitle:const Text('+593 96 857 1192'),onTap:()=>ContactService.openWhatsApp())),
 Card(child:ListTile(leading:const Icon(Icons.language),title:const Text('Sitio web'),subtitle:const Text('zmtechnology.store'),onTap:ContactService.openWebsite)),
 FilledButton.icon(onPressed:()=>ContactService.openWhatsApp(),icon:const Icon(Icons.chat),label:const Text('Escribir por WhatsApp'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFF128C7E))),
 OutlinedButton.icon(onPressed:ContactService.openMaps,icon:const Icon(Icons.directions),label:const Text('Cómo llegar a la tienda'))
]);}
