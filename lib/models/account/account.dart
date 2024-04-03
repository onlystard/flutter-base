class Account {
  Account({
    required this.id,
    required this.name,
    required this.alias,
    required this.email,
    this.imageUrl,
    this.emailConfirmed = false,
    this.locked = false,
    this.about,
  });

  final String id;
  final String name;
  final String alias;
  final String email;
  final String? imageUrl;
  final bool emailConfirmed;
  final bool locked;
  final String? about;

  static Account fromMap(Map<String, dynamic> data) {
    return Account(
      id: data['id'],
      name: data['name'],
      alias: data['alias'],
      email: data['email'],
      imageUrl: data['imageUrl'],
      emailConfirmed: data['emailConfirmed'],
      locked: data['locked'],
      about: data['about'],
    );
  }
}
