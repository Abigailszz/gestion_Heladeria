import '../services/producto_service.dart';

class Alertas {
  final ProductoService _productoService = ProductoService();

  Future<void> verificarReposicion() async {
    final productos = await _productoService.obtenerProductos();
    for (var producto in productos) {
      if (producto.cantidad < producto.cantidadMinima) {
        print('Alerta: El producto ${producto.nombre} necesita reposición.');
      }
    }
  }

  Future<void> verificarVencimientos() async {
    final productos = await _productoService.obtenerProductos();
    final hoy = DateTime.now();
    for (var producto in productos) {
      if (producto.fechaVencimiento.difference(hoy).inDays <= 7) {
        print('Alerta: El producto ${producto.nombre} está cerca de vencer.');
      }else{
        print('Alerta: El producto ${producto.nombre} no está cerca de vencer');
      }
    }
  }
}
