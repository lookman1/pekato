class Users {
  String? uid;
  String? nama;
  String? nik;
  String? email;
  String? alamat;
  String? telp;
  String? role;

  Users({
    this.uid,
    this.nama,
    this.nik,
    this.email,
    this.alamat,
    this.telp,
    this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      nama: json['nama'],
      nik: json['nik'],
      email: json['email'],
      alamat: json['alamat'],
      telp: json['telp'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nama': nama,
      'nik': nik,
      'email': email,
      'alamat': alamat,
      'telp': telp,
      'role': role,
    };
  }

  Users copyWith({
    String? uid,
    String? nama,
    String? nik,
    String? email,
    String? alamat,
    String? telp,
    String? role,
  }) {
    return Users(
      uid: uid ?? this.uid,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      telp: telp ?? this.telp,
      role: role ?? this.role,
    );
  }
}
