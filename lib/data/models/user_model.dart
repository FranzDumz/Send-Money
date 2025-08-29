import 'dart:convert';

class LoginModel {
  final String id;
  final String username;
  final String password;

  LoginModel({
    required this.id,
    required this.username,
    required this.password,
  });


  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }


  static List<LoginModel> listFromJson(String str) {
    final data = json.decode(str) as List<dynamic>;
    return data.map((e) => LoginModel.fromJson(e)).toList();
  }


  static String listToJson(List<LoginModel> users) {
    final data = users.map((e) => e.toJson()).toList();
    return json.encode(data);
  }
}
