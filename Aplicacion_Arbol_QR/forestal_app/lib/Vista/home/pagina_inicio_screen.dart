import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'components/menu_lateral.dart';

class PaginaInicioScreen extends StatefulWidget {
  const PaginaInicioScreen({Key? key}) : super(key: key);

  @override
  _PaginaInicioScreen createState() => _PaginaInicioScreen();
}

class _PaginaInicioScreen extends State<PaginaInicioScreen> {
  final TextEditingController _searchQuery = TextEditingController();
  Widget appBarTitle = const Text("Menú Principal");
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
                          hintText: "Busqueda...",
                          hintStyle: TextStyle(color: Colors.white)),
                    );
                  } else {
                    actionIcon = const Icon(Icons.search);
                    appBarTitle = const Text("Menú Principal");
                    _searchQuery.text = "";
                  }
                });
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                  text: "Nombre Científico",
                  icon: Icon(FontAwesomeIcons.cannabis)),
              Tab(text: "Nombre Común", icon: Icon(FontAwesomeIcons.pagelines)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /** inicializamos caja de busqueda**/
            actionIcon = const Icon(Icons.search);
            appBarTitle = const Text("Menú Principal");
            _searchQuery.text = "";
            _listaComunasMenuPrincipal(usuarioBD, "");

            /** pasamos de ventana **/
            Navigator.of(context)
                .pushNamed("/add_form_a_screen", arguments: usuarioBD);
          },
          child: const Icon(
            FontAwesomeIcons.tree,
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: _listaComunasMenuPrincipal(usuarioBD, _searchQuery.text),
        drawer: MenuLateral(
          objUsuario: usuarioBD,
        ),
      ),
    );
  }

  /// cargamos la lista segun el panel**/
  Widget _listaComunasMenuPrincipal(usuarioBD, String descripcion) {
    return TabBarView(
      children: [
        FutureBuilder<List?>(
          future: getArboles(descripcion, "nombre_cientifico_a"),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemListNombreCientifico(
                    list: snapshot.data,
                    objUsuario: usuarioBD,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        FutureBuilder<List?>(
          future: getArboles(descripcion, "nombre_comun_a"),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ItemListNombreComun(
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
class ItemListNombreComun extends StatelessWidget {
  final List? list;
  final Usuario? objUsuario;
  const ItemListNombreComun({this.list, this.objUsuario});

  @override
  Widget build(BuildContext context) {
    Arboles? _objArboles;
    List _listArguementos = [];

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      //Navigator.of(context).pushNamed('/home_screen');
      Navigator.of(context).pushNamed("/inicio_screen", arguments: objUsuario);
    }

    return RefreshIndicator(
      onRefresh: actualizar,
      child: ListView.builder(
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, i) {
          String ImagenBase64 = list?[i]['foto_a'];
          //Uint8List imagen_bytes = Base64Codec().decode(_ImagenBase64);
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => {
                _objArboles = Arboles(
                    int.parse(list?[i]['id_a']),
                    list?[i]['nombre_comun_a'],
                    list?[i]['nombre_cientifico_a'],
                    list?[i]['longitud_a'],
                    list?[i]['latitud_a'],
                    list?[i]['altitud_a'],
                    double.parse(list?[i]['cap_a']),
                    double.parse(list?[i]['dap_a']),
                    double.parse(list?[i]['ht_a']),
                    double.parse(list?[i]['hc_a']),
                    double.parse(list?[i]['tam_copa_prom_a']),
                    int.parse(list?[i]['porcentaje_hojas_a']),
                    list?[i]['madurez_a'],
                    list?[i]['floracion_a'],
                    list?[i]['fructificacion_a'],
                    list?[i]['rectitud_fuste_a'],
                    list?[i]['crecimiento_a'],
                    list?[i]['comentarios_a'],
                    list?[i]['estado_a'],
                    list?[i]['foto_a'],
                    list?[i]['familia_a'],
                    list?[i]['sector_a'],
                    list?[i]['proyecto_a']),
                _listArguementos = [],
                _listArguementos.add(_objArboles),
                _listArguementos.add(objUsuario),
                _accionArbol(list?[i]['nombre_comun_a'], context,
                    _listArguementos, _objArboles!),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['nombre_comun_a'],
                    style: const TextStyle(fontSize: 17.0, color: kSecondColor),
                  ),
                  leading: SizedBox(
                    width: 65,
                    height: 65,
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
                                FontAwesomeIcons.pagelines,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  subtitle: Text(
                    //"Nivel : ${list?[i]['descripcion_pe']}",
                    "Código: " +
                        list?[i]['id_a'] +
                        "\nFamilia: " +
                        list?[i]['familia_a'] +
                        "\nSector: " +
                        list?[i]['sector_a'],
                    style: const TextStyle(fontSize: 12.0, color: Colors.black),
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

class ItemListNombreCientifico extends StatelessWidget {
  final List? list;
  final Usuario? objUsuario;
  const ItemListNombreCientifico({this.list, this.objUsuario});

  @override
  Widget build(BuildContext context) {
    List _listArguementos = [];
    Arboles _objArboles;
    Future<void> actualizar() async {
      Navigator.of(context).pop();
      //Navigator.of(context).pushNamed('/home_screen');
      Navigator.of(context).pushNamed("/inicio_screen", arguments: objUsuario);
    }

    return RefreshIndicator(
      onRefresh: actualizar,
      child: ListView.builder(
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, i) {
          String ImagenBase64 = list?[i]['foto_a'];
          //Uint8List imagen_bytes = Base64Codec().decode(_ImagenBase64);
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => {
                _objArboles = Arboles(
                    int.parse(list?[i]['id_a']),
                    list?[i]['nombre_comun_a'],
                    list?[i]['nombre_cientifico_a'],
                    list?[i]['longitud_a'],
                    list?[i]['latitud_a'],
                    list?[i]['altitud_a'],
                    double.parse(list?[i]['cap_a']),
                    double.parse(list?[i]['dap_a']),
                    double.parse(list?[i]['ht_a']),
                    double.parse(list?[i]['hc_a']),
                    double.parse(list?[i]['tam_copa_prom_a']),
                    int.parse(list?[i]['porcentaje_hojas_a']),
                    list?[i]['madurez_a'],
                    list?[i]['floracion_a'],
                    list?[i]['fructificacion_a'],
                    list?[i]['rectitud_fuste_a'],
                    list?[i]['crecimiento_a'],
                    list?[i]['comentarios_a'],
                    list?[i]['estado_a'],
                    list?[i]['foto_a'],
                    list?[i]['familia_a'],
                    list?[i]['sector_a'],
                    list?[i]['proyecto_a']),
                _listArguementos = [],
                _listArguementos.add(_objArboles),
                _listArguementos.add(objUsuario),
                _accionArbol(list?[i]['nombre_cientifico_a'], context,
                    _listArguementos, _objArboles),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['nombre_cientifico_a'],
                    style: const TextStyle(fontSize: 17.0, color: kSecondColor),
                  ),
                  leading: SizedBox(
                    width: 65,
                    height: 65,
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
                                FontAwesomeIcons.cannabis,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  subtitle: Text(
                    //"Nivel : ${list?[i]['descripcion_pe']}",
                    "Código: " +
                        list?[i]['id_a'] +
                        "\nFamilia: " +
                        list?[i]['familia_a'] +
                        "\nSector: " +
                        list?[i]['sector_a'],
                    style: const TextStyle(fontSize: 12.0, color: Colors.black),
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

/*Obtenemos los datos del servidor*/
Future<List?> getArboles(String descripcion, String campo) async {
  ArbolesDB mm = ArbolesDB();
  List? response = await mm.Listar_A(descripcion, campo);
  return response;
}

void _accionArbol(strTitulo, context, _listArguementos, Arboles objArboles) {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      //backgroundColor: kTreeColor,
      title: Text(strTitulo),
      content: const Text(
        '¿Qué acción desea realizar?',
        style: TextStyle(color: kSecondColor),
      ),
      actions: <Widget>[
        const Divider(
          height: 0.5,
          //color: kGroundColorColor,
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Manejo Forestal'),
            Navigator.of(context)
                .pushNamed('/add_form_i_a_screen', arguments: _listArguementos),
          },
          child: const Text('Manejo Forestal'),
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Ver Datos'),
            Navigator.of(context)
                .pushNamed('/verid_form_a_screen', arguments: objArboles),
          },
          child: const Text('Ver Datos'),
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Editar'),
            Navigator.of(context)
                .pushNamed('/edit_form_a_screen', arguments: _listArguementos),
          },
          child: const Text('Editar'),
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Generar QR'),
            Navigator.of(context).pushNamed('/crear_codigo_qr_screen',
                arguments: _listArguementos),
          },
          child: const Text('Generar QR'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancelar'),
          child: const Text('Cancelar'),
        ),
      ],
    ),
  );
}
