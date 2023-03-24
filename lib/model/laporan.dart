class Laporan {
  String? nik;
  String? uid;
  String? tempat;
  String? jenis;
  String? tanggal;
  String? isi;
  String? foto;
  String? status;

  Laporan({
    this.nik,
    this.uid,
    this.tempat,
    this.jenis,
    this.tanggal,
    this.isi,
    this.foto,
    this.status,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      nik: json['nik'],
      uid: json['uid'],
      tempat: json['tempat'],
      jenis: json['jenis'],
      tanggal: json['tanggal'],
      isi: json['isi'],
      foto: json['foto'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'uid': uid,
      'tempat': tempat,
      'jenis': jenis,
      'tanggal': tanggal,
      'isi': isi,
      'foto': foto,
      'status': status,
    };
  }

  Laporan copyWith({
    String? nik,
    String? uid,
    String? tempat,
    String? jenis,
    String? tanggal,
    String? isi,
    String? foto,
    String? status,
  }) {
    return Laporan(
      nik: nik ?? this.nik,
      uid: uid ?? this.uid,
      tempat: tempat ?? this.tempat,
      jenis: jenis ?? this.jenis,
      tanggal: tanggal ?? this.tanggal,
      isi: isi ?? this.isi,
      foto: foto ?? this.foto,
      status: status ?? this.status,
    );
  }
}
