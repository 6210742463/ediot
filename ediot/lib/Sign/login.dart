import 'package:ediot/Sign/signup.dart';
import 'package:ediot/admin/sidebar.dart';
import 'package:ediot/model/member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Member member = Member();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                child: Form(
                    key: formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              "images/ediot.png",
                              width: 200,
                              height: 200,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 25, 50, 0),
                              child: Center(
                                child: Text(
                                  "Welcome to Ediot",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Lalezar',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue[900]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                              child: Center(
                                child: Text(
                                  "Sign in to continue",
                                  style: TextStyle(
                                      fontFamily: 'Lalezar',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey[300]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "Email"),
                                  EmailValidator(
                                      errorText: "Email format is incorrect")
                                ]),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String? email) {
                                  member.email = email!;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(labelText: "Email"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                              child: TextFormField(
                                validator: RequiredValidator(
                                    errorText: "Please enter your password"),
                                obscureText: true,
                                onSaved: (String? password) {
                                  member.password = password!;
                                },
                                textAlign: TextAlign.center,
                                decoration:
                                    InputDecoration(labelText: "Password"),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(60, 25, 60, 0),
                                child: ElevatedButton(
                                    child: Text("SIGN IN"),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: BorderSide(
                                                  color: Colors.lightGreen,
                                                )))),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: member.email,
                                                  password: member.password)
                                              .then((value) {
                                            formKey.currentState!.reset();
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SideBar();
                                            }));
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.message!,
                                              gravity: ToastGravity.CENTER);
                                        }
                                      }
                                    }),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUp();
                                  }));
                                },
                                child: Text(
                                  "SIGN UP FOR AN ACCOUNT",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lalezar',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey[300]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
