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
}
