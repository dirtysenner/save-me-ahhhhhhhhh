class Manager {
  List<String> Usernames = ['Sen'];
  List<String> Passwords = ['Shaw'];
  List<double> horoscope = [0]; // you had Leo before, this wasn't a class so I changed to 0.
  bool check = true;

  Manager();

  bool accountCheck(user, pass) {
    for (int I = 0; I < Usernames.length; I++) {
      if (Usernames[I] == user && Passwords[I] == pass) {
        return true;
      }
    }
    return false;
  }

  void register(newUser, newPass, newSign) {
    for (int I = 0; I < Usernames.length; I++) {
      if (Usernames[I] == newUser && Passwords[I] == newPass) {
        check = false;
      }
    }
    if (check == true) {
      Usernames.add(newUser);
      Passwords.add(newPass);
      horoscope.add(newSign);
      print(Usernames);
      print(Passwords);
      print(horoscope);
    }
  }

  int getNumber(user, pass) {
    for (int I = 0; I < Usernames.length; I++) {
      if (Usernames[I] == user && Passwords[I] == pass) {
        return I;
      }
    }
    return 0;
  }

  String getUser(accountNumber) {
    return (Usernames[accountNumber]);
  }

  String getPass(accountNumber) {
    return (Passwords[accountNumber]);
  }

  double getCash(accountNumber) {
    return (horoscope[accountNumber]);
  }
}