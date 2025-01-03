import 'package:flutter/material.dart';
import '../services/producto_service.dart';
import '../models/producto.dart';

class ProductosPage extends StatefulWidget {
  final ProductoService productoService;
  const ProductosPage({Key? key, required this.productoService}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  late Future<List<Producto>> _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = widget.productoService.obtenerProductos();
  }

Future<void> _editarDescripcion(Producto producto) async {
  final TextEditingController _descripcionController =
      TextEditingController(text: producto.descripcion ?? '');

  final result = await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar Descripción'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8, // 80% del ancho de la pantalla
          height: MediaQuery.of(context).size.height * 0.4, // 40% de la altura de la pantalla
          child: TextField(
            controller: _descripcionController,
            decoration: const InputDecoration(
              labelText: 'Nueva descripción',
              border: OutlineInputBorder(), // Agrega un borde para mejor visibilidad
            ),
            maxLines: null, // Permite múltiples líneas
            expands: true, // Expande el TextField para llenar el espacio disponible
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _descripcionController.text),
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );

  if (result != null && result != producto.descripcion) {
    try {
      await widget.productoService.editarDescripcion(producto.id, result);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Descripción actualizada correctamente')),
      );
      setState(() {
        _productosFuture = widget.productoService.obtenerProductos();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la descripción: $e')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Producto>>(
          future: _productosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay productos disponibles.'));
            }

            final productos = snapshot.data!;
            return DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Fecha de Vencimiento')),
                DataColumn(label: Text('Cantidad Mínima')),
                DataColumn(label: Text('Descripción')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: productos.map((producto) {
                return DataRow(cells: [
                  DataCell(Text(producto.id.toString())),
                  DataCell(Text(producto.nombre)),
                  DataCell(Text(producto.cantidad.toString())),
                  DataCell(Text(producto.fechaVencimiento.toLocal().toString())),
                  DataCell(Text(producto.cantidadMinima.toString())),
                  
                  DataCell(
  ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 150), // Ajusta el ancho máximo
    child: Text(
      producto.descripcion ?? 'Sin descripción',
      overflow: TextOverflow.ellipsis, // Muestra "..." si el texto es muy largo
      maxLines: 1, // Limita a una línea visible
    ),
  ),
),

                  DataCell(
                    ElevatedButton(
                      onPressed: () => _editarDescripcion(producto),
                      child: const Text('Editar'),
                    ),
                  ),
                ]);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
