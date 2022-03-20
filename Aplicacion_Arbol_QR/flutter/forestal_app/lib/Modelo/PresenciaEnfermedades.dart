class PresenciaEnfermedades {
  int? id_pe;
  String? descripcion_pe;
  String? estado_pe;

  PresenciaEnfermedades(this.id_pe, this.descripcion_pe, this.estado_pe);

  int? get getId_pe {
    return id_pe;
  }

  void setId_pe(int id) {
    id_pe = id;
  }

  String? get getDescripcion_pe {
    return descripcion_pe;
  }

  void setDescripcion_pe(String descripcion) {
    descripcion_pe = descripcion;
  }

  String? get getEstado_pe {
    return estado_pe;
  }

  void setEstado_pe(String estado) {
    estado_pe = estado;
  }
}
