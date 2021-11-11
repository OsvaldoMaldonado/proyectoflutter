import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_perfil_cuentas.dart';





class ekisde extends StatefulWidget {
  @override
  State<ekisde> createState() => _ekisdeState();
}

class _ekisdeState extends State<ekisde> {
  late Future<bool> _future;

  Settings settings = Settings();

  Future<Map<String, dynamic>> getItem(String tableName, String id) async {
    await Future.delayed(Duration(seconds: 5), () {});
    /*Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tableName WHERE $colId = $id ORDER BY $colCategory DESC, $colName DESC");
    Map<String, dynamic> singleMap = result[0];*/
    return Future.value(null);
  }

  Future<bool> isObtainedDB(Settings settings) async {
    var map = await getItem("_dbHelper.tblSavedata", "id");
    //var map = Map<String, dynamic>();
    bool obtained = true; //map[_dbHelper.colObtained];
    return obtained;
  }

  @override
  void initState() {
    _future = isObtainedDB(settings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: datosespecializaciones(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              List<dynamic> snapdata = snapshot.data as List;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return CheckboxListTile(
                        title: Text("${snapshot.data[index]["nombre"]}"),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: snapshot.data,
                        onChanged: (value) {
                          //setObtained(settings, value);
                        });
                  }
              }
            }));
  }
}

class Settings {}