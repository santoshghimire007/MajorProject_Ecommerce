class LoginValidationModel {
  String username;
  String password;

  LoginValidationModel({
    required this.username,
    required this.password,
  });

  bool validateLoginDetails() {
    if (username == 'admin' && password == 'admin') {
      return true;
    }

    return false;
  }
}
