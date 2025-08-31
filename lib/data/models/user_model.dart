import 'dart:convert';

class UserModel {
  final String id;
  final String username;
  final String name;
  final double balance;
  final List<Map<String, dynamic>> transactions;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.balance,
    required this.transactions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((t) => Map<String, dynamic>.from(t))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'balance': balance,
      'transactions': transactions,
    };
  }

  static List<UserModel> listFromJson(String str) {
    final data = json.decode(str) as List<dynamic>;
    return data.map((e) => UserModel.fromJson(e)).toList();
  }

  static String listToJson(List<UserModel> users) {
    final data = users.map((e) => e.toJson()).toList();
    return json.encode(data);
  }
}
