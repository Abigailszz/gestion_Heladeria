import 'package:flutter/material.dart';
import 'package:gestion_productos/screens/producto_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductoForm(),
    );
  }
}
