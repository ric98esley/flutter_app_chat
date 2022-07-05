class User {
  bool online;
  String email;
  String name;
  String uid;

  User(
      {this.online = false,
      this.email = 'no-email',
      this.name = 'no-name',
      this.uid = 'no-uid'});

  factory User.fromMap(Map<String, dynamic> obj) => User(
      uid: obj.containsKey('id') ? obj['id'] : 'no-id',
      name: obj.containsKey('name') ? obj['name'] : 'no-name',
      email: obj.containsKey('email') ? obj['email'] : 'no-email',
      online: obj.containsKey('online') ? obj['online'] : false);
}
