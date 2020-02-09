import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FirebaseAuthTutorial",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailInputControler = TextEditingController();
  final passwordInputControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FirebaseAuthTutorial")),
      body: _layoutBody(),
    );
  }

  Widget _layoutBody() {
    return Center(
      child: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              TextFormField(
                controller: emailInputControler,
                decoration: const InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: "Email"
                )
              ),
              const SizedBox(height: 24.0,),
              TextFormField(
                controller: passwordInputControler,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Password"
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0,),
              Center(
                child: RaisedButton(
                  child: Text("Login"),
                  onPressed: () {
                    var email = emailInputControler.text;
                    // important line
                    email = email.trim();
                    var password = passwordInputControler.text;
                    return _signIn(email, password)
                      .then((AuthResult result) => print(result.user))
                      .catchError((e) => print(e));
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Future<AuthResult> _signIn(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    print("User id is ${result.user.uid}");
    return result;
  }
}

