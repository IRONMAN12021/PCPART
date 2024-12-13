import '../models/user.dart';

class Authentication {
  static List<User> users = [];

  static User? loggedInUser;

  static bool login(String email, String password) {
    for (var user in users) {
      if (user.email == email && user.password == password) {
        loggedInUser = user;
        return true;
      }
    }
    return false;
  }

  static void signup(User user) {
    users.add(user);
  }
}
