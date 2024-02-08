import 'package:app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
        builder: (context, user, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text('Login')),
            body: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 32),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email', suffixText: '@sggscc.ac.in'),
                        validator: (value) {
                          if (value != null &&
                              value.endsWith('@sggscc.ac.in')) {
                            return null;
                          }
                          return "Invalid Email";
                        },
                        onSaved: (newValue) => {email = newValue.toString()},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value != null &&
                                  (value.length >= 8 && value.length <= 16)) {
                                return null;
                              }
                              return "Password Length should be 8-16 characters";
                            },
                            onSaved: (newValue) =>
                                {password = newValue.toString()})),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Don't have an account? Register"),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            user.login(email, password);
                          }
                        },
                        child: Text('Login'))
                  ],
                ))));
  }
}
