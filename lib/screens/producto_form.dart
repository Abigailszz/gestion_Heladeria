import 'package:flutter/material.dart';
import '../services/producto_service.dart';

class ProductoForm extends StatefulWidget {
  @override
  _ProductoFormState createState() => _ProductoFormState();
}

class _ProductoFormState extends State<ProductoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _cantidadMinimaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  DateTime? _fechaVencimiento;

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _fechaVencimiento != null) {
      final productoService = ProductoService();

      try {
        await productoService.agregarProducto(
          _nombreController.text,
          int.parse(_cantidadController.text),
          _fechaVencimiento!,
          int.parse(_cantidadMinimaController.text),
          _descripcionController.text.isNotEmpty ? _descripcionController.text : null,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto agregado exitosamente')),
        );

        _nombreController.clear();
        _cantidadController.clear();
        _cantidadMinimaController.clear();
        _descripcionController.clear();
        setState(() {
          _fechaVencimiento = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar el producto: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del Producto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cantidadController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cantidadMinimaController,
                decoration: InputDecoration(labelText: 'Cantidad Mínima'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción (opcional)'),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Text(
                _fechaVencimiento == null
                    ? 'Selecciona una fecha de vencimiento'
                    : 'Fecha de vencimiento: ${_fechaVencimiento!.toLocal()}',
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaVencimiento = pickedDate;
                    });
                  }
                },
                child: Text('Seleccionar Fecha'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
