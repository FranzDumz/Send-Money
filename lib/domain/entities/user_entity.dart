class UserEntity {
  final String id;
  final String username;
  final String name;
  final double balance;
  final List<Map<String, dynamic>> transactions; // ✅ fix here

  UserEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.balance,
    required this.transactions,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      balance: (json['balance'] as num).toDouble(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((t) => Map<String, dynamic>.from(t))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "name": name,
      "balance": balance,
      "transactions": transactions,
    };
  }

  UserEntity copyWith({
    String? id,
    String? username,
    String? name,
    double? balance,
    List<Map<String, dynamic>>? transactions,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}
