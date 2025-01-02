
import '../database/connection.dart';
import '../models/producto.dart';

class ProductoService {
  Future<void> agregarProducto(String nombre, int cantidad, DateTime fechaVencimiento, int cantidadMinima) async {
    final conn = await Database.getConnection();
    await conn.query(
      'INSERT INTO productos (nombre, cantidad, fecha_vencimiento, cantidad_minima) VALUES (?, ?, ?, ?)',
      [nombre, cantidad, fechaVencimiento.toIso8601String(), cantidadMinima],
    );
    await conn.close();
  }

  Future<List<Producto>> obtenerProductos() async {
    final conn = await Database.getConnection();
    final results = await conn.query('SELECT * FROM productos');
    print('Resultados crudos: ${results}');
    await conn.close();
    return results.map((row) => Producto.fromMap(row.fields)).toList();
  }
}
