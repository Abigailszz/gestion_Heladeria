import 'package:mysql1/mysql1.dart';

class Database {
  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'nueva_contraseña', // Cambia esto si tienes una contraseña
      db: 'gestion_heladeria',
    );
    return await MySqlConnection.connect(settings);
  }
}
