import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import '../../model/user_model.dart';
import '../../shared/style/constants.dart';
import 'login_screen.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  Future save() async {
    var url = Uri.parse('http://localhost:5000/auth/register');
    /*var res = await http.post(url, headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    },
        body: <String, String>{
      'email': user.email,
      'password': user.password
    });
    print(res.body);*/
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  UserModel user = UserModel(username: "",token: "" );
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                IconButton(
                  icon: const Icon(Iconsax.arrow_left_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 31.h),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Register Account",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: const Color(0xFF1A1D1E)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10),
                  child: Text(
                    "Fill your details ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: secondaryColor),
                  ),
                ),
                SizedBox(
                  height: 54.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) {
                      user.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email id as "abc@Example.com"';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Iconsax.sms,
                        color: secondaryColor,
                      ),
                      hintText: 'Email Address',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white)),
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: secondaryColor),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red)),
                      errorStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.token),
                    onChanged: (value) {
                      user.token = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (value.length < 6) {
                        return "Password should be atleast 6 characters";
                      } else if (value.length > 15) {
                        return "Password should not be greater than 15 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Iconsax.lock,
                        color: secondaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color:
                              _passwordVisible ? Colors.blue : secondaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white)),
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: secondaryColor),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red)),
                      errorStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Container(
                    height: 50.h,
                    width: 400,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(buttonColor)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            save();
                          } else {
                            print("not ok");
                          }
                        },
                        child: Text(
                          "SIGN UP",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account? ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: secondaryColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Log In",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
