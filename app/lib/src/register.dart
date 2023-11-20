import 'package:app/src/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Map<String, String> courses = {
  "BSC": "B.Sc. (Hons) Computer Science",
  "BCH": "B.Com (Hons)",
  "BCP": "B.Com (Prog)",
  "BPA": "B.A. (Hons) Punjabi",
  "BAE": "B.A. (Hons) Economics",
  "BBE": "Bachelor of Business Economics",
  "BMS": "Bachelor of Management Studies"
};

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              SizedBox(
                height: 120,
              ),
              RegisterForm()
            ],
          )),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = courses.keys.first;
  String apiErrorMessage = '';
  Map<String, String?> formValues = {
    "name": "",
    "email": "",
    "course": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (((context, user, child) => Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    formValues["name"] = value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    formValues["email"] = value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  items: user.courses.keys
                      .map((key) => DropdownMenuItem<String>(
                            value: key,
                            child: Text(courses[key]!),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a course';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      formValues["course"] = newValue;
                    });
                  },
                  onSaved: (value) {
                    formValues["course"] = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length > 16 || value.length < 8) {
                      return 'Password should be of length 8-16';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    formValues["password"] = value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                if (apiErrorMessage.isNotEmpty)
                  Text(
                    apiErrorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 50,
                    width: 150,
                    child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            String msg =
                                await user.checkDetailsRegister(formValues);
                            setState(() {
                              apiErrorMessage = msg;
                            });
                            if (apiErrorMessage.isEmpty) {
                              user.register();
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )))
              ],
            )))));
  }
}
