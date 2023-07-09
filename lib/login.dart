import 'package:flutter/material.dart';

import 'package:complaint/complaint.dart';
import 'package:complaint/home.dart';

import 'package:complaint/authentication.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height, width;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PERBADANAN PR1MA MALAYSIA',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            Column(
              children: [
                SizedBox(height: 50.0),
                Image.asset(
                  'images/pr1ma.png',
                  scale: 2,
                ),
                SizedBox(height: 25.0),
              ],
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              //Stateful Widget HERE
              child: LoginForm(),
            ),
          ],
        ),
        // bottomNavigationBar: Container(
        //   height: 80.0,
        //   child: BottomAppBar(
        //     color: Colors.indigo[900],
        //     child: Padding(
        //       padding: const EdgeInsets.all(20.0),
        //       child: Text(
        //         'Copyright by PR1MA 2023',
        //         style: TextStyle(
        //           fontSize: 15.0,
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //     elevation: 40.0,
        //   ),
        // ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            // initialValue: 'Input text',
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
          ),
          SizedBox(
            height: 20.0,
          ),

          // password
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            obscureText: _obscureText,
            onSaved: (val) {
              password = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),

          SizedBox(height: 70.0),

          SizedBox(
            height: 55.0,
            width: 190.0,
            child: ElevatedButton(
              onPressed: () {
                // Respond to button press

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthenticationHelper()
                      .signIn(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CRUDEoperation(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
