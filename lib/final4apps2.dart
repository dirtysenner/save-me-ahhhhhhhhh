import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'Manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(child: MyApp) as Function({dynamic child}));
}
runApp(ProviderScope(child: MyApp())) {
}
final starSignProvider = StateProvider<String?>((ref) => null);
String? normalizeSign(String input) {
  final s = input.trim().toLowerCase();
  const signs = [
    'aries','taurus','gemini','cancer','leo','virgo',
    'libra','scorpio','sagittarius','capricorn','aquarius','pisces'
  ];
  if (signs.contains(s)) {
    // Capitalize first letter for display
    return s[0].toUpperCase() + s.substring(1);
  }
  return null; // invalid
}
const Map<String, String> horoscopeMessages = {
  'Aries': 'Bold moves pay off—lead with confidence today.',
  'Taurus': 'Steady progress beats sudden leaps. Trust your pace.',
  'Gemini': 'Conversations open doors—ask one more question.',
  'Cancer': 'Nurture your space. Comfort fuels clarity.',
  'Leo': 'Spotlight finds you—share generously, not loudly.',
  'Virgo': 'Small refinements yield big wins. Edit once more.',
  'Libra': 'Balance comes from a clear “no.” Choose wisely.',
  'Scorpio': 'Depth over breadth—focus reveals the answer.',
  'Sagittarius': 'Say yes to a new path—adventure is calling.',
  'Capricorn': 'Discipline compounds. Today’s effort matters.',
  'Aquarius': 'Unorthodox ideas land—dare to ship it.',
  'Pisces': 'Your intuition is data. Listen closely.',
};

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage(); // login
        },
        routes: [
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
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  List<String> horoscope = [
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(); // login
      },
      routes: [
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
          },
        ),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                  onChanged: (text) {
                    newUser = text;
                  },
                ),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  onChanged: (text) {
                    newPass = text;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (name.accountCheck(newUser, newPass)) {
                    context.go('/horoscope');
                  }
                },
                child: const Text('Log In'),
              ),
              TextButton(
                  onPressed: () {
                    context.go('/signupPage');
                  },
                  child: const Text('Sign Up')
              )
            ],
          ),
        ],
      ),
    );
  }
}
Manager name  = new Manager();

String newUser = '';
String newPass = '';
String newSign = '';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}
class _SignupState extends State<Signup> {
  @override
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Set Username',
                  ),
                  onChanged: (text) {
                    newUser = text;
                  },
                ),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Set Password',
                  ),
                  onChanged: (text) {
                    newPass = text;
                  },
                ),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Set Star Sign',
                  ),
                  onChanged: (text) {
                    newSign = text; // leaving logic unchanged
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  (name.register(newUser, newPass, newSign));
                  context.go('/homepage');
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Horoscope extends StatefulWidget {
  const Horoscope({super.key});

  @override
  State<Horoscope> createState() => _HoroscopeState();
}

class _HoroscopeState extends State<Horoscope> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horoscope')),
      body: const Center(
        child: Text("It is advised to not eat bees for the next week"),
      ),
    );
  }
}