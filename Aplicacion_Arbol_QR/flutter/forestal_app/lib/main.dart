import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/Vista/home/pagina_inicio_screen.dart';
import 'package:forestal_app/Vista/login/login_screen.dart';
import 'package:forestal_app/Vista/login/login_screen2.dart';
import 'package:forestal_app/Vista/usuario/edit_form_u_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Vista/home/components/menu_arboles/add_from_a_screen.dart';
import 'Vista/home/components/menu_arboles/edit_from_a_screen.dart';
import 'Vista/home/components/menu_configuraciones/estado_fitosanitario/add_form_e_f_screen.dart';
import 'Vista/home/components/menu_configuraciones/estado_fitosanitario/edit_form_e_f_screen.dart';
import 'Vista/home/components/menu_configuraciones/estado_fitosanitario/list_form_e_f_screen.dart';
import 'Vista/home/components/menu_geo_ubicacion_arbol/list_form_g_u_a_screen.dart';
import 'Vista/home/components/menu_geo_ubicacion_arbol/verid_form_g_u_a_screen.dart';
import 'Vista/home/components/menu_inconvenientes_arboles/add_form_i_a_screen.dart';
import 'Vista/home/components/menu_arboles/verid_from_a_screen.dart';
import 'Vista/home/components/menu_configuraciones/acciones_recomendadas/add_form_a_r_screen.dart';
import 'Vista/home/components/menu_configuraciones/acciones_recomendadas/edit_form_a_r_screen.dart';
import 'Vista/home/components/menu_configuraciones/acciones_recomendadas/list_form_a_r_screen.dart';
import 'Vista/home/components/menu_configuraciones/presencia_enfermedades/add_form_p_e_screen.dart';
import 'Vista/home/components/menu_configuraciones/presencia_enfermedades/edit_form_p_e_screen.dart';
import 'Vista/home/components/menu_configuraciones/presencia_enfermedades/list_form_p_e_screen.dart';
import 'Vista/home/components/menu_configuraciones/presencia_plagas/add_form_p_p_screen.dart';
import 'Vista/home/components/menu_configuraciones/presencia_plagas/edit_form_p_p_screen.dart';
import 'Vista/home/components/menu_configuraciones/presencia_plagas/list_form_p_p_screen.dart';
import 'Vista/home/components/menu_configuraciones/problemas_fisicos/add_form_p_f_screen.dart';
import 'Vista/home/components/menu_configuraciones/problemas_fisicos/edit_form_p_f_screen.dart';
import 'Vista/home/components/menu_configuraciones/problemas_fisicos/list_form_p_f_screen.dart';
import 'Vista/home/components/menu_configuraciones/riesgos_potenciales/add_form_r_p_screen.dart';
import 'Vista/home/components/menu_configuraciones/riesgos_potenciales/edit_form_r_p_screen.dart';
import 'Vista/home/components/menu_configuraciones/riesgos_potenciales/list_form_r_p_screen.dart';
import 'Vista/home/components/menu_configuraciones/ubicacion_enfermedades/add_form_u_e_screen.dart';
import 'Vista/home/components/menu_configuraciones/ubicacion_enfermedades/edit_form_u_e_screen.dart';
import 'Vista/home/components/menu_configuraciones/ubicacion_enfermedades/list_form_u_e_screen.dart';
import 'Vista/home/components/menu_inconvenientes_arboles/verid_form_i_a_screen.dart';
import 'Vista/home/components/menu_qr/crear_codigo_qr_screen.dart';
import 'Vista/usuario/list_form_u_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
 // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Quitar franja Debug de aplicacion
      title: 'Árbol QR',
      theme: ThemeData(
        //brightness:  Brightness.dark,
        primarySwatch: Colors.green,
        /*textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),*/
        //primaryColor: kPrimaryColor,
       // textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      routes: {
        "/": (BuildContext context) => const LoginScreen(),
        "/inicio_screen": (BuildContext context) => const PaginaInicioScreen(),
        "/edit_form_u_screen": (BuildContext context) =>
            const EditFormUserScreen(),
        "/list_form_u_screen": (BuildContext context) =>
        const ListFormUserScreen(),
        "/login": (BuildContext context) => const LoginScreen2(),

        /*Presencia enfermedades */
        "/list_form_p_e_screen": (BuildContext context) =>
            const ListFormPresenciaEnfermedadesScreen(),
        "/add_form_p_e_screen": (BuildContext context) =>
            const AddFormPresenciaEnfermedadesScreen(),
        "/edit_form_p_e_screen": (BuildContext context) =>
            const EditFormPresenciaEnfermedadesScreen(),

        /*Ubicación enfermedades */
        "/list_form_u_e_screen": (BuildContext context) =>
            const ListFormUbicacionEnfermedadesScreen(),
        "/add_form_u_e_screen": (BuildContext context) =>
            const AddFormUbicacionEnfermedadesScreen(),
        "/edit_form_u_e_screen": (BuildContext context) =>
            const EditFormUbicacionEnfermedadesScreen(),

        /*presencia plagas */
        "/list_form_p_p_screen": (BuildContext context) =>
            const ListFormPresenciaPlagasScreen(),
        "/add_form_p_p_screen": (BuildContext context) =>
            const AddFormPresenciaPlagasScreen(),
        "/edit_form_p_p_screen": (BuildContext context) =>
            const EditFormPresenciaPlagasScreen(),

        /*problemas fisicos */
        "/list_form_p_f_screen": (BuildContext context) =>
            const ListFormProblemasFisicosScreen(),
        "/add_form_p_f_screen": (BuildContext context) =>
            const AddFormProblemasFisicosScreen(),
        "/edit_form_p_f_screen": (BuildContext context) =>
            const EditFormProblemasFisicosScreen(),

        /*Acciones Recomendadas */
        "/list_form_a_r_screen": (BuildContext context) =>
            const ListFormAccionesRecomendadasScreen(),
        "/add_form_a_r_screen": (BuildContext context) =>
            const AddFormAccionesRecomendadasScreen(),
        "/edit_form_a_r_screen": (BuildContext context) =>
            const EditFormAccionesRecomendadasScreen(),

        /*Estado Fitosanitario */
        "/list_form_e_f_screen": (BuildContext context) =>
            const ListFormEstadoFitosanitarioScreen(),
        "/add_form_e_f_screen": (BuildContext context) =>
            const AddFormEstadoFitosanitarioScreen(),
        "/edit_form_e_f_screen": (BuildContext context) =>
            const EditFormEstadoFitosanitarioScreen(),

        /*Riesgos Potenciales */
        "/list_form_r_p_screen": (BuildContext context) =>
            const ListFormRiesgosPotencialesScreen(),
        "/add_form_r_p_screen": (BuildContext context) =>
            const AddFormRiesgosPotencialesScreen(),
        "/edit_form_r_p_screen": (BuildContext context) =>
            const EditFormRiesgosPotencialesScreen(),

        /*Arboles */
        "/add_form_a_screen": (BuildContext context) =>
            const AddFormArbolesScreen(),
        "/edit_form_a_screen": (BuildContext context) =>
            const EditFormArbolesScreen(),
        "/verid_form_a_screen": (BuildContext context) =>
            const VerIdFormArbolesScreen(),

        /* Inconveniente Arbol */
        "/add_form_i_a_screen": (BuildContext context) =>
            const AddFromInconvenientesArbolesScreen(),
        "/verid_form_i_a_screen": (BuildContext context) =>
            const VerIdFromInconvenientesArbolesScreen(),

        /*Codigo QR */
        "/crear_codigo_qr_screen": (BuildContext context) =>
            const CrearCodigoQrScreen(),

        /*Codigo geo ubicacion */
        "/list_form_g_u_a_screen": (BuildContext context) =>
            const ListFormGeoUbicacionArbolScreen(),
        "/verid_form_g_u_a_screen": (BuildContext context) =>
            const VerIdFormGeoUbicacionArbolScreen(),
      },
    );
  }
}
