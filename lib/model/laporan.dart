class Laporan {
  String? nik;
  String? nama;
  String? uid;
  String? idlaporan;
  String? tempat;
  String? jenis;
  String? tanggal;
  String? isi;
  String? foto;
  String? tanggapan;
  String? status;

  Laporan({
    this.nik,
    this.nama,
    this.uid,
    this.idlaporan,
    this.tempat,
    this.jenis,
    this.tanggal,
    this.isi,
    this.foto,
    this.tanggapan,
    this.status,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      nik: json['nik'],
      nama: json['nama'],
      uid: json['uid'],
      idlaporan: json['idlaporan'],
      tempat: json['tempat'],
      jenis: json['jenis'],
      tanggal: json['tanggal'],
      isi: json['isi'],
      foto: json['foto'],
      tanggapan: json['tanggapan'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'nama': nama,
      'uid': uid,
      'idlaporan': idlaporan,
      'tempat': tempat,
      'jenis': jenis,
      'tanggal': tanggal,
      'isi': isi,
      'foto': foto,
      'tanggapan': tanggapan,
      'status': status,
    };
  }

  Laporan copyWith({
    String? nik,
    String? nama,
    String? uid,
    String? idlaporan,
    String? tempat,
    String? jenis,
    String? tanggal,
    String? isi,
    String? foto,
    String? tanggapan,
    String? status,
  }) {
    return Laporan(
      nik: nik ?? this.nik,
      nama: nama ?? this.nama,
      uid: uid ?? this.uid,
      idlaporan: idlaporan ?? this.idlaporan,
      tempat: tempat ?? this.tempat,
      jenis: jenis ?? this.jenis,
      tanggal: tanggal ?? this.tanggal,
      isi: isi ?? this.isi,
      foto: foto ?? this.foto,
      tanggapan: tanggapan ?? this.tanggapan,
      status: status ?? this.status,
    );
  }
}
