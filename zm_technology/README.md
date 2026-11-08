# ZM TECHNOLOGY – Aplicación móvil comercial

Aplicación Flutter para ZM TECHNOLOGY, tienda de tecnología en Quito, Ecuador.

## Funciones
- Inicio con identidad comercial ZM TECHNOLOGY.
- Catálogo propio por categorías: PC Gamer, computadoras, laptops, componentes, almacenamiento y accesorios.
- Búsqueda y filtros.
- Cotización directa por WhatsApp.
- Contacto, sitio web y ubicación Google Maps.
- Pestaña API REST con estados Loading, Success, Error y Pull-to-Refresh.

## API REST (requisito académico)
- DummyJSON: `https://dummyjson.com/products/category/laptops`
- Método GET, sin autenticación.
- Paquetes `http` y `provider`; modelo Dart `Product` con `fromJson` y `toJson`.
- Los productos y precios de la pestaña API son datos externos de demostración, no inventario ni precios oficiales de ZM TECHNOLOGY.

## Datos comerciales
- Web: https://zmtechnology.store/
- WhatsApp: +593 96 857 1192
- Dirección: Av. 25 de Mayo y Juan Garzón, Cotocollao, Quito.
- Maps: https://maps.app.goo.gl/SnEFWBFA6KVfnTTs5?g_st=ac

## Ejecutar
Desde la carpeta del proyecto:
```bash
flutter pub get
flutter run
```
Se necesita Flutter SDK y un emulador/dispositivo Android. Se declara permiso Android `INTERNET`.

## Evidencias QA
- Loading: abrir la pestaña API REST y capturar el indicador de carga.
- Success: esperar la respuesta y capturar la lista.
- Error: pulsar “Probar error QA” en la vista de error; si hay red, desconectar temporalmente Internet o utilizar el control QA.
- Pull-to-Refresh: deslizar hacia abajo en la lista de API.

## GitHub
```bash
git init
git add .
git commit -m "feat: app comercial ZM TECHNOLOGY e integración API REST"
git branch -M main
git remote add origin https://github.com/USUARIO/REPOSITORIO.git
git push -u origin main
```
Sustituir `USUARIO/REPOSITORIO` por el repositorio público real.
