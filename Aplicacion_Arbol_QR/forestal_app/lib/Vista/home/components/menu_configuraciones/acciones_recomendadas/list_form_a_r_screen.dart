import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/AccionesRecomendadasDB.dart';
import 'package:forestal_app/Modelo/AccionesRecomendadas.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

class ListFormAccionesRecomendadasScreen extends StatefulWidget {
  const ListFormAccionesRecomendadasScreen({Key? key}) : super(key: key);

  @override
  _ListFormAccionesRecomendadasScreen createState() =>
      _ListFormAccionesRecomendadasScreen();
}

class _ListFormAccionesRecomendadasScreen
    extends State<ListFormAccionesRecomendadasScreen> {
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
        title: const Text("Acciones Recomendadas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_form_a_r_screen');
        },
        child: const Icon(Icons.add_circle_rounded),
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
    AccionesRecomendadas obj;

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/list_form_a_r_screen');
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
                obj = AccionesRecomendadas(
                    int.parse(list?[i]['id_ar']),
                    list?[i]['descripcion_ar'].toString(),
                    list?[i]['estado_ar'].toString()),
                Navigator.of(context).pushNamed(
                    '/edit_form_a_r_screen',
                    arguments: obj),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['descripcion_ar'],
                    style: const TextStyle(fontSize: 18.0, color: kSecondColor),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.pagelines,
                    size: 40.0,
                    color: kSecondColor,
                  ),
                  subtitle: const Text(
                    "Tipo: Acciones Recomendadas",
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      //Icon(Icons.star),
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
  AccionesRecomendadasDB mm = AccionesRecomendadasDB();
  List? response = await mm.Listar_AR();
  return response;
}
