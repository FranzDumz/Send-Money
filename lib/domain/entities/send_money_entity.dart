class UserEntity {
  final String id;
  final String username;
  final String name;
  final String password;
  final double balance;
  final List<String> transactions;

  UserEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.password,
    required this.balance,
    required this.transactions,
  });


  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'name': name,
    'password': password,
    'balance': balance,
    'transactions': transactions,
  };


  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json['id'] as String,
    username: json['username'] as String,
    name: json['name'] as String,
    password: json['password'] as String,
    balance: (json['balance'] as num?)?.toDouble() ?? 0,
    transactions: List<String>.from(json['transactions'] ?? []),
  );
}
