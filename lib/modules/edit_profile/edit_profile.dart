import 'dart:io';

import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  File? _profilePicFile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // A simple usage of EditableImage.
  // This method gets called when trying to change an image.
  Future<void> _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _profilePicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              EditableImage(
                // Define the method that will run on
                // the change process of the image.
                onChange: _directUpdateImage,

                // Define the source of the image.
                image: _profilePicFile != null
                    ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                    : Image.asset("assets/images/anonymous.png"),

                // Define the size of EditableImage.
                size: 90.h,

                // Define the Theme of image picker.
                imagePickerTheme: ThemeData(
                  // Define the default brightness and colors.
                  primaryColor: Colors.white,
                  shadowColor: Colors.transparent,
                  colorScheme:
                      const ColorScheme.light(background: Colors.white70),
                  iconTheme: const IconThemeData(color: Colors.black87),

                  // Define the default font family.
                  fontFamily: 'Georgia',
                ),

                // Define the border of the image if needed.
                imageBorder: Border.all(color: Colors.white, width: 2),

                // Define the border of the icon if needed.
                editIconBorder: Border.all(color: Colors.white, width: 2,),
                editIconBackgroundColor: buttonColor,
                editIconColor: Colors.white,
              ),
              const Spacer(flex: 1),
              Text(
                CacheHelper.getData(key: "name") ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Edit Profile",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color(0xFF6A6A6A)),
              ),
              const Spacer(flex: 2),
              const Spacer(),
              _buildAlign("Name"),
              _buildTextField(
                  labelText: CacheHelper.getData(key: "name") ?? "",
                  controller: _nameController),
              const Spacer(),
              _buildAlign("Your Email"),
              _buildTextField(
                  labelText: CacheHelper.getData(key: "email") ?? "",
                  controller: _emailController),
              const Spacer(),
              _buildAlign("Password"),
              _buildTextField(
                  labelText: '*******',
                  obscureText: true,
                  controller: _passwordController),
              const Spacer(flex: 2),
              _buildTextButton(),
            ].animate(interval: 100.ms).fadeIn(duration: 900.ms),
          ),
        ),
      ),
    );
  }

  Align _buildAlign(String text) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Color(0xFF6A6A6A)),
      ),
    );
  }

  Padding _buildTextField(
      {String labelText = '', bool obscureText = false, controller}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: labelText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white)),
          hintStyle: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.black),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          errorStyle: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.red),
        ),
      ),
    );
  }

  Padding _buildTextButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: SizedBox(
          height: 54.h,
          width: 400,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                backgroundColor: MaterialStateProperty.all(buttonColor)),
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                print(_nameController.text);
                print(_passwordController.text);
              } else {
                print("not ok");
              }
            },
            child: const Text(
              "Save Now",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ));
  }
}
