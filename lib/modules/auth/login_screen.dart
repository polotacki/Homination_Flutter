import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:homaination_mobile/layout/home_layout.dart';
import 'package:homaination_mobile/modules/auth/register_screen.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/cubits/login_cubit/login_cubit.dart';
import '../../shared/style/constants.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);


  final _formKey = GlobalKey<FormState>();


  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child:  BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            if(state.loginModel.token !=null){
                              print("============= Welcome to Homination =============");
                              print("name: ${state.loginModel.username}    Token:${state.loginModel.token}" );
                              print("loggedIn Successfully");
                              CacheHelper.saveData(key: "profilePic", value: state.loginModel.profilePic);
                              CacheHelper.saveData(key: "name", value: state.loginModel.name);
                              CacheHelper.saveData(key: "userName", value: state.loginModel.username);
                              CacheHelper.saveData(key: "email", value: state.loginModel.email);
                              CacheHelper.saveData(key: "id", value: state.loginModel.sId);
                              CacheHelper.saveData(key: "Token", value: state.loginModel.token).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const HomeLayout())));
                              print("sharedprefrences :${CacheHelper.getData(key: "Token")}");


                            }
                            } else if (state is LoginError){
                            Fluttertoast.showToast(
                              msg: "Invalid Email or Password",
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );


                          }}


                        ,
                        builder: (context, state) {
                          var cubit = LoginCubit.get(context);
                          return Scaffold(
                              body: SingleChildScrollView(
                              child: Column(

                              children: [

                              Container(
                              alignment: Alignment.center,
                              child: Form(
                              key: _formKey,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 100.h),

                                  const Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "Welcome Back!",
                                      style: TextStyle(fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Color(0xFF1A1D1E)),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 30.0, top: 10),
                                    child: Text(
                                      "Fill your details ",
                                      style:  TextStyle(fontFamily: "Poppins",
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Color(0xFF6A6A6A)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 54.h,
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
                                      keyboardType: TextInputType.emailAddress,
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
                                      controller: _passwordController,
                                      onChanged: (value) {
                                        cubit.passwordChanged(value);
                                      },
                                      validator: (value) {
                                        /* if (value!.isEmpty) {
                          return '* Required';
                        } else if (value.length < 6) {
                          return "incorrect password";
                        }
                        return null;*/
                                      },
                                      obscureText: !cubit.passwordVisible,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Iconsax.lock,
                                          color: secondaryColor,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            cubit.suffixIcon
                                                ,
                                            color:
                                            cubit.suffixColor
                                                ,
                                          ),
                                          onPressed: () {
                                          cubit.changePasswordVisibility();


                                          },
                                        ),
                                        hintText: 'Password',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                12),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                12),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        hintStyle:  const TextStyle(fontFamily: "Poppins",
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            color: secondaryColor),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 20),
                                      child: SizedBox(
                                        height: 54.h,
                                        width: 400,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(12.0)),
                                              ),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  buttonColor)),
                                          onPressed: () {
                                            final isValid = _formKey.currentState!.validate();
                                            if (isValid) {
                                              print(_usernameController.text);
                                              print(_passwordController.text);
                                              cubit.login(
                                                  username: _usernameController.text,
                                                  password: _passwordController.text);
                                            } else {
                                              print("not ok");
                                            }
                                          },
                                          child:const Text(
                                            "LOG IN",
                                            style:  TextStyle(fontFamily: "Poppins",
                                                fontWeight: FontWeight
                                                    .w500,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 20, 16, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          const Text(
                                            "New User? ",
                                            style:  TextStyle(fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: secondaryColor),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                           RegisterScreen()));
                                            },
                                            child: const Text(
                                              "Create Account",
                                              style:  TextStyle(fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              )


    ))])));}

    ));}}