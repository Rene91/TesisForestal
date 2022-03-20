<?php

namespace Modelo;

class ConexionBD {

    private $con;
    private $datos = array(


        "host" => "localhost",
        "user" => "id18562680_arbol",
        "pass" => "G-arbolqr2022@",
        "db" => "id18562680_arbol_qr_bd"
    );

    public function __construct() {
        try {
            $this->con = new \mysqli($this->datos['host'], $this->datos['user'], $this->datos['pass'], $this->datos['db']);
            $this->con->set_charset('utf8');
//            if ($this->con->connect_errno) {
//                $this->CrearBaseDatos();
//                exit();
//            }
        } catch (Exception $exc) {
            
        }
    }

    public function consultaSimple($sql) {
        if ($this->con->query($sql)) {
            return array(
                "respuesta" => "ACCIÓN CORRECTA");
        } else {
            return array(
                "respuesta" => "PROBLEMAS CON INGRESO AL SERVIDOR");
        }
    }

    public function consultaRetorno($sql) {
        $datos = $this->con->query($sql);
        return $datos;
    }

    public function respaldoBD() {
        try {
            date_default_timezone_set('America/Guayaquil'); //SELECCIONAMOS EL HORARIO DEL SERVIDOR

            $fecha = date("Ymd-His"); //OBTENEMOS DIA Y HORA ACTUALES

            $salida_sql = "../respaldosBD/id11332186_forestal_app.sql";

            $executa = "mysqldump --host=localhost --user=id11332186_rene91 --password=R3g2018@rene -R -c  --add-drop-table id11332186_forestal_app > " . $salida_sql;

            system($executa, $error); //EJECUTAMOS EN CONSOLA LA CADENA
            return array(
                "respuesta" => "ACCIÓN CORRECTA");
        } catch (Exception $exc) {
            return array("respuesta" => "PROBLEMAS CON INGRESO AL SERVIDOR");
        }
    }

//    public function CrearBaseDatos() {
//        $this->con = new \mysqli($this->datos['host'], $this->datos['user'], $this->datos['pass']);
//        ////////////  creamos base datos si hay conexion al servidor  ///////////
//        if ($this->con) {
//            $file = file_get_contents("scrip.sql"); //carga el fichero y lo transforma en string
//            $ArraySentencia = explode(";", $file); /// limitador de lectura para cargar en un array de lectura
//            for ($i = 0; $i < (count($ArraySentencia) - 1); $i++) {
//                $this->con->query($ArraySentencia[$i]); //carga la cadenas en el query() de mysqli
//            }
//            unset($file);
//        } else {
//            die("Error de conexión: " . mysqli_connect_error());
//        }
//    }

    public function __destruct() {
        $this->con->close();
    }

}
?>

