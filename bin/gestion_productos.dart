import 'package:flutter/material.dart';
import 'package:gestion_productos/screens/producto_form.dart';
import 'package:gestion_productos/services/producto_service.dart';
import 'package:gestion_productos/models/producto.dart';
import 'package:gestion_productos/screens/productos_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión Heladería',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GestionHeladeria(),
    );
  }
}

class GestionHeladeria extends StatefulWidget {
  const GestionHeladeria({Key? key}) : super(key: key);

  @override
  _GestionHeladeriaState createState() => _GestionHeladeriaState();
}

class _GestionHeladeriaState extends State<GestionHeladeria> {
  int _selectedIndex = 0;
  final ProductoService _productoService = ProductoService();

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      ProductosPage(productoService: _productoService),
      ProductoForm(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión Heladería'),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Productos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text('Agregar Producto'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
