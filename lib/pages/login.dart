import 'package:proje/CutomAppBar.dart';
import 'package:proje/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:proje/service/auth.dart';
import 'package:proje/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();

  var _authService = Auth();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CutomAppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Image.network(
                      "https://media.giphy.com/media/9Pmf3QJiDHwyftez6i/giphy-downsized-large.gif"),
                  width: 175,
                  height: 175,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _emailControl,
                  obscureText: false,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _passControl,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Parola",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    _authService
                        .signIn(_emailControl.text, _passControl.text)
                        .then((value) {
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: _loginButton(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    _authService.signInAnonymously().then((value) {
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: _singInAnonymously(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _registerButton()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromARGB(255, 142, 113, 148),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => KayitOl()));
        },
        child: Text(
          "Kayıt ol",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontStyle: FontStyle.normal, fontSize: 18),
        ),
      ),
    );
  }

  Widget _singInAnonymously() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(255, 166, 42, 170), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            "Anonim Olarak Giriş Yap",
            style: TextStyle(
              color: Color.fromARGB(255, 166, 42, 170),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(255, 166, 42, 170), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            "Giriş yap",
            style: TextStyle(
              color: Color.fromARGB(255, 166, 42, 170),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
