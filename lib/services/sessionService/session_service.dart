import 'package:ecommerce_major_project/models/user_model.dart';

class SessionService {
  static UserModel? userData;

  static setUserData(UserModel data) {
    userData = data;
  }

  static clearUserData() {
    userData = null;
  }
}
