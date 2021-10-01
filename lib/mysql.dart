/*import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Mysql {
  static String host = '192.168.1.80',
      user = 'root',
      password = '',
      db = 'app';
  static int port = 3306;


  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db
    );

    return await MySqlConnection.connect(settings);

  }

  Future<void>  insertarusuario(String nomb, String apell, String contra, String rfc) async {
    Mysql eb = new Mysql();
    eb.getConnection().then((conn) {
      String sql =
          'insert into tab_cliente (nombre,apellido,contrasena,RFC) values(?, ?, ?, ?)';
      conn.query(sql, [
        nomb,
        apell,
        contra,
        rfc
      ]).then((results) {
        print('Inserted customer succesfullly');
      }, onError: (error) {
        print('$error');
      }).whenComplete(() {
        conn.close();
      });
    });
  }
}
*/
