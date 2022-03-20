import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/input_container.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_num_decimal_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_num_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_descrip_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_input.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class EditFormArbolesScreen extends StatefulWidget {
  const EditFormArbolesScreen({Key? key}) : super(key: key);

  @override
  _EditFormArbolesScreen createState() => _EditFormArbolesScreen();
}

class _EditFormArbolesScreen extends State<EditFormArbolesScreen> {
  bool boolInicio = false;
  var _ImagenBase64BD;
  var _FileImage;
  var _ImagePicker;
  late String _strMadurez = "Seleccione Opción";
  late String _strFloracion = "Seleccione Opción";
  late String _strFructuacion = "Seleccione Opción";
  late String _strFuste = "Seleccione Opción";
  late String _strCrecimiento = "Seleccione Opción";
  late String _ImagenBase64Aux = "";

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
  late TextEditingController getTextFamilia = TextEditingController();
  late TextEditingController getTextSector = TextEditingController();
  late TextEditingController getTextProyecto = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ImagePicker = ImagePicker();
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
    getTextFamilia.dispose();
    getTextSector.dispose();
    getTextProyecto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String iniEdit;
    List? _listArguementos =
        ModalRoute.of(context)!.settings.arguments as List?;
    //print(_listArguementos![1]);
    Arboles? objArbol = _listArguementos![0]; //cargamos datos del arbol
    Usuario? objUsuario = _listArguementos[1]; //cargamos datos del usuario
    //print(objUsuario!.getNombre_u);
    if (boolInicio) {
      /*variable para hacer que se cargen los datos de DB una sola vez*/
      getTextIdArbol.text = objArbol!.getId_a.toString();
      getTextNomComun.text = objArbol.getNombre_comun_a.toString();
      getTextNomCientifico.text = objArbol.getNombre_cientifico_a.toString();
      getTextDescricion.text = objArbol.getComentarios_a.toString();
      getTextLatitud.text = objArbol.getLatitud_a.toString();
      getTextLogitud.text = objArbol.getLongitud_a.toString();
      getTextAltitud.text = objArbol.getAltitud_a.toString();
      getTextCap.text = objArbol.getCap_a.toString();
      getTextDap.text = objArbol.getDap_a.toString();
      getTextHt.text = objArbol.getHt_a.toString();
      getTextHc.text = objArbol.getHc_a.toString();
      getTextTamCopaPro.text = objArbol.getTam_copa_prom_a.toString();
      getTextPorcentajeHojas.text = objArbol.getPorcentaje_hojas_a.toString();
      getTextFamilia.text = objArbol.getFamilia_a.toString();
      getTextSector.text = objArbol.getSector_a.toString();
      getTextProyecto.text = objArbol.getProyecto_a.toString();

      _strMadurez = objArbol.getMadurez_a.toString();
      _strFloracion = objArbol.getFloracion_a.toString();
      _strFructuacion = objArbol.getFructificacion_a.toString();
      _strFuste = objArbol.getRectitud_fuste_a.toString();
      _strCrecimiento = objArbol.getCrecimiento_a.toString();

      _ImagenBase64BD = objArbol.getFoto_a.toString();
      boolInicio = false;
    }
    // Uint8List imagen_bytes = Base64Codec().decode(_ImagenBase64BD);
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    int? idPe = objArbol!.getId_a;
    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('Editar Árbol'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  try {
                    setState(() async {
                      ArbolesDB objBD = ArbolesDB();
                      String accion = await objBD.Eliminar_A(idPe!);

                      if (accion == "ACCIÓN CORRECTA") {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed("/inicio_screen", arguments: objUsuario);

                        _Mensaje("Dato eliminado");
                      } else {
                        _Mensaje(
                            "Error al Editar: Revise su conexion de Internet");
                      }
                    });
                  } on Exception catch (exception) {
                    _Mensaje("Error on server-> " + exception.toString());
                    throw Exception("Error on server");
                  } catch (error) {
                    //_Mensaje("Error-> " + error.toString());
                  }
                },
                color: Colors.red,
                icon: const Icon(FontAwesomeIcons.trash),
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
                      strTituloEdicion,
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
                                  child: InkWell(
                                    onTap: () async {
                                      _showPicker(context);
                                    },
                                    child: Image.file(
                                      _FileImage,
                                      //color: Colors.white,
                                      //size: 50,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : ClipOval(
                                child: _ImagenBase64BD != ""
                                    ? Material(
                                        color: kPrimaryColor,
                                        child: InkWell(
                                          onTap: () async {
                                            _showPicker(context);
                                          },
                                          child: Image.network(
                                            _ImagenBase64BD,
                                            //color: Colors.white,
                                            //size: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Material(
                                        color: kPrimaryColor,
                                        child: InkWell(
                                          onTap: () async {
                                            _showPicker(context);
                                          },
                                          child: const Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.white,
                                            size: 150,
                                          ),
                                        ),
                                      ),
                              )),
                    const SizedBox(
                      height: 10,
                    ),
                    InputContainer(
                      child: TextFormField(
                        enabled: false,
                        controller: getTextIdArbol,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          labelText: 'Código Arbol*',
                          //colocamos icono a caja de texto
                          icon: Icon(
                            FontAwesomeIcons.barcode,
                            color: kPrimaryColor,
                          ),
                          //hintText: widget.hint, //ponemos nombre a la caja de texto
                          border: InputBorder
                              .none, //colocamos borde a la caja de texto

                          enabled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputContainer(
                      child: TextFormField(
                        maxLines: 5,
                        enabled: false,
                        controller: getTextProyecto,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          labelText: 'Nombre proyecto*',
                          //colocamos icono a caja de texto
                          icon: Icon(
                            FontAwesomeIcons.tasks,
                            color: kPrimaryColor,
                          ),
                          //hintText: widget.hint, //ponemos nombre a la caja de texto
                          border: InputBorder
                              .none, //colocamos borde a la caja de texto

                          enabled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextInput(
                      icon: FontAwesomeIcons.pagelines,
                      hint: 'Nombre común*',
                      obtenerDatos: getTextNomComun,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextInput(
                      icon: FontAwesomeIcons.cannabis,
                      hint: 'Nombre cientifico*',
                      obtenerDatos: getTextNomCientifico,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextInput(
                      icon: FontAwesomeIcons.teeth,
                      hint: 'Familia*',
                      obtenerDatos: getTextFamilia,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextDescripInput(
                      icon: Icons.assignment_rounded,
                      hint: 'Comentarios*',
                      obtenerDatos: getTextDescricion,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputContainer(
                      child: Column(children: <Widget>[
                        const Text('Información General'),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listEstadoMadurez,
                                    label: "Estado de madurez*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strMadurez = a.toString();
                                      });
                                    },
                                    selectedItem: _strMadurez),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listFloracion,
                                    label: "Floración*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strFloracion = a.toString();
                                      });
                                    },
                                    selectedItem: _strFloracion),
                              ),
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listEspacioCrecimiento,
                                    label: "Espacio Crecimiento*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strCrecimiento = a.toString();
                                      });
                                    },
                                    selectedItem: _strCrecimiento),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listRectitudFuste,
                                    label: "Rectitud del fuste*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith("Seleccione Opción"),
                                    onChanged: (a) {
                                      setState(() {
                                        _strFuste = a.toString();
                                      });
                                    },
                                    selectedItem: _strFuste),
                              ),
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listFructuacion,
                                    label: "Frutuación*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strFructuacion = a.toString();
                                      });
                                    },
                                    selectedItem: _strFructuacion),
                              ),
                            ]),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.sourcetree,
                          hint: 'CAP* (cm)',
                          obtenerDatos: getTextCap,
                          suffixText: "cm",
                          helperText: "Circunferencia del Fuste",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.drumSteelpan,
                          hint: 'DAP* (cm)',
                          obtenerDatos: getTextDap,
                          suffixText: "cm",
                          helperText: "Diámetro",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.campground,
                          hint: 'HT* (m)',
                          obtenerDatos: getTextHt,
                          suffixText: "m",
                          helperText: "Altura Total",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.trello,
                          hint: 'HC* (m)',
                          obtenerDatos: getTextHc,
                          suffixText: "m",
                          helperText: "Altura Comercial",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.teethOpen,
                          hint: 'Promedio copa* (m)',
                          obtenerDatos: getTextTamCopaPro,
                          suffixText: "m",
                          helperText: "Tamaño Copa Promedio",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.percentage,
                          hint: 'Porcentaje hojas* (%)',
                          obtenerDatos: getTextPorcentajeHojas,
                          suffixText: "%",
                          helperText: "",
                          caracteres: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                    InputContainer(
                      child: Column(children: <Widget>[
                        const Text('Geo Ubicación'),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundTextInput(
                          icon: FontAwesomeIcons.streetView,
                          hint: 'Sector*',
                          obtenerDatos: getTextSector,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundNumInput(
                          icon: FontAwesomeIcons.locationArrow,
                          hint: 'Altitud*',
                          obtenerDatos: getTextAltitud,
                        ),
                        RoundNumInput(
                          icon: FontAwesomeIcons.locationArrow,
                          hint: 'Logitud*',
                          obtenerDatos: getTextLogitud,
                        ),
                        RoundNumInput(
                          icon: FontAwesomeIcons.locationArrow,
                          hint: 'Latitud*',
                          obtenerDatos: getTextLatitud,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(FontAwesomeIcons.mapMarkerAlt),
                            FlatButton(
                              onPressed: () {
                                _getUbicacionActual();
                                //Navigator.pushNamed(context, "YourRoute");
                              },
                              //icon: Icons.add_location,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  color: Colors.red,
                                  child: const Text(
                                    "Obtener ubicación actual",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () {
                          try {
                            if (globalFormkey_Arbol.currentState!.validate()) {
                              if (getTextNomComun.text.length > 3 &&
                                  getTextNomCientifico.text.length > 3 &&
                                  getTextLogitud.text.length > 3 &&
                                  getTextLatitud.text.length > 3 &&
                                  getTextAltitud.text.length > 3 &&
                                  getTextCap.text.isNotEmpty &&
                                  getTextDap.text.isNotEmpty &&
                                  getTextHt.text.isNotEmpty &&
                                  getTextHc.text.isNotEmpty &&
                                  getTextTamCopaPro.text.isNotEmpty &&
                                  getTextPorcentajeHojas.text.isNotEmpty &&
                                  getTextDescricion.text.length > 2 &&
                                  getTextFamilia.text.length > 3 &&
                                  getTextSector.text.length > 3 &&
                                  getTextProyecto.text.length > 3) {
                                if (_strMadurez != "Seleccione Opción" &&
                                    _strFloracion != "Seleccione Opción" &&
                                    _strCrecimiento != "Seleccione Opción" &&
                                    _strFuste != "Seleccione Opción" &&
                                    _strFructuacion != "Seleccione Opción") {
                                  setState(() async {
                                    _cargarDatos(context);
                                    /* if (_ImagenBase64Aux == "") {
                                    _ImagenBase64Aux =
                                        _ImagenBase64BD; //verificamos si exixtio imagen o no
                                  }*/
                                    Arboles obj = Arboles(
                                        int.parse(getTextIdArbol.text),
                                        getTextNomComun.text,
                                        getTextNomCientifico.text,
                                        getTextLogitud.text,
                                        getTextLatitud.text,
                                        getTextAltitud.text,
                                        double.parse(getTextCap.text),
                                        double.parse(getTextDap.text),
                                        double.parse(getTextHt.text),
                                        double.parse(getTextHc.text),
                                        double.parse(getTextTamCopaPro.text),
                                        int.parse(getTextPorcentajeHojas.text),
                                        _strMadurez,
                                        _strFloracion,
                                        _strFructuacion,
                                        _strFuste,
                                        _strCrecimiento,
                                        getTextDescricion.text,
                                        "A",
                                        _ImagenBase64Aux,
                                        getTextFamilia.text,
                                        getTextSector.text,
                                        getTextProyecto.text);
                                    ArbolesDB objBD = ArbolesDB();
                                    String accion = await objBD.Editar_A(obj);

                                    Navigator.pop(context);
                                    if (accion == "ACCIÓN CORRECTA") {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(
                                          "/inicio_screen",
                                          arguments: objUsuario);
                                    } else {
                                      _Mensaje(
                                          "Error al Editar: Revise su conexion de Internet");
                                    }
                                  });
                                  //print("guardar");
                                } else {
                                  _Mensaje(
                                      "Error: Verificar Campos de Informacamción General");
                                }
                              } else {
                                _Mensaje(
                                    "Error: Verificar campos que esten llenos");
                              }
                            } else {
                              //print("no guardar");
                            }
                          } on Exception catch (exception) {
                            _Mensaje(
                                "Error on server-> " + exception.toString());
                            throw Exception("Error on server");
                          } catch (error) {
                            //_Mensaje("Error-> " + error.toString());
                          }
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
                            "Actualizar",
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
                      height: 5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
  }

  void _getUbicacionActual() async {
    //print('getLocation');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //print(position);

    getTextLatitud.text = (position.latitude.toString());
    getTextLogitud.text = (position.longitude.toString());
    getTextAltitud.text = (position.altitude.toString());
  }

  /*Metodos camara*/
  _imgFromCamera() async {
    XFile? image = await _ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _FileImage = File(image!.path);
    });
    final bytes = await Io.File(image!.path).readAsBytesSync();
    _ImagenBase64Aux = base64Encode(bytes);
  }

  _imgFromGallery() async {
    XFile? image = await _ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _FileImage = File(image!.path);
    });
    final bytes = await Io.File(image!.path).readAsBytesSync();
    _ImagenBase64Aux = base64Encode(bytes);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Libreria de Fotos'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Cámara'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

void _cargarDatos(context) {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: kTreeColor,
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
      actions: <Widget>[],
    ),
  );
}
