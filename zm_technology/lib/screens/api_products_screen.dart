import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';
class ApiProductsScreen extends StatefulWidget {const ApiProductsScreen({super.key});@override State<ApiProductsScreen> createState()=>_ApiProductsScreenState();}
class _ApiProductsScreenState extends State<ApiProductsScreen>{
 @override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)context.read<ProductProvider>().loadProducts();});}
 @override Widget build(BuildContext context){
  final p=context.watch<ProductProvider>();
  return Column(children:[
   Container(margin:const EdgeInsets.all(12),padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(12)),
    child:const Text('Datos externos de DummyJSON para demostrar el consumo REST. No representan inventario ni precios confirmados de ZM TECHNOLOGY.',style:TextStyle(fontSize:11))),
   Expanded(child:switch(p.status){
    ProductStatus.loading=>const Center(child:Column(mainAxisSize:MainAxisSize.min,children:[CircularProgressIndicator(),SizedBox(height:12),Text('Consultando catálogo externo...')])),
    ProductStatus.error=>Center(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[
     const Icon(Icons.cloud_off,size:56,color:Colors.redAccent),const Text('No se pudo conectar',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
     Text(p.errorMessage??'Error de conexión',textAlign:TextAlign.center),const SizedBox(height:12),
     FilledButton.icon(onPressed:()=>context.read<ProductProvider>().loadProducts(),icon:const Icon(Icons.refresh),label:const Text('Reintentar')),
     TextButton(onPressed:()=>context.read<ProductProvider>().loadProducts(simulateError:true),child:const Text('Probar error QA')),
    ]))),
    ProductStatus.success=>RefreshIndicator(onRefresh:()=>context.read<ProductProvider>().loadProducts(),child:ListView(physics:const AlwaysScrollableScrollPhysics(),padding:const EdgeInsets.all(14),children:[
     Row(children:[const Icon(Icons.cloud_done,color:Colors.green),const SizedBox(width:8),Expanded(child:Text('${p.products.length} productos recibidos desde API',style:const TextStyle(fontWeight:FontWeight.bold))),IconButton(onPressed:()=>context.read<ProductProvider>().loadProducts(),icon:const Icon(Icons.refresh))]),
     ...p.products.map(_apiCard),const Center(child:Text('Desliza hacia abajo para actualizar',style:TextStyle(fontSize:11,color:Colors.grey)))
    ]))
   })
  ]);
 }
 Widget _apiCard(Product p)=>Card(margin:const EdgeInsets.only(bottom:12),clipBehavior:Clip.antiAlias,child:Row(children:[
  SizedBox(width:100,height:110,child:Image.network(p.thumbnail,fit:BoxFit.cover,errorBuilder:(_,__,___)=>const Icon(Icons.laptop,size:40))),
  Expanded(child:Padding(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
   Text(p.title,style:const TextStyle(fontWeight:FontWeight.bold),maxLines:2,overflow:TextOverflow.ellipsis),
   Text(p.description,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:11)),
   Text('\$${p.price.toStringAsFixed(2)}',style:TextStyle(fontSize:17,fontWeight:FontWeight.w900,color:Theme.of(context).colorScheme.primary)),
   const Text('Dato externo de demostración · DummyJSON',style:TextStyle(fontSize:9,color:Colors.grey))
  ])))
 ]));
}
