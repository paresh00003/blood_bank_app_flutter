class UserRequest {
  final int ?id;
  final int donorId;
  final String name;
  final String bloodGroup;
  final int quantity;

  UserRequest({
     this.id,
    required this.donorId,
    required this.name,
    required this.bloodGroup,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'donor_id': donorId,
      'name': name,
      'blood_group': bloodGroup,
      'quantity': quantity,
    };
  }

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      id: json['id'],
      donorId: json['donor_id'],
      name: json['name'],
      bloodGroup: json['blood_group'],
      quantity: json['quantity'],
    );
  }
}
