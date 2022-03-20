class Dispositivo {
  int? id_d;
  String? nombre_d;
  String? ip_d;
  String? mac_d;
  String? inicio_sesion_d;
  String? fin_sesioin_d;
  String? estado_sesion_d;
  int? id_usuario;

  Dispositivo(this.nombre_d, this.ip_d, this.mac_d, this.inicio_sesion_d,
      this.fin_sesioin_d, this.estado_sesion_d, this.id_usuario);

  int? get getId_d {
    return id_d;
  }

  void setId_d(int id) {
    id_d = id;
  }

  String? get getNombre_d {
    return nombre_d;
  }

  void setNombre_d(String nombre) {
    nombre_d = nombre;
  }

  String? get getIp_d {
    return ip_d;
  }

  void setIp_d(String ip) {
    ip_d = ip;
  }

  String? get getMac_d {
    return mac_d;
  }

  void setMac_d(String mac) {
    mac_d = mac;
  }

  String? get getInicio_sesion_d {
    return inicio_sesion_d;
  }

  void setFoto_u(String inicio_sesion) {
    inicio_sesion_d = inicio_sesion;
  }

  String? get getFin_sesioin_d {
    return fin_sesioin_d;
  }

  void setFin_sesioin_d(String fin_sesioin) {
    fin_sesioin_d = fin_sesioin;
  }

  String? get getEstado_sesion_d {
    return estado_sesion_d;
  }

  void setEstado_sesion_d(String estado_sesion) {
    estado_sesion_d = estado_sesion;
  }

  int? get getId_usuario {
    return id_usuario;
  }

  void setId_usuario(int id_usu) {
    id_usuario = id_usu;
  }
}
