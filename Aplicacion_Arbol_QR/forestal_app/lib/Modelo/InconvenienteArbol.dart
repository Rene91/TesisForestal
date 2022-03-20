class InconvenienteArbol {
  int? id_ia;
  int? id_arbol;
  int? id_estado_fitosanitario;
  int? id_presenacia_enfermedades;
  int? id_ubicacion_enfermedades;
  int? id_presencia_plagas;
  int? id_problema_fisico;
  int? id_riesgos_potenciales;
  int? id_acciones_recomendadas;
  String? fecha_ia;
  String? estado_ia;
  int? id_usuario;
  InconvenienteArbol(
      this.id_ia,
      this.id_arbol,
      this.id_estado_fitosanitario,
      this.id_presenacia_enfermedades,
      this.id_ubicacion_enfermedades,
      this.id_presencia_plagas,
      this.id_problema_fisico,
      this.id_riesgos_potenciales,
      this.id_acciones_recomendadas,
      this.fecha_ia,
      this.estado_ia,
      this.id_usuario);

  int? get getId_usuario {
    return id_usuario;
  }

  void setId_usuario(int id) {
    id_usuario = id;
  }



  int? get getId_ia {
    return id_ia;
  }

  void setId_ia(int id) {
    id_ia = id;
  }



  int? get getId_a {
    return id_arbol;
  }

  void setId_a(int id) {
    id_arbol = id;
  }



 int? get getId_ef {
    return id_estado_fitosanitario;
  }

  void setId_ef(int id) {
    id_estado_fitosanitario = id;
  }




  int? get getId_pe {
    return id_presenacia_enfermedades;
  }

  void setId_pe(int id) {
    id_presenacia_enfermedades = id;
  }




  int? get getId_ue {
    return id_ubicacion_enfermedades;
  }

  void setId_ue(int id) {
    id_ubicacion_enfermedades = id;
  }




  int? get getId_pp {
    return id_presencia_plagas;
  }

  void setId_pp(int id) {
    id_presencia_plagas = id;
  }




  int? get getId_pf {
    return id_problema_fisico;
  }

  void setId_pf(int id) {
    id_problema_fisico = id;
  }




  int? get getId_rp {
    return id_riesgos_potenciales;
  }

  void setId_rp(int id) {
    id_riesgos_potenciales = id;
  }




  int? get getId_ar {
    return id_acciones_recomendadas;
  }

  void setId_ar(int id) {
    id_acciones_recomendadas = id;
  }




  String? get getFecha_ia {
    return fecha_ia;
  }

  void setFecha_ia(String dato) {
    fecha_ia = dato;
  }

  String? get getEstado_ia {
    return estado_ia;
  }

  void setEstado_ia(String foto) {
    estado_ia = foto;
  }
}
