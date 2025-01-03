
import '../database/connection.dart';
import '../models/producto.dart';

class ProductoService {
  Future<void> agregarProducto(String nombre, int cantidad, DateTime fechaVencimiento, int cantidadMinima, [String? descripcion]) async {
    final conn = await Database.getConnection();
    await conn.query(
      'INSERT INTO productos (nombre, cantidad, fecha_vencimiento, cantidad_minima, descripcion) VALUES (?, ?, ?, ?,?)',
      [nombre, cantidad, fechaVencimiento.toIso8601String(), cantidadMinima,descripcion],
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
  
  Future<void> editarDescripcion(int id, String descripcion) async {
  final conn = await Database.getConnection();
  await conn.query(
    'UPDATE productos SET descripcion = ? WHERE id = ?',
    [descripcion, id],
  );
  await conn.close();
}

}
