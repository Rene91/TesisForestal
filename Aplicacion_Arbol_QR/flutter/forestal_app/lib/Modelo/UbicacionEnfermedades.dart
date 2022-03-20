class UbicacionEnfermedades {
  int? id_ue;
  String? descripcion_ue;
  String? estado_ue;

  UbicacionEnfermedades(this.id_ue, this.descripcion_ue, this.estado_ue);

  int? get getId_ue {
    return id_ue;
  }

  void setId_ue(int id) {
    id_ue = id;
  }

  String? get getDescripcion_ue {
    return descripcion_ue;
  }

  void setDescripcion_ue(String descripcion) {
    descripcion_ue = descripcion;
  }

  String? get getEstado_ue {
    return estado_ue;
  }

  void setEstado_ue(String estado) {
    estado_ue = estado;
  }
}
