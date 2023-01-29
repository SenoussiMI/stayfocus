class Program {
  final int? id;
  final String name;

  Program({this.id, required this.name});


  factory Program.fromMap(Map<String, dynamic> json) => new Program(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}