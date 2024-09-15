import 'package:digiwallet/screens/home.dart';
import 'package:digiwallet/screens/login.dart';
import 'package:digiwallet/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  registration() async {
    // Check if the password and input fields are not empty
    if (password.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        mailcontroller.text.isNotEmpty) {
      try {
        // Create a user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Check if the widget is still mounted before showing SnackBar or navigating
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          )));

          // Navigate to the Home screen and remove the current screen from the navigation stack
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMessage;

          // Handle different types of FirebaseAuthException errors
          switch (e.code) {
            case 'weak-password':
              errorMessage = "Password Provided is too Weak";
              break;
            case "email-already-in-use":
              errorMessage = "Account Already exists";
              break;
            default:
              errorMessage = "An unexpected error occurred";
          }

          // Show an error message using SnackBar
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                errorMessage,
                style: TextStyle(fontSize: 18.0),
              )));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "An unexpected error occurred",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB7D1EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/signup.jpg",
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                            controller: namecontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf), fontSize: 18.0)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            controller: mailcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf), fontSize: 18.0)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf), fontSize: 18.0)),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = mailcontroller.text;
                                name = namecontroller.text;
                                password = passwordcontroller.text;
                              });
                            }
                            registration();
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF273671),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500),
                              ))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "or LogIn with",
                  style: TextStyle(
                      color: Color(0xFF273671),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AuthMethods().signInWithGoogle(context);
                      },
                      child: Image.asset(
                        "assets/images/google.png",
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Image.asset(
                      "assets/images/apple1.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(
                            color: Color(0xFF8c8e98),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                            color: Color(0xFF273671),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
