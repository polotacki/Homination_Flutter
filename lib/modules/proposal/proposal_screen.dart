import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/proposal/proposal_cubit.dart';
import '../../model/service_request_model.dart';
import '../../shared/style/constants.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({Key? key, required this.proposalService})
      : super(key: key);
  final ServicesModel proposalService;

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
    return BlocProvider(
        create: (context) => ProposalCubit(),
        child: BlocConsumer<ProposalCubit, ProposalState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = context.read<ProposalCubit>();

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
                                    items:
                                        _propertyTypeOptions.map((String type) {
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
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              buttonColor)),
                                  onPressed: () async{
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      var serviceName =
                                          widget.proposalService.title;
                                      var serviceProvider =
                                          widget.proposalService.provider;

                                      // Do something with the form data, like submitting to a database

                                      CacheHelper.getData(key: "userName");
                                      print(
                                          'Property in meter: $_propertyInMeter');
                                      print(
                                          'Request description: $_requestDescription');
                                      print('Property type: $_propertyType');
                                      print('Location: $_location');
                                      // Create a new RequestDescription object with data from your form
                                      RequestDescription requestDescription =
                                          RequestDescription(
                                        propertyInMeter: _propertyInMeter,
                                        requestDesc: _requestDescription,
                                        propertyType: _propertyType,
                                        location: _location,
                                      );

                                      // Create a new ServiceRequest object with data from your form and the requestDescription object
                                      ServiceRequest serviceRequest =
                                          ServiceRequest(
                                        clientName: CacheHelper.getData(
                                            key: "userName")??"naser",
                                        providerName: serviceProvider,
                                        serviceName: serviceName,
                                        requestDescription: requestDescription,
                                      );

                                      // Call the sendServiceRequest method of your cubit and pass in the serviceRequest object
                                      cubit.sendServiceRequest(serviceRequest);


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
            }));
  }
}
