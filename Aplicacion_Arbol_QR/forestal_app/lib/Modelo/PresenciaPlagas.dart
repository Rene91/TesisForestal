class PresenciaPlagas {
  int? id_pp;
  String? descripcion_pp;
  String? estado_pp;

  PresenciaPlagas(this.id_pp, this.descripcion_pp, this.estado_pp);

  int? get getId_pp {
    return id_pp;
  }

  void setId_pp(int id) {
    id_pp = id;
  }

  String? get getDescripcion_pp {
    return descripcion_pp;
  }

  void setDescripcion_pp(String descripcion) {
    descripcion_pp = descripcion;
  }

  String? get getEstado_pp {
    return estado_pp;
  }

  void setEstado_pp(String estado) {
    estado_pp = estado;
  }
}
