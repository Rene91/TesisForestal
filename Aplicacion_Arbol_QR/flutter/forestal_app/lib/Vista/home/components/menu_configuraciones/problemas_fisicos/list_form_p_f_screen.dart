import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ProblemasFisicosDB.dart';
import 'package:forestal_app/Modelo/ProblemasFisicos.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

class ListFormProblemasFisicosScreen extends StatefulWidget {
  const ListFormProblemasFisicosScreen({Key? key}) : super(key: key);

  @override
  _ListFormProblemasFisicosScreen createState() => _ListFormProblemasFisicosScreen();
}

class _ListFormProblemasFisicosScreen extends State<ListFormProblemasFisicosScreen> {
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
        title: const Text("Problemas Físicos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_form_p_f_screen');
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
    ProblemasFisicos obj;

    Future<void> actualizar() async {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/list_form_p_f_screen');
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
                obj = ProblemasFisicos(
                    int.parse(list?[i]['id_pf']),
                    list?[i]['descripcion_pf'].toString(),
                    list?[i]['estado_pf'].toString()),
                Navigator.of(context)
                    .pushNamed('/edit_form_p_f_screen', arguments: obj),
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    list?[i]['descripcion_pf'],
                    style: const TextStyle(fontSize: 18.0, color: kSecondColor),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.cannabis,
                    size: 40.0,
                    color: kSecondColor,
                  ),
                  subtitle: const Text(
                    //"Nivel : ${list?[i]['descripcion_pe']}",
                    "Tipo: Problema Físico",
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
  ProblemasFisicosDB mm = ProblemasFisicosDB();
  List? response = await mm.Listar_PF();
  return response;
}
