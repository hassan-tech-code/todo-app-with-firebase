class UserModel {
  String userId;
  String name;
  String email;
  UserModel({required this.userId, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      userId: docId,
      name: map['name'] ?? 'user',
      email: map['email'] ?? '',
    );
  }
}
