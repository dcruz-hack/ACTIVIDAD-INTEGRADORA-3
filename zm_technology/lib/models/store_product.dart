class StoreProduct {
  final String name, category, description, specs;
  const StoreProduct(this.name,this.category,this.description,this.specs);
}
const storeProducts = <StoreProduct>[
 StoreProduct('PC Gamer personalizada','PC Gamer','Equipos armados según tu presupuesto y los juegos que deseas ejecutar.','Intel Core y AMD Ryzen · NVIDIA GeForce y AMD Radeon'),
 StoreProduct('Computadora de escritorio','Computadoras','Soluciones para oficina, estudio, hogar y trabajo profesional.','SSD · Memoria RAM ampliable · Configuración a medida'),
 StoreProduct('Laptop','Laptops','Opciones para clases, productividad, diseño y entretenimiento.','Consulta modelos, procesador, memoria y almacenamiento'),
 StoreProduct('Tarjetas gráficas','Componentes','Actualiza el rendimiento gráfico de tu computadora.','NVIDIA GeForce RTX · AMD Radeon RX'),
 StoreProduct('Procesadores','Componentes','Procesadores para equipos de trabajo y gaming.','Intel Core · AMD Ryzen'),
 StoreProduct('Memoria RAM','Componentes','Memoria para mejorar capacidad y respuesta del sistema.','DDR4 · DDR5 · Diferentes capacidades'),
 StoreProduct('Almacenamiento SSD','Almacenamiento','Almacenamiento rápido para sistema, programas y juegos.','SSD SATA · SSD M.2 NVMe'),
 StoreProduct('Monitores y periféricos','Accesorios','Completa tu espacio de trabajo o setup gamer.','Monitores · Teclados · Mouse · Accesorios'),
];
const storeCategories=['Todos','PC Gamer','Computadoras','Laptops','Componentes','Almacenamiento','Accesorios'];
