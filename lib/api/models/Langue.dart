class Langue {
  int id;
  String lang;
  String code;
  String country;

  Langue({required this.id, required this.lang, required this.code, required this.country});

  factory Langue.fromMap(Map<String, dynamic> map) {
    return Langue(
      id: map['id'],
      lang: map['lang'],
      code: map['code'],
      country: map['country'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lang': lang,
      'code': code,
      'country': country,
    };
  }
}
