import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../shared/style/constants.dart';

class ProposalScreen extends StatefulWidget {
  ProposalScreen({Key? key}) : super(key: key);

  @override
  State<ProposalScreen> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _propertyTypeOptions = ['House', 'Apartment', 'Condo', 'Other'];

  String? _propertyInMeter;
  String? _requestDescription;
  String? _propertyType;
  String? _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Proposal Apply',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left_24,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Property in meter',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter property in meter';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _propertyInMeter = value;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Property type',
                            border: InputBorder.none,
                          ),
                          value: _propertyType,
                          items: _propertyTypeOptions.map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _propertyType = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select property type';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter location';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _location = value;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const SizedBox(height: 16.0),
                        Container(
                          height: 200.0,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Request description',
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                            maxLines: 100,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter request description';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _requestDescription = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: SizedBox(
                    height: 54.h,
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
                            _formKey.currentState!.save();
                            // Do something with the form data, like submitting to a database
                            print('Property in meter: $_propertyInMeter');
                            print('Request description: $_requestDescription');
                            print('Property type: $_propertyType');
                            print('Location: $_location');
                            Navigator.of(context).pop();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Apply",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
