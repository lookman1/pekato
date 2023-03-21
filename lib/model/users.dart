class Users {
  String? uid;
  String? nama;
  String? email;
  String? level;
  String? telp;
  String? alamat;

  Users({
    this.uid,
    this.nama,
    this.email,
    this.level,
    this.telp,
    this.alamat,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      nama: json['nama'],
      email: json['email'],
      alamat: json['alamat'],
      level: json['uid'],
      telp: json['telp'],
    );
  }

  Users copyWith({
    String? uid,
    String? nama,
    String? email,
    String? level,
    String? telp,
    String? alamat,
  }) {
    return Users(
      uid: uid ?? this.uid,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      level: alamat ?? this.alamat,
      telp: telp ?? this.telp,
      alamat: alamat ?? this.alamat,
    );
  }
}
