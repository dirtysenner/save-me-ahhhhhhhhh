import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? normalizeSign(String input) {
  final s = input.trim().toLowerCase();
  const signs = [
    'aries','taurus','gemini','cancer','leo','virgo',
    'libra','scorpio','sagittarius','capricorn','aquarius','pisces'
  ];
  if (!signs.contains(s)) return null;
  return s[0].toUpperCase() + s.substring(1);
}

class StarSignNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  bool setSign(String input) {
    final normalized = normalizeSign(input);
    if (normalized == null) {
      return false;
    }
    state = normalized;
    return true;
  }

  void clear() => state = null;
}

final starSignProvider = NotifierProvider<StarSignNotifier, String?>(StarSignNotifier.new);

const Map<String, String> horoscopeMessages = {
  'Aries': 'It is likely that your breath smells like cheese',
  'Taurus': 'You may find that rocks have become inedible',
  'Gemini': 'Dogs find you attractive',
  'Cancer': 'People die when they are killed',
  'Leo': 'You are cool',
  'Virgo': 'You have rabies',
  'Libra': 'Showering is not a necessity',
  'Scorpio': 'I am calling to ask you about your cars extended warranty',
  'Sagittarius': 'When you get a C on a test a half orphaned Canadian child loses its wings',
  'Capricorn': 'car go vrooom',
  'Aquarius': 'I am writing this at eleven pm on saturday',
  'Pisces': 'To eat carbonara is to become immortal in the eyes of bees',
};

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

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
          return const MyHomePage();
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

Manager name = Manager();

String newUser = '';
String newPass = '';
String newSign = '';

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
                child: const Text('Sign Up'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  String? signError;

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
                width: 220,
                height: 120,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Set Star Sign (e.g., Leo, Aries, Pisces, etc)',
                    errorText: signError,
                  ),
                  onChanged: (text) {
                    newSign = text;
                    final ok = ref.read(starSignProvider.notifier).setSign(text);
                    setState(() {
                      signError = ok
                          ? null
                          : 'Enter a valid sign: Aries, Leo, Taurus, etc.';
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final sign = ref.read(starSignProvider);
                  if (sign == null) {
                    setState(() {
                      signError = 'Please enter a valid zodiac sign.';
                    });
                    return;
                  }
                  name.register(newUser, newPass, sign);
                  context.go('/horoscope');
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

class Horoscope extends ConsumerWidget {
  const Horoscope({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sign = ref.watch(starSignProvider);

    final title = sign == null ? 'No Star Sign Set' : '$sign Horoscope';
    final message = sign == null
        ? 'Couldn’t find your star sign. Sign Up and set it first.'
        : (horoscopeMessages[sign] ??
        'Take a 47.5926621 second nap right now');

    return Scaffold(
      appBar: AppBar(title: const Text('Your Horoscope')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go('/signupPage'),
              child: const Text('Change Star Sign'),
            ),
          ],
        ),
      ),
    );
  }
}
class Manager {
  late List<String> Usernames = <String>['Sen'];
  late List<String> Passwords = <String>['Shaw'];
  List<double> horoscope = [0];
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
  }
}