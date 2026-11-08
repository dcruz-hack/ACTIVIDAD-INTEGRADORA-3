import 'package:flutter/material.dart';
import '../models/store_product.dart';
import '../services/contact_service.dart';
class CatalogScreen extends StatefulWidget {const CatalogScreen({super.key});@override State<CatalogScreen> createState()=>_CatalogScreenState();}
class _CatalogScreenState extends State<CatalogScreen>{
 String category='Todos',search='';
 @override Widget build(BuildContext context){
  final items=storeProducts.where((p)=>(category=='Todos'||p.category==category)&&('${p.name} ${p.category} ${p.specs}'.toLowerCase().contains(search.toLowerCase()))).toList();
  return Column(children:[
   Padding(padding:const EdgeInsets.fromLTRB(15,12,15,8),child:TextField(onChanged:(v)=>setState(()=>search=v),decoration:InputDecoration(hintText:'Buscar productos o componentes',prefixIcon:const Icon(Icons.search),filled:true,fillColor:Colors.white,border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none)))),
   SizedBox(height:48,child:ListView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.symmetric(horizontal:12),children:storeCategories.map((c)=>Padding(padding:const EdgeInsets.only(right:6),child:ChoiceChip(label:Text(c),selected:category==c,onSelected:(_)=>setState(()=>category=c)))).toList())),
   Expanded(child:ListView(padding:const EdgeInsets.all(14),children:[
    const Text('Catálogo ZM TECHNOLOGY · Consulta precio y disponibilidad',style:TextStyle(fontSize:12,color:Colors.black54)),
    const SizedBox(height:10),
    ...items.map((p)=>Card(margin:const EdgeInsets.only(bottom:12),child:Padding(padding:const EdgeInsets.all(14),child:Row(children:[
     Container(width:58,height:58,decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(14)),child:Icon(_icon(p.category),size:30,color:Theme.of(context).colorScheme.primary)),
     const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(p.category.toUpperCase(),style:TextStyle(fontSize:10,color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.bold)),
      Text(p.name,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:15)),
      Text(p.description,style:const TextStyle(fontSize:11),maxLines:2,overflow:TextOverflow.ellipsis),
      Text(p.specs,style:const TextStyle(fontSize:10,color:Colors.black54),maxLines:2,overflow:TextOverflow.ellipsis),
      const SizedBox(height:7),OutlinedButton.icon(onPressed:()=>ContactService.openWhatsApp(message:'Hola ZM TECHNOLOGY, deseo cotizar ${p.name}. ¿Me comparten precio y disponibilidad?'),icon:const Icon(Icons.chat,size:15),label:const Text('Cotizar por WhatsApp'),style:OutlinedButton.styleFrom(foregroundColor:const Color(0xFF128C7E),visualDensity:VisualDensity.compact)),
     ]))
    ])))),
    if(items.isEmpty) const Center(child:Text('No se encontraron productos.')),
   ]))
  ]);
 }
 IconData _icon(String c)=>switch(c){'PC Gamer'=>Icons.sports_esports,'Computadoras'=>Icons.desktop_windows,'Laptops'=>Icons.laptop,'Componentes'=>Icons.memory,'Almacenamiento'=>Icons.storage,_=>Icons.monitor};
}
