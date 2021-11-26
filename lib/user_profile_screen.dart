// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/model/modelo_perfil_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileState createState() => UserProfileState();
}


class UserProfileState extends State<UserProfileScreen> {

  String idUser = '';

  Future<void> getPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id') ?? '';

    setState(() => idUser = id);
  }

  @override
  Widget build(BuildContext context) {
    if (idUser == ''){
      getPhone();
    }
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: const Color(0xFFF96332),
          title: const Text('Mi perfil', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: screenSize * 0.90,
          child: FutureBuilder<List<User>?>(
            future: fetchUser2(http.Client(), idUser),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return Perfil(perfil: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Perfil extends StatelessWidget {
  const Perfil({Key? key, required this.perfil}) : super(key: key);

  final List<User> perfil;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: perfil.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
              left: 6.0,
              right: 6.0,
              bottom: 10.0
          ),
          height: screenheight * .70,
          width: screenSize * .90,
          child: Column(
            children: <Widget>[
              SizedBox(height: screenheight * 0.01),
              Container(
<<<<<<< Updated upstream
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                width: 100.0,
                height: 100.0,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                          "https://t2.uc.ltmcdn.com/images/7/0/0/img_como_saber_si_un_hombre_es_maduro_34007_600_square.jpg")
                          )
                ) 
=======
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  width: 100.0,
                  height: 100.0,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://t2.uc.ltmcdn.com/images/7/0/0/img_como_saber_si_un_hombre_es_maduro_34007_600_square.jpg")
                      )
                  )
>>>>>>> Stashed changes
              ),
              SizedBox(height: screenheight * 0.01),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Correo Electronico >   " + perfil[index].correo, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                    const InkWell(
                      child: Text('\Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
<<<<<<< Updated upstream
                  Text("Nombre >   " + perfil[index].nombre, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Apellido >   " + perfil[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
             ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Telefono >  " + perfil[index].telefono, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
=======
                    Visibility(visible:visibilidad1, child: Text("Nombre >   " + widget.perfil[index].nombre, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),)),
                    Visibility(visible:visibilidad2, child: SizedBox(
                      width: screenSize * 0.70,
                      height: screenheight * 0.07,
                      child: TextField(
                        enabled: visibilidad2,
                        controller: entrada_nombre,
                        decoration: InputDecoration(
                          labelText: '"Nombre >   "',
                        ),
                      ),
                    ),
                    ),
                    InkWell(
                        child: Text(texto, style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                        onTap: () {
                          setState(() {


                            print(contador1);
                            if (contador1 == 0) {
                              visibilidad1 = false;
                              visibilidad2 = true;
                              texto = "Guardar";
                              contador1++;
                            } else {
                              if (contador1 == 1) {
                                visibilidad1 = true;
                                texto = 'Editar';
                                getvalue = entrada_nombre.text.toString();
                                visibilidad2 = false;
                                modificarusuario(widget.perfil[index].nombre, getvalue);
                                contador1 = 0;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                              };
                            }
                          }
                          );

                        }
                    ),
>>>>>>> Stashed changes
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
<<<<<<< Updated upstream
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                  Text("Contraseña >", textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                  InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
            ],
           ),
        ); 
=======
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(visible:visibilidad3, child: Text("Apellido >   " + widget.perfil[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),)),
                      Visibility(visible:visibilidad4, child: SizedBox(
                        width: screenSize * 0.70,
                        height: screenheight * 0.07,
                        child: TextField(
                          enabled: visibilidad4,
                          controller: entrada_apellido,
                          decoration: InputDecoration(
                            labelText: '"Apellido >   "',
                          ),
                        ),
                      ),
                      ),
                      InkWell(
                          child: Text(texto2, style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                          onTap: () {
                            setState(() {
                              print(contador1);
                              if (contador1 == 0) {
                                visibilidad3 = false;
                                visibilidad4 = true;
                                texto2 = "Guardar";
                                contador1++;
                              } else {
                                if (contador1 == 1) {
                                  visibilidad3 = true;
                                  texto2 = 'Editar';
                                  getvalue = entrada_apellido.text.toString();
                                  visibilidad4 = false;
                                  modificarusuarioapellido(widget.perfil[index].apellido, getvalue);
                                  contador1 = 0;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                                };
                              }
                            }
                            );

                          }
                      ),
                    ]
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(visible:visibilidad5, child: Text("Correo >   " + widget.perfil[index].correo, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),)),
                      Visibility(visible:visibilidad6, child: SizedBox(
                        width: screenSize * 0.70,
                        height: screenheight * 0.07,
                        child: TextField(
                          enabled: visibilidad6,
                          controller: entrada_correo,
                          decoration: InputDecoration(
                            labelText: '"Correo >   "',
                          ),
                        ),
                      ),
                      ),
                      InkWell(
                          child: Text(texto3, style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                          onTap: () {
                            setState(() {
                              print(contador1);
                              if (contador1 == 0) {
                                visibilidad5 = false;
                                visibilidad6 = true;
                                texto3 = "Guardar";
                                contador1++;
                              } else {
                                if (contador1 == 1) {
                                  visibilidad5 = true;
                                  texto3 = 'Editar';
                                  getvalue = entrada_correo.text.toString();
                                  visibilidad6 = false;
                                  modificarusuariocorreo(widget.perfil[index].correo, getvalue);
                                  contador1 = 0;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                                };
                              }
                            }
                            );

                          }
                      ),
                    ]
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  <Widget>[
                      Visibility(visible:visibilidad7, child: Text("Telefono >   " + widget.perfil[index].telefono, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),)),
                      Visibility(visible:visibilidad8, child: SizedBox(
                        width: screenSize * 0.70,
                        height: screenheight * 0.07,
                        child: TextField(
                          enabled: visibilidad8,
                          controller: entrada_telefono,
                          decoration: InputDecoration(
                            labelText: '"Telefono >   "',
                          ),
                        ),
                      ),
                      ),
                      InkWell(
                          child: Text(texto4, style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                          onTap: () {
                            setState(() {
                              print(contador1);
                              if (contador1 == 0) {
                                visibilidad7 = false;
                                visibilidad8 = true;
                                texto4 = "Guardar";
                                contador1++;
                              } else {
                                if (contador1 == 1) {
                                  visibilidad7 = true;
                                  texto4 = 'Editar';
                                  getvalue = entrada_correo.text.toString();
                                  visibilidad8 = false;
                                  modificarusuariotelefono(widget.perfil[index].telefono, getvalue);
                                  contador1 = 0;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                                };
                              }
                            }
                            );

                          }
                      ),
                    ]
                ),
              ),
            ],
          ),
        );
>>>>>>> Stashed changes
      },
    );
  }
}