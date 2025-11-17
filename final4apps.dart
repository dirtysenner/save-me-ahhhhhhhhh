import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key})
}
  List <String> horoscope = [
    'Leo',
    'Aries',
    'Taurus',
    'Gemini',
    'Libra',
    'Pisces',
    'Capricorn',
    'Aquarius',
    'Cancer',
    'Virgo',
    'Scorpio',
    'Sagittarius'
  ];

  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
class Manager {
  List<String> Usernames = ['Sen'];
  List<String> Passwords = ['Shaw'];
  List<double> horoscope = [Leo];
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

  void register(newUser, newPass) {
    for (int I = 0; I < Usernames.length; I++) {
      if (Usernames[I] == newUser && Passwords[I] == newPass) {
        check = false;
      }
    }
    if (check == true) {
      Usernames.add(newUser);
      Passwords.add(newPass);
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
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(); //login
      },
      routes: [
        //paths go here only
        GoRoute(
          path: 'homepage',
          builder: (BuildContext context, GoRouterState state) {
            return const MyHomePage();
          },
        ),
        GoRoute(
          path: 'horoscope',
          builder: (BuildContext context, GoRouterState state) {
            return const Horoscope();
          },
        ),
        GoRoute(
          path: 'signupPage',
          builder: (BuildContext context, GoRouterState state) {
            return const Signup();
          }
        )
      ],
    ),
  ],
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}
class MySignupPage extends StatefulWidget {
  const MySignupPage({super.key});
  State<StatefulWidget> createState () {
    return _MySignupPageState();
  }
}
class _MySignupPageState extends State<MySignupPage> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
String newUser = '';
String newPass = '';
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ), onChanged: (text){
                    newUser = text;
                  },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 100,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ), onChanged: (text) {
                    newPass = text;
                  }
                  ),
                ),
                ElevatedButton(onPressed: () {
                  if(newUser == 'Hornet' && newPass == 'Shaw') {
                    context.go('/horoscope');
                  }
                }, child: Text('Log In')),
              ],
            ),
          ]
      ),
    );
  }
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<StatefulWidget> createState() {

  }
}

class Horoscope extends StatefulWidget {
  const Horoscope({super.key});

}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Set Username',
                    ), onChanged: (text){
                    newUser = text;
                  },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 100,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Set Password',
                      ), onChanged: (text) {
                    newPass = text;
                  }
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 100,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Set Star Sign',
                      ), onChanged: (text) {
                    newPass = text;
                  }
                  ),
                ),
                ElevatedButton(onPressed: () {
                  if(newUser == 'Hornet' && newPass == 'Shaw') {
                    context.go('/homepage');
                  }
                }, child: Text('Log In')),
              ],
            ),
          ]
      ),
    );
  }