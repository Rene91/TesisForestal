import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/PresenciaEnfermedadesDB.dart';
import 'package:forestal_app/Modelo/PresenciaEnfermedades.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

class ListFormPresenciaEnfermedadesScreen extends StatefulWidget {
  const ListFormPresenciaEnfermedadesScreen({Key? key}) : super(key: key);

  @override
  _ListFormPresenciaEnfermedadesScreen createState() =>
      _ListFormPresenciaEnfermedadesScreen();
}

class _ListFormPresenciaEnfermedadesScreen
    extends State<ListFormPresenciaEnfermedadesScreen> {
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
        title: const Text("Presencia de Enfermedades"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_form_p_e_screen');
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
    PresenciaEnfermedades obj;

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/list_form_p_e_screen');
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
                obj = PresenciaEnfermedades(
                    int.parse(list?[i]['id_pe']),
                    list?[i]['descripcion_pe'].toString(),
                    list?[i]['estado_pe'].toString()),
                Navigator.of(context).pushNamed(
                    '/edit_form_p_e_screen',
                    arguments: obj),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['descripcion_pe'],
                    style: const TextStyle(fontSize: 18.0, color: kSecondColor),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.cannabis,
                    size: 40.0,
                    color: kSecondColor,
                  ),
                  subtitle: const Text(
                    "Tipo: Enfermedad",
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
  PresenciaEnfermedadesDB mm = PresenciaEnfermedadesDB();
  List? response = await mm.Listar_PE();
  return response;
}
