class ProblemasFisicos {
  int? id_pf;
  String? descripcion_pf;
  String? estado_pf;

  ProblemasFisicos(this.id_pf, this.descripcion_pf, this.estado_pf);

  int? get getId_pf {
    return id_pf;
  }

  void setId_pf(int id) {
    id_pf = id;
  }

  String? get getDescripcion_pf {
    return descripcion_pf;
  }

  void setDescripcion_pf(String descripcion) {
    descripcion_pf = descripcion;
  }

  String? get getEstado_pf {
    return estado_pf;
  }

  void setEstado_pf(String estado) {
    estado_pf = estado;
  }
}
