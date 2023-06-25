class LoginRequestParams {
  final String username;
  final String password;

  LoginRequestParams(this.username, this.password);

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
