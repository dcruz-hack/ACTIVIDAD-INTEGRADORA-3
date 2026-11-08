import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductsApiScreen extends StatefulWidget {
  const ProductsApiScreen({super.key});

  @override
  State<ProductsApiScreen> createState() => _ProductsApiScreenState();
}

class _ProductsApiScreenState extends State<ProductsApiScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de productos'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Opciones de pruebas',
            onSelected: (value) {
              if (value == 'error') {
                context.read<ProductProvider>().loadProducts(simulateError: true);
              } else {
                context.read<ProductProvider>().loadProducts();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'refresh', child: Text('Consultar API')),
              PopupMenuItem(value: 'error', child: Text('Probar estado de error (QA)')),
            ],
          ),
        ],
      ),
      body: switch (provider.status) {
        ProductStatus.loading => const _LoadingView(),
        ProductStatus.error => _ErrorView(
            message: provider.errorMessage ?? 'No fue posible cargar los productos.',
            onRetry: () => context.read<ProductProvider>().loadProducts(),
          ),
        ProductStatus.success => RefreshIndicator(
            onRefresh: () => context.read<ProductProvider>().loadProducts(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.cloud_done_outlined, size: 30),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Conexión exitosa',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            Text('${provider.products.length} productos recibidos desde DummyJSON'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ...provider.products.map((p) => ProductCard(product: p)),
                const SizedBox(height: 8),
                const Center(
                  child: Text('Desliza hacia abajo para actualizar',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ],
            ),
          ),
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 18),
        Text('Conectando con el servicio de productos...'),
        SizedBox(height: 6),
        Text('Por favor, espera.', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off_rounded,
              size: 64, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Text('No se pudo conectar',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    ),
  );
}
