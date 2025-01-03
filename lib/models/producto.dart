class Producto {
  final int id;
  final String nombre;
  final int cantidad;
  final DateTime fechaVencimiento;
  final int cantidadMinima;
  final String? descripcion; // Hacemos que la descripción sea opcional

  Producto({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.fechaVencimiento,
    required this.cantidadMinima,
    this.descripcion, // La descripción ahora es opcional
  });

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      cantidad: map['cantidad'],
      fechaVencimiento: map['fecha_vencimiento'] is String
          ? DateTime.parse(map['fecha_vencimiento'])
          : map['fecha_vencimiento'] as DateTime,
      cantidadMinima: map['cantidad_minima'],
      descripcion: map['descripcion'], // Puede ser null
    );
  }
}
