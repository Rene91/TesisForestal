import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/input_container.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_label_descripcion_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_label_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_label_numerico_input.dart';

class VerIdFormArbolesScreen extends StatefulWidget {
  const VerIdFormArbolesScreen({Key? key}) : super(key: key);

  @override
  _VerIdFormArbolesScreen createState() => _VerIdFormArbolesScreen();
}

class _VerIdFormArbolesScreen extends State<VerIdFormArbolesScreen> {
  bool boolInicio = false;
  var _ImagenBase64BD = "";
  var _FileImage;
  late String _strMadurez = "";
  late String _strFloracion = "";
  late String _strFructuacion = "";
  late String _strFuste = "";
  late String _strCrecimiento = "";

  /*   --------------- Parametros para Editar Usuario --------------*/
  late TextEditingController getTextIdArbol = TextEditingController();
  late TextEditingController getTextNomComun = TextEditingController();
  late TextEditingController getTextNomCientifico = TextEditingController();
  late TextEditingController getTextDescricion = TextEditingController();
  late TextEditingController getTextLatitud = TextEditingController();
  late TextEditingController getTextLogitud = TextEditingController();
  late TextEditingController getTextAltitud = TextEditingController();
  late TextEditingController getTextCap = TextEditingController();
  late TextEditingController getTextDap = TextEditingController();
  late TextEditingController getTextHt = TextEditingController();
  late TextEditingController getTextHc = TextEditingController();
  late TextEditingController getTextTamCopaPro = TextEditingController();
  late TextEditingController getTextPorcentajeHojas = TextEditingController();
  late TextEditingController getTextSector = TextEditingController();
  late TextEditingController getTextProyecto = TextEditingController();

  @override
  void initState() {
    super.initState();
    boolInicio = true;
    /*Obtenemos los datos del Usuario*/
  }

  @override
  void dispose() {
    getTextIdArbol.dispose();
    getTextNomComun.dispose();
    getTextNomCientifico.dispose();
    getTextDescricion.dispose();
    getTextLatitud.dispose();
    getTextLogitud.dispose();
    getTextAltitud.dispose();
    getTextCap.dispose();
    getTextDap.dispose();
    getTextHt.dispose();
    getTextHc.dispose();
    getTextTamCopaPro.dispose();
    getTextPorcentajeHojas.dispose();
    getTextSector.dispose();
    getTextProyecto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Arboles? _objArbol = ModalRoute.of(context)!.settings.arguments
        as Arboles?; //cargamos datos del arbol

    if (boolInicio) {
      /*variable para hacer que se cargen los datos de DB una sola vez*/
      getTextIdArbol.text = _objArbol!.getId_a.toString();
      getTextNomComun.text = _objArbol.getNombre_comun_a.toString();
      getTextNomCientifico.text = _objArbol.getNombre_cientifico_a.toString();
      getTextDescricion.text = _objArbol.getComentarios_a.toString();
      getTextLatitud.text = _objArbol.getLatitud_a.toString();
      getTextLogitud.text = _objArbol.getLongitud_a.toString();
      getTextAltitud.text = _objArbol.getAltitud_a.toString();
      getTextCap.text = _objArbol.getCap_a.toString();
      getTextDap.text = _objArbol.getDap_a.toString();
      getTextHt.text = _objArbol.getHt_a.toString();
      getTextHc.text = _objArbol.getHc_a.toString();
      getTextTamCopaPro.text = _objArbol.getTam_copa_prom_a.toString();
      getTextPorcentajeHojas.text = _objArbol.getPorcentaje_hojas_a.toString();
      getTextSector.text = _objArbol.getSector_a.toString();
      getTextProyecto.text = _objArbol.getProyecto_a.toString();

      _strMadurez = _objArbol.getMadurez_a.toString();
      _strFloracion = _objArbol.getFloracion_a.toString();
      _strFructuacion = _objArbol.getFructificacion_a.toString();
      _strFuste = _objArbol.getRectitud_fuste_a.toString();
      _strCrecimiento = _objArbol.getCrecimiento_a.toString();

      _ImagenBase64BD = _objArbol.getFoto_a.toString();
      boolInicio = false;
    }

    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Datos Árbol'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.assignment),
            tooltip: 'Grid',
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        child: Form(
          key: globalFormkey_Arbol,
          autovalidate: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(
                  height: 10.0,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  strTituloVerDatos,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      //ponemos en negrita el texto
                      fontSize: 24 //aumentamos letra
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    height: 200,
                    child: _FileImage != null
                        ? ClipOval(
                            child: Material(
                              color: kPrimaryColor,
                              child: Image.network(
                                _ImagenBase64BD,
                                //color: Colors.white,
                                //size: 50,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : ClipOval(
                            child: _ImagenBase64BD != ""
                                ? Material(
                                    color: kPrimaryColor,
                                    child: Image.network(
                                      _ImagenBase64BD,
                                      //color: Colors.white,
                                      //size: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Material(
                                    color: kPrimaryColor,
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                      size: 150,
                                    ),
                                  ),
                          )),
                const SizedBox(
                  height: 20,
                ),
                ExpansionTile(
                    /*leading: const Icon(
                Icons.settings,
                color: kSecondColor,
              ),*/
                    title: const Text(
                      'INFORMACIÓN GENERAL',
                      style: TextStyle(color: kSecondColor),
                    ),
                    children: <Widget>[
                      RoundLabelInput(
                        icon: FontAwesomeIcons.barcode,
                        text: 'Código Arbol',
                        obtenerDatos: getTextIdArbol,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundLabelInput(
                        icon: FontAwesomeIcons.pagelines,
                        text: 'Nombre común',
                        obtenerDatos: getTextNomComun,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundLabelInput(
                        icon: FontAwesomeIcons.cannabis,
                        text: 'Nombre cientifico',
                        obtenerDatos: getTextNomCientifico,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                ExpansionTile(
                    /*leading: const Icon(
                Icons.settings,
                color: kSecondColor,
              ),*/
                    title: const Text(
                      'CARACTERÍSTICAS DEL ÁRBOL',
                      style: TextStyle(color: kSecondColor),
                    ),
                    children: <Widget>[
                      RoundLabelNumericoInput(
                        icon: FontAwesomeIcons.sourcetree,
                        hint: 'Circunferencia del Fuste (CAP)',
                        obtenerDatos: getTextCap,
                        suffixText: "cm",
                      ),
                      RoundLabelNumericoInput(
                        icon: FontAwesomeIcons.drumSteelpan,
                        hint: 'Diámetro (DAP)',
                        obtenerDatos: getTextDap,
                        suffixText: "cm",
                      ),
                      RoundLabelNumericoInput(
                        icon: FontAwesomeIcons.campground,
                        hint: 'Altura Total (HT)',
                        obtenerDatos: getTextHt,
                        suffixText: "m",
                      ),
                      RoundLabelNumericoInput(
                        icon: FontAwesomeIcons.trello,
                        hint: 'Altura Comercial (HC)',
                        obtenerDatos: getTextHc,
                        suffixText: "m",
                      ),
                      RoundLabelNumericoInput(
                        icon: FontAwesomeIcons.teethOpen,
                        hint: 'Tamaño Copa Promedio',
                        obtenerDatos: getTextTamCopaPro,
                        suffixText: "m",
                      ),
                      RoundLabelNumericoInput(
                        icon: FontAwesomeIcons.percentage,
                        hint: 'Porcentaje hojas',
                        obtenerDatos: getTextPorcentajeHojas,
                        suffixText: "%",
                      ),
                    ]),
                ExpansionTile(
                    /*leading: const Icon(
                Icons.settings,
                color: kSecondColor,
              ),*/
                    title: const Text(
                      'UBICACIÓN',
                      style: TextStyle(color: kSecondColor),
                    ),
                    children: <Widget>[
                      RoundLabelInput(
                        icon: FontAwesomeIcons.streetView,
                        text: 'Sector',
                        obtenerDatos: getTextSector,
                      ),
                      InputContainer(
                        child: Column(children: <Widget>[
                          const Text('Geo Ubicación'),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(FontAwesomeIcons.mapMarkerAlt),
                              FlatButton(
                                onPressed: () {
                                  //Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(
                                      "/verid_form_g_u_a_screen",
                                      arguments: _objArbol);
                                  //_getUbicacionActual();
                                  //Navigator.pushNamed(context, "YourRoute");
                                },
                                //icon: Icons.add_location,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    color: Colors.red,
                                    child: const Text(
                                      "Mirar ubicación en mapa",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ]),
                ExpansionTile(
                    /*leading: const Icon(
                Icons.settings,
                color: kSecondColor,
              ),*/
                    title: const Text(
                      'INFORMACIÓN ADICIONAL',
                      style: TextStyle(color: kSecondColor),
                    ),
                    children: <Widget>[
                      RoundLabelDescripcionInput(
                        icon: FontAwesomeIcons.tasks,
                        text: 'Nombre de proyecto',
                        obtenerDatos: getTextProyecto,
                      ),
                    ]),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/verid_form_i_a_screen",
                          arguments: _objArbol);
                    },
                    child: Container(
                      //width: 200.0,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kPrimaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      //child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      child: const Text(
                        "MANEJO FORESTAL",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const RoundeButtonCancelar(
                  title: "Cancelar",
                  ubicacion: "",
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
