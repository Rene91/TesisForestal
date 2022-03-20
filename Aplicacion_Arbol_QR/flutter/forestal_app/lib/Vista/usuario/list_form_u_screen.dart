import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Controlador/UsuarioDB.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

class ListFormUserScreen extends StatefulWidget {
  const ListFormUserScreen({Key? key}) : super(key: key);

  @override
  _ListFormUserScreen createState() => _ListFormUserScreen();
}

class _ListFormUserScreen extends State<ListFormUserScreen> {
  final TextEditingController _searchQuery = TextEditingController();
  Widget appBarTitle = const Text("Lista de Usuarios");
  Icon actionIcon = const Icon(Icons.search);

  @override
  void initState() {
    super.initState();
    _searchQuery.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Usuario? usuarioBD;
    try {
      usuarioBD = ModalRoute.of(context)!.settings.arguments as Usuario?;
    } catch (e) {
      //print(e);
    }
    setState(() {
      /** cargamos los datos presionados por la caja de busqueda**/
      _searchQuery.addListener(() {
        if (_searchQuery.text.isEmpty) {
          setState(() {
            _searchQuery.text = "";
            _listaComunasMenuPrincipal(usuarioBD, _searchQuery.text.toString());
          });
        } else {
          setState(() {
            _listaComunasMenuPrincipal(usuarioBD, _searchQuery.text.toString());
          });
        }
      });
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (actionIcon.icon == Icons.search) {
                    actionIcon = const Icon(Icons.close);
                    appBarTitle = TextField(
                      controller: _searchQuery,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Busqueda por email o nombre.....",
                          hintStyle: TextStyle(color: Colors.white)),
                    );
                  } else {
                    actionIcon = const Icon(Icons.search);
                    appBarTitle = const Text("Lista de Usuarios");
                    _searchQuery.text = "";
                  }
                });
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Usuarios Activos", icon: Icon(FontAwesomeIcons.users)),
              Tab(
                  text: "Usuarios Pasivos",
                  icon: Icon(FontAwesomeIcons.usersSlash)),
            ],
          ),
        ),
        body: _listaComunasMenuPrincipal(usuarioBD, _searchQuery.text),
      ),
    );
  }

  /// cargamos la lista segun el panel**/
  Widget _listaComunasMenuPrincipal(usuarioBD, String descripcion) {
    return TabBarView(
      children: [
        FutureBuilder<List?>(
          future: getUsuario("A", descripcion),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemListActivos(
                    list: snapshot.data,
                    objUsuario: usuarioBD,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        FutureBuilder<List?>(
          future: getUsuario("P", descripcion),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ItemListPasivos(
                    list: snapshot.data,
                    objUsuario: usuarioBD,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ],
    );
  }
}

/// Creacion de menus inicio**/
class ItemListPasivos extends StatelessWidget {
  final List? list;
  final Usuario? objUsuario;
  const ItemListPasivos({this.list, this.objUsuario});

  @override
  Widget build(BuildContext context) {
    UsuarioDB obUserjBD = UsuarioDB();

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamed('/list_form_u_screen', arguments: objUsuario);
    }

    Future<void> ventanaOpciones(String id) async {
      showDialog<String>(
        barrierDismissible: false,
        //barrierColor: Colors.green,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: kTreeColor,
          //title: Text("strTitulo"),
          content: const Text(
            '¿Que acción desea realizar?',
            style: TextStyle(color: kSecondColor),
          ),
          actions: <Widget>[
            const Divider(
              // height: 1.0,
              color: kGroundColorColor,
            ),
            TextButton(
              onPressed: () => {
                obUserjBD = obUserjBD,
                obUserjBD.Estado_u("A", id),
                actualizar(),
                Navigator.pop(context, 'Activar usuario'),
                Navigator.of(context).pop(),
                Navigator.of(context)
                    .pushNamed('/list_form_u_screen', arguments: objUsuario),
              },
              child: const Text('Activar usuario'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: actualizar,
      child: ListView.builder(
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, i) {
          String ImagenBase64 = list?[i]['foto_u'];
          //Uint8List imagen_bytes = Base64Codec().decode(_ImagenBase64);
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => {
                ventanaOpciones(list?[i]['id_u']),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['nombre_u'] + " " + list?[i]['apellido_u'],
                    style: const TextStyle(fontSize: 20.0, color: kSecondColor),
                  ),
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: ImagenBase64 != ""
                        ? ClipOval(
                            child: Material(
                              color: kPrimaryColor,
                              child: Image.network(
                                ImagenBase64,
                                //color: Colors.white,
                                //size: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const ClipOval(
                            child: Material(
                              color: kPrimaryColor,
                              child: Icon(
                                FontAwesomeIcons.usersSlash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  subtitle: Text(
                    "Nivel: " +
                        list?[i]['nivel_u'] +
                        " \nEmail: " +
                        list?[i]['email_u'],
                    style: const TextStyle(fontSize: 11.0, color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.info_outline),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemListActivos extends StatelessWidget {
  final List? list;
  final Usuario? objUsuario;
  const ItemListActivos({this.list, this.objUsuario});

  @override
  Widget build(BuildContext context) {
    UsuarioDB obUserjBD = UsuarioDB();

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      //Navigator.of(context).pushNamed('/home_screen');
      Navigator.of(context)
          .pushNamed('/list_form_u_screen', arguments: objUsuario);
    }

    Future<void> ventanaOpciones(String id) async {
      showDialog<String>(
        barrierDismissible: false,
        //barrierColor: Colors.green,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: kTreeColor,
          //title: Text("strTitulo"),
          content: const Text(
            '¿Que acción desea realizar?',
            style: TextStyle(color: kSecondColor),
          ),
          actions: <Widget>[
            const Divider(
              // height: 1.0,
              color: kGroundColorColor,
            ),
            TextButton(
              onPressed: () => {
                obUserjBD = obUserjBD,
                obUserjBD.Editar_Nivel("admin", id),
                actualizar(),
                Navigator.pop(context, 'Ser Administrador'),
                Navigator.of(context).pop(),
                Navigator.of(context)
                    .pushNamed('/list_form_u_screen', arguments: objUsuario),
              },
              child: const Text('Ser Administrador'),
            ),
            TextButton(
              onPressed: () => {
                obUserjBD = obUserjBD,
                obUserjBD.Editar_Nivel("usuario", id),
                actualizar(),
                Navigator.pop(context, 'Ser usuario'),
                Navigator.of(context).pop(),
                Navigator.of(context)
                    .pushNamed('/list_form_u_screen', arguments: objUsuario),
              },
              child: const Text('Ser usuario'),
            ),
            TextButton(
              onPressed: () => {
                obUserjBD = obUserjBD,
                obUserjBD.Estado_u("P", id),
                actualizar(),
                Navigator.pop(context, 'Dar de baja'),
                Navigator.of(context).pop(),
                Navigator.of(context)
                    .pushNamed('/list_form_u_screen', arguments: objUsuario),
              },
              child: const Text('Dar de baja'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: actualizar,
      child: ListView.builder(
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, i) {
          String ImagenBase64 = list?[i]['foto_u'];
          //Uint8List imagen_bytes = Base64Codec().decode(_ImagenBase64);
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: objUsuario!.getId_u.toString() != list?[i]['id_u'].toString()
                ? GestureDetector(
                    onTap: () => {
                      ventanaOpciones(list?[i]['id_u']),
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          list?[i]['nombre_u'] + " " + list?[i]['apellido_u'],
                          style: const TextStyle(
                              fontSize: 20.0, color: kSecondColor),
                        ),
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: ImagenBase64 != ""
                              ? ClipOval(
                                  child: Material(
                                    color: kPrimaryColor,
                                    child: Image.network(
                                      ImagenBase64,
                                      //color: Colors.white,
                                      //size: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const ClipOval(
                                  child: Material(
                                    color: kPrimaryColor,
                                    child: Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                        subtitle: Text(
                          "Nivel: " +
                              list?[i]['nivel_u'] +
                              " \nEmail: " +
                              list?[i]['email_u'],
                          style: const TextStyle(
                              fontSize: 11.0, color: Colors.black),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.info_outline),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}

/*Obtenemos los datos del servidor*/
Future<List?> getUsuario(String estado, String descripcion) async {
  UsuarioDB mm = UsuarioDB();

  List? response = await mm.Listar_U_estado(estado, descripcion);
  return response;
}
