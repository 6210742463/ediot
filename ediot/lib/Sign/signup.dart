import 'package:ediot/Sign/login.dart';
import 'package:ediot/model/member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  Member member = Member();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  var pass;
  var repass;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/10.jpg"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        'Welcome',
                                        style: TextStyle(
                                          fontSize: 54,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 3
                                            ..color = Colors.white10,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        'Welcome',
                                        style: TextStyle(
                                          fontSize: 54,
                                          color: Colors.lightBlue[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                    child: Container(
                                        height: 400,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        decoration: BoxDecoration(
                                          color: Colors.cyan[900]!
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: Column(children: [
                                          Container(
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    45, 30, 45, 0),
                                                child: TextFormField(
                                                    cursorColor: Colors.white,
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              "Please enter your email"),
                                                      EmailValidator(
                                                          errorText:
                                                              "Email format is incorrect")
                                                    ]),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    onSaved: (String? email) {
                                                      member.email = email!;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      labelText: 'Email',
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      border: new OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                    ))),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  45, 15, 45, 0),
                                              child: TextFormField(
                                                cursorColor: Colors.white,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white),
                                                validator: RequiredValidator(
                                                    errorText:
                                                        "Enter your password"),
                                                onSaved: (String? password) {
                                                  pass = password;
                                                },
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    labelText: 'password',
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    fillColor: Colors.white,
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    )),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  45, 15, 45, 0),
                                              child: TextFormField(
                                                cursorColor: Colors.white,
                                                validator: RequiredValidator(
                                                    errorText:
                                                        "Enter password again"),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white),
                                                obscureText: true,
                                                onSaved: (String? password) {
                                                  if (pass == password) {
                                                    member.password = password!;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    labelText:
                                                        'confirm password',
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    )),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  45, 15, 45, 0),
                                              child: Center(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.cyan[900],
                                                  ),
                                                  child: Text("Sign up"),
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      formKey.currentState!
                                                          .save();
                                                      try {
                                                        await FirebaseAuth
                                                            .instance
                                                            .createUserWithEmailAndPassword(
                                                                email: member
                                                                    .email,
                                                                password: member
                                                                    .password)
                                                            .then((value) {
                                                          formKey.currentState!
                                                              .reset();
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return LoginPage();
                                                          }));
                                                        });
                                                      } on FirebaseAuthException catch (e) {
                                                        String message;
                                                        if (e.code ==
                                                            'email-already-in-use') {
                                                          message =
                                                              "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                                                        } else if (e.code ==
                                                            'weak-password') {
                                                          message =
                                                              "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                                        } else {
                                                          message = e.message!;
                                                        }
                                                        Fluttertoast.showToast(
                                                            msg: message,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                        ])))
                              ],
                            ),
                          ),
                        ),
                      ],
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
