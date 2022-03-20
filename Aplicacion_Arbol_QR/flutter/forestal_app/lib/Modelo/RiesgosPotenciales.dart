class RiesgosPotenciales {
  int? id_rp;
  String? descripcion_rp;
  String? estado_rp;

  RiesgosPotenciales(this.id_rp, this.descripcion_rp, this.estado_rp);

  int? get getId_rp {
    return id_rp;
  }

  void setId_rp(int id) {
    id_rp = id;
  }

  String? get getDescripcion_rp {
    return descripcion_rp;
  }

  void setDescripcion_rp(String descripcion) {
    descripcion_rp = descripcion;
  }

  String? get getEstado_rp {
    return estado_rp;
  }

  void setEstado_rp(String estado) {
    estado_rp = estado;
  }
}
