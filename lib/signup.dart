import 'package:askAlution/animation/FadeAnimation.dart';
import 'package:askAlution/helper/helperfunctions.dart';
import 'package:askAlution/login.dart';
import 'package:askAlution/main.dart';
import 'package:askAlution/questions.dart';
import 'package:askAlution/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _showPassword = false;

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();


  final formKey = GlobalKey<FormState>();


  TextEditingController usernameTextEditingController = new  TextEditingController();
  TextEditingController emaileTextEditingController = new  TextEditingController();
  TextEditingController passwordTextEditingController = new  TextEditingController();


    loadIng() {
    Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  afterValidation() {
    if (formKey.currentState.validate()) {

      Map<String, String> userInfoMap = {
        "username" : usernameTextEditingController.text,
        "email" : emaileTextEditingController.text
      };

      // to save details written in register formfields
      

      setState(() {
        isLoading = true;
      });


      authMethods.signUpWithEmailAndPassword(emaileTextEditingController.text, passwordTextEditingController.text).then((val) {


        // databaseMethods.uploadUserInfo(userInfoMap);


        HelperFunctions.saveUserEmailSharedPreference(emaileTextEditingController.text);
        HelperFunctions.saveUserLoggedInSharedPreference(true);


        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Questions())
        );
      });
    }
  }




  Future<bool> _onGoogleBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do you want to exit."),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("No"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading ? loadIng() : Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "SignUp",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Create an account, It's free",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: formKey,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //for email

                              // FadeAnimation(
                              //   1.25,
                              //   Text(
                              //     "Username",
                              //     style: TextStyle(
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.w400,
                              //         color: Colors.black87),
                              //   ),
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              FadeAnimation(
                                1.25,
                                TextFormField(
                                  validator: (val) {
                                return val.isEmpty || val.length < 4 ? "Please Provide Username" : null;
                              },
                              controller: usernameTextEditingController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400])),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400])),
                                            hintText: "Username"
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              //for password
                              // FadeAnimation(
                              //   1.3,
                              //   Text(
                              //     "Email",
                              //     style: TextStyle(
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.w400,
                              //         color: Colors.black87),
                              //   ),
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              FadeAnimation(
                                1.3,
                                TextFormField(
                                  //obscureText: true,
                                  validator: (val) {
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) && val.isNotEmpty ? null : "Enter correct email";
                              },
                              controller: emaileTextEditingController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400])),
                                            border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400])),
                                            hintText: "Email",
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: 20,
                              ),

                              //for Confirmation
                              // FadeAnimation(
                              //   1.3,
                              //   Text(
                              //     "Password",
                              //     style: TextStyle(
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.w400,
                              //         color: Colors.black87),
                              //   ),
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              FadeAnimation(
                                1.3,
                                TextFormField(
                                  //obscureText: true,
                                  validator: (val) {
                                  return val.length > 6 ? null : "Please Provide aStrong Password";
                                },
                                controller: passwordTextEditingController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400])),
                                            hintText: "Password",
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[400])),
                                  ),
                                  obscureText: !_showPassword,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                  FadeAnimation(
                      1.4,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {},
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: GestureDetector(
                              onTap: () {
                                afterValidation();
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 7.0),
                  FadeAnimation(
                    1.45,
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Color(0xFFD9D9D9),
                            height: 3.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Text(
                          "OR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFFD9D9D9),
                            height: 3.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeAnimation(
                    1.45,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.5,
                              color: Colors.greenAccent,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/facebook.svg",
                            height: 10.0,
                            width: 10.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.5, color: Colors.greenAccent),
                            shape: BoxShape.circle,
                          ),
                          child: WillPopScope(
                            onWillPop: _onGoogleBackPressed,
                            child: GestureDetector(
                              onTap: () {
                                authMethods.googleSignUp().whenComplete(() =>
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => Questions()),
                                ),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/icons/google-plus.svg",
                                height: 10.0,
                                width: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account?"),
                          GestureDetector(
                            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
