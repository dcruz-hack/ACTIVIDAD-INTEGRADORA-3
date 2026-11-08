import 'package:flutter/material.dart';
import '../services/contact_service.dart';
class HomeScreen extends StatelessWidget {
 final VoidCallback onCatalog,onApi;
 const HomeScreen({super.key,required this.onCatalog,required this.onApi});
 @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
  Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(
   gradient:const LinearGradient(colors:[Color(0xFF101B35),Color(0xFF174A9C)]),borderRadius:BorderRadius.circular(22)),
   child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    const Text('ZM TECHNOLOGY',style:TextStyle(color:Colors.white,fontSize:25,fontWeight:FontWeight.w900,letterSpacing:1)),
    const SizedBox(height:8),const Text('Tecnología para trabajar, estudiar y jugar.',style:TextStyle(color:Colors.white,fontSize:15)),
    const SizedBox(height:18),FilledButton(onPressed:onCatalog,style:FilledButton.styleFrom(backgroundColor:Colors.white,foregroundColor:const Color(0xFF14264A)),child:const Text('Explorar catálogo')),
   ])),
  const SizedBox(height:22),Text('Encuentra lo que necesitas',style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
  const SizedBox(height:12),GridView.count(crossAxisCount:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),mainAxisSpacing:10,crossAxisSpacing:10,childAspectRatio:1.5,
   children:const [_Tile(Icons.sports_esports,'PC Gamer'),_Tile(Icons.laptop,'Laptops'),_Tile(Icons.memory,'Componentes'),_Tile(Icons.devices,'Accesorios')]),
  const SizedBox(height:16),Card(child:ListTile(leading:const Icon(Icons.cloud_download_outlined),title:const Text('Catálogo tecnológico externo'),subtitle:const Text('Datos de laptops desde una API REST pública.'),trailing:const Icon(Icons.arrow_forward_ios,size:15),onTap:onApi)),
  Card(child:ListTile(leading:const Icon(Icons.location_on,color:Colors.red),title:const Text('Atención en Quito, Ecuador'),subtitle:const Text('Av. 25 de Mayo y Juan Garzón · Cotocollao'),onTap:ContactService.openMaps)),
  FilledButton.icon(onPressed:()=>ContactService.openWhatsApp(),icon:const Icon(Icons.chat),label:const Text('Contactar por WhatsApp'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFF128C7E))),
 ]);
}
class _Tile extends StatelessWidget {final IconData icon;final String title;const _Tile(this.icon,this.title);@override Widget build(BuildContext context)=>Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(16)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,size:30,color:Theme.of(context).colorScheme.primary),const SizedBox(height:8),Text(title,style:const TextStyle(fontWeight:FontWeight.bold))]));}
