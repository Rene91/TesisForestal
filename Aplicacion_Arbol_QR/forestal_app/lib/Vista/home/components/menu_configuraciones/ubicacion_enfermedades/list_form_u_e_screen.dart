import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/UbicacionfermedadesDB.dart';
import 'package:forestal_app/Modelo/UbicacionEnfermedades.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

class ListFormUbicacionEnfermedadesScreen extends StatefulWidget {
  const ListFormUbicacionEnfermedadesScreen({Key? key}) : super(key: key);

  @override
  _ListFormUbicacionEnfermedadesScreen createState() =>
      _ListFormUbicacionEnfermedadesScreen();
}

class _ListFormUbicacionEnfermedadesScreen
    extends State<ListFormUbicacionEnfermedadesScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ubicación de Enfermedades"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_form_u_e_screen');
        },
        child: const Icon(Icons.add_circle_outline),
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List?>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List? list;

  const ItemList({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UbicacionEnfermedades obj;

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/list_form_u_e_screen');
    }

    return RefreshIndicator(
      onRefresh: actualizar,
      child: ListView.builder(
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => {
                obj = UbicacionEnfermedades(
                    int.parse(list?[i]['id_ue']),
                    list?[i]['descripcion_ue'].toString(),
                    list?[i]['estado_ue'].toString()),
                Navigator.of(context)
                    .pushNamed('/edit_form_u_e_screen', arguments: obj),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['descripcion_ue'],
                    style: const TextStyle(fontSize: 18.0, color: kSecondColor),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.cannabis,
                    size: 40.0,
                    color: kSecondColor,
                  ),
                  subtitle: const Text(
                    //"Nivel : ${list?[i]['descripcion_pe']}",
                    "Tipo: Ubicación",
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
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
Future<List?> getData() async {
  UbicacionEnfermedadesDB mm = UbicacionEnfermedadesDB();
  List? response = await mm.Listar_UE();
  return response;
}
