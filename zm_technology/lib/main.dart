import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/api_products_screen.dart';
import 'screens/contact_screen.dart';
void main()=>runApp(ChangeNotifierProvider(create:(_)=>ProductProvider(),child:const ZmApp()));
class ZmApp extends StatelessWidget {
 const ZmApp({super.key});
 @override Widget build(BuildContext context)=>MaterialApp(
  debugShowCheckedModeBanner:false,title:'ZM TECHNOLOGY',
  theme:ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF2563EB)),
   scaffoldBackgroundColor:const Color(0xFFF4F6FA),
   appBarTheme:const AppBarTheme(backgroundColor:Color(0xFF101B35),foregroundColor:Colors.white),
   cardTheme:CardThemeData(color:Colors.white,elevation:1,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16)))),
  home:const MainNavigation());
}
class MainNavigation extends StatefulWidget {const MainNavigation({super.key}); @override State<MainNavigation> createState()=>_MainNavigationState();}
class _MainNavigationState extends State<MainNavigation>{
 int index=0;
 @override Widget build(BuildContext context){
  final pages=[HomeScreen(onCatalog:()=>setState(()=>index=1),onApi:()=>setState(()=>index=2)),const CatalogScreen(),const ApiProductsScreen(),const ContactScreen()];
  const titles=['ZM TECHNOLOGY','Catálogo','Catálogo API','Contacto'];
  return Scaffold(appBar:AppBar(title:Text(titles[index])),
   body:IndexedStack(index:index,children:pages),
   bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),
    destinations:const [
     NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Inicio'),
     NavigationDestination(icon:Icon(Icons.storefront_outlined),selectedIcon:Icon(Icons.storefront),label:'Catálogo'),
     NavigationDestination(icon:Icon(Icons.cloud_outlined),selectedIcon:Icon(Icons.cloud_done),label:'API REST'),
     NavigationDestination(icon:Icon(Icons.contact_support_outlined),selectedIcon:Icon(Icons.contact_support),label:'Contacto'),
    ]));
 }
}
