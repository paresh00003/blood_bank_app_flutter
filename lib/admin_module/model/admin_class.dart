class Donor {
  final int? id;
  final String name;
  final String bloodGroup;

  Donor({this.id, required this.name, required this.bloodGroup});

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      name: json['name'],
      bloodGroup: json['blood_group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'blood_group': bloodGroup,
    };
  }
}
