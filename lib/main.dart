import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'loginPage.dart';
import 'BankInfo.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: [
        //paths go here only
        GoRoute(
          path: 'bankinfo', //login
          builder: (BuildContext context, GoRouterState state) {
            return const BankInfo();
          },
        ),

        GoRoute(
          name: 'placeholder',
          path: 'placeholder',
          builder: (context, state) => MyHomePage(),
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
String newUser = '';
String newPass = '';
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adino')),
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage("assets/shaw-hornet.gif"),
                fit: BoxFit.cover
          ),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
            Container(
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
                context.go('/bankinfo');
              }
            }, child: Text('login')),
          ],
        ),
      ]
      ),
    ),
    );
  }
}
double cash = 0.0;
double amount = 0.0;
double cash2 = 0.0;
double amount2 = 0.0;
double temp = 0.0;
class BankInfo extends StatefulWidget {
  const BankInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BankInfoState();
  }
}
class _BankInfoState extends State<BankInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Garama')),
        body: Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                  image: AssetImage("assets/shaw-hornet.gif"),
                  fit: BoxFit.cover
              ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('\$$cash'),
                Container(
                  width: 200,
                  height: 100,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'money',
                      ), onChanged: (text2) {
                    setState(() {
                      amount = double.parse(text2);
                    });
                  }
                  ),
                ),
                ElevatedButton(onPressed:() {
                  setState(() {
                    if(cash2 > 0){
                      cash2 = cash2 - amount;
                    } else {
                      cash = cash + amount;
                    }
                  });
                }, child: Text('add moneys'),
                ),
                ElevatedButton(onPressed:() {
                  setState(() {
                    cash = cash - amount;
                  });
                }, child: Text('take moneys'),
                ),],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('\$$cash2'),
                Container(
                  width: 200,
                  height: 100,
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'money',
                      ), onChanged: (text3) {
                    setState(() {
                      amount2 = double.parse(text3);
                    });
                  }
                  ),
                ),
                ElevatedButton(onPressed:() {
                  setState(() {
                    cash2 = amount2 + cash2;
                    cash = amount2 + cash;
                  });
                }, child: Text('loan for moneys'),
                ),
                ElevatedButton(onPressed:() {
                  setState(() {
                    if(cash - cash2 >= 0){
                      temp = cash;
                      cash = cash - cash2;
                      cash2 = cash2 - temp;
                      if(cash2 < 0){
                        cash2 = 0;
                      }
                    }
                  });
                }, child: Text('pay for loans'),
                ),],
            )
        ]
      ),
    ));
  }
}
