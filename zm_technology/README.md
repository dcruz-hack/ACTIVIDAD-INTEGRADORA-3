# ZM TECHNOLOGY – Aplicación móvil Flutter

Aplicación comercial para ZM TECHNOLOGY que consume el catálogo público de la tienda web.

## API propia utilizada
- Catálogo: `GET https://zmtechnology.store/api/public/products`
- Ficha completa: `GET https://zmtechnology.store/api/public/products/{handle}`
- Imágenes de producto: URL proporcionada por el campo `image` del catálogo.

La respuesta compartida para el catálogo muestra el objeto raíz `productos` y, en cada elemento, campos como `id`, `handle`, `title`, `brand`, `category`, `minPrice`, `image` y `variants`. Las variantes contienen `id`, `title`, `sku`, `price`, `compareAtPrice`, `available` y `options`.

El código admite nombres equivalentes en español (por ejemplo `marca`, `categoria`, `precioMinimo`, `imagen`, `variantes`, `precio`, `disponible`) el texto JSON compartido contiene claves mezcladas en español e inglés.

## Funcionalidades
- Catálogo real desde el endpoint público de ZM TECHNOLOGY.
- Búsqueda por título, marca, categoría o SKU.
- Filtro dinámico por categorías devueltas por la API.
- Fotografías, precio mínimo y disponibilidad.
- Ficha de producto cargada por `handle`.
- Estados Loading, Success y Error con Provider.
- Pull-to-Refresh y reintento.
- Contacto comercial, web y ubicación.

## Ejecutar
bash
flutter pub get
flutter run


Se requiere Flutter SDK y conexión a Internet. Android debe conservar el permiso `android.permission.INTERNET`.

## QA para la actividad
1. Loading: abrir la pestaña API REST mientras carga el catálogo.
2. Success: esperar los productos reales y abrir la ficha de cualquier producto.
3. Error: usar “Probar error QA” o desactivar la conexión antes de recargar.
4. Refresh: deslizar hacia abajo en el catálogo.

## Autor

Deivid Cruz