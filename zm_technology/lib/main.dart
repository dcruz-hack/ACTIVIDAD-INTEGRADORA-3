import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/products_api_screen.dart';
import 'screens/contact_screen.dart';

const zmNavy = Color(0xFF101B35);
const zmBlue = Color(0xFF168BCB);
const zmRed = Color(0xFFD71920);
const zmCanvas = Color(0xFFF5F7FA);

void main() => runApp(ChangeNotifierProvider(
  create: (_) => ProductProvider(), child: const ZmApp()));

class ZmApp extends StatelessWidget {
  const ZmApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false, title: 'ZM TECHNOLOGY',
    theme: ThemeData(
      useMaterial3: true, scaffoldBackgroundColor: zmCanvas,
      colorScheme: ColorScheme.fromSeed(seedColor: zmBlue, primary: zmBlue, secondary: zmRed),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: zmNavy, elevation: 0),
      cardTheme: CardThemeData(color: Colors.white, elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFE7EAF0)))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: const Color(0xFFF1F5F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white, indicatorColor: Color(0xFFE5F4FC), elevation: 8),
    ),
    home: const MainNavigation());
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override State<MainNavigation> createState() => _MainNavigationState();
}
class _MainNavigationState extends State<MainNavigation> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onCatalog: () => setState(() => index = 1), onApi: () => setState(() => index = 2)),
      const CatalogScreen(), const ProductsApiScreen(), const ContactScreen(),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(104),
        child: SafeArea(bottom: false, child: Column(children: [
          Container(height: 25, width: double.infinity, alignment: Alignment.center,
            decoration: const BoxDecoration(gradient: LinearGradient(
              colors: [Color(0xFF087A3D), Color(0xFFB66B28), Color(0xFFC81728)])),
            child: const Text('¡Tecnología para esta temporada!  •  Ofertas ZM TECHNOLOGY',
              maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700))),
          Expanded(child: Container(color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Container(width: 39, height: 39,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: zmBlue, width: 1.5)),
                child: const Center(child: Text('ZM', style: TextStyle(color: zmBlue, fontWeight: FontWeight.w900, fontSize: 15)))),
              const SizedBox(width: 8),
              const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('ZM', style: TextStyle(color: zmNavy, fontSize: 18, height: .9, fontWeight: FontWeight.w900)),
                  Text('TECHNOLOGY', style: TextStyle(color: zmBlue, fontSize: 8, letterSpacing: 1.1, fontWeight: FontWeight.w800)),
                ])),
              IconButton(onPressed: () => setState(() => index = 3), icon: const Icon(Icons.person_outline, color: zmNavy)),
              IconButton(onPressed: () => setState(() => index = 3), icon: const Icon(Icons.shopping_cart_outlined, color: zmNavy)),
            ]))),
          const Divider(height: 1, color: Color(0xFFE6E9EF)),
        ]))),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Productos'),
          NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: 'Arma tu PC'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Contacto'),
        ]),
    );
  }
}
