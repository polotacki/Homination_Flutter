import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homaination_mobile/bloc/cubits/register_cubit/register_cubit.dart';
import 'package:iconsax/iconsax.dart';
import '../../bloc/cubits/login_cubit/login_cubit.dart';
import '../../model/user_model.dart';
import '../../shared/style/constants.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);




  final _formKey = GlobalKey<FormState>();



  UserModel user = UserModel(username: "",token: "" );
   TextEditingController _emailController = TextEditingController();
   TextEditingController _usernameController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();
   TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
    child:BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {

              print("============= Welcome to Homination =============");

              print("Registered Successfully");
              Fluttertoast.showToast(
                msg: "Registered Successfully",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) =>  LoginScreen()));



          } else if (state is RegisterError){
            Fluttertoast.showToast(
              msg: "Username or Email already in use",
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );


          }},
    builder: (context, state) {
    var cubit = context.read<RegisterCubit>();



    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                ),Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _nameController,
                    onChanged: (email) =>
                        context.read<LoginCubit>()
                            .emailChanged(email),
                    validator: (value) {
                      /*                if (value!.isEmpty) {
                          return "* Required";
                        } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return null;
                        } else {
                          return 'Enter valid email id as "abc@Example.com"';
                        }*/
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).nextFocus(),

                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Iconsax.user_tag,
                        color: secondaryColor,
                      ),
                      hintText: 'First Name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.white)),
                      hintStyle:  const TextStyle(fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xFF6A6A6A)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.red)),
                      errorStyle:  const TextStyle(fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _usernameController,
                    onChanged: (email) =>
                        context.read<LoginCubit>()
                            .emailChanged(email),
                    validator: (value) {
                      /*                if (value!.isEmpty) {
                          return "* Required";
                        } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return null;
                        } else {
                          return 'Enter valid email id as "abc@Example.com"';
                        }*/
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).nextFocus(),

                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Iconsax.profile_circle,
                        color: secondaryColor,
                      ),
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.white)),
                      hintStyle:  const TextStyle(fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xFF6A6A6A)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12),
                          borderSide: const BorderSide(
                              color: Colors.red)),
                      errorStyle:  const TextStyle(fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _emailController,
                    onChanged: (value) {
                      cubit.emailChanged(value);
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
                    controller: _passwordController,
                    onChanged: (value) {
                     cubit.passwordChanged(value);
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
                    }, obscureText: !cubit.passwordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Iconsax.lock,
                        color: secondaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          cubit.suffixIcon,
                          color:
                          cubit.suffixColor,
                        ),
                        onPressed: () {
                         cubit.changePasswordVisibility();
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
                            cubit.register(name: _nameController.text, username: _usernameController.text, password: _passwordController.text, email: _emailController.text);
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
    ));}));
  }
}
