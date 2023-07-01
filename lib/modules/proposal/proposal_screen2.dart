import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/proposal/proposal_cubit.dart';
import '../../model/service_request_model.dart';
import '../../shared/components/color_picker.dart';
import '../../shared/components/time_range_picker.dart';
import '../../shared/style/constants.dart';

class ProposalScreen2 extends StatefulWidget {
  const ProposalScreen2({Key? key, required this.proposalService})
      : super(key: key);
  final ServicesModel proposalService;

  @override
  State<ProposalScreen2> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen2> {
  final _formKey = GlobalKey<FormState>();
  final _propertyTypeOptions = ['House', 'Apartment', 'Condo', 'Other'];

  String? _propertyInMeter;
  String? _requestDescription;
  String? _propertyType;
  String? _location;
  String? _style;
  String? _color;
  String? _material;
  double? _totalCost ;
  String? _timeFrame;
  List<String> _styles = ['Traditional', 'Modern', 'Contemporary', 'Rustic', 'Craftsman'];
  List<String> _materials = ['Vinyl', 'Wood', 'Brick', 'Stucco', 'Stone', 'Fiber cement', 'Metal', 'Synthetic stucco'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProposalCubit(),
        child: BlocConsumer<ProposalCubit, ProposalState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = context.read<ProposalCubit>();

              return Scaffold(
                  appBar: AppBar(elevation: 0,scrolledUnderElevation: 0,
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
                                  const SizedBox(height: 20.0),
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
                                  const SizedBox(height: 20.0),
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
                                  const SizedBox(height: 20.0),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Request Description :",
                                        style: TextStyle(fontFamily: "Poppins",fontSize: 16.sp,color: Colors.black87),
                                      )),
                                  const SizedBox(height: 20.0),
                                  DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      prefixIcon:Icon(Iconsax.magicpen,color: buttonColor,) ,
                                      labelText: 'Style',
                                      border: InputBorder.none,
                                    ),
                                    value: _style,
                                    items:
                                    _styles.map((String type) {
                                      return DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _style = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select property type';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      prefixIcon:Icon(Iconsax.shapes,color: buttonColor,) ,
                                      labelText: 'Material',
                                      border: InputBorder.none,
                                    ),
                                    value: _material,
                                    items:
                                    _materials.map((String type) {
                                      return DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _material = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select property type';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  ColorPickerFormField(
                                    initialColor: Colors.blue,
                                    onChanged: (color) {
                                      _color=color;
                                      print(_color);
                                      // Handle the selected color
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  TimeRangeFormField(
                                    initialStartTime: DateTime.now(),
                                    initialEndTime: DateTime.now().add(Duration(days: 7)),
                                    onChanged: (startTime, endTime) {
                                      _timeFrame="$startTime to $endTime";
                                      // Handle the selected time range
                                    },
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
                                  onPressed: () async {
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
                                      var _meter=double.parse(_propertyInMeter!);
                                      var _price = widget.proposalService.price.toDouble() ;
                                      _totalCost=_meter *_price ;
                                      print('total cost: $_totalCost');
                                      SidingContractRequestDetails polo =
                                          SidingContractRequestDetails(
                                              style: _style,
                                              color: _color,
                                              materials: _material,
                                              totalCost: _totalCost,
                                              timeFrame: _timeFrame);
                                      // Create a new RequestDescription object with data from your form
                                      RequestDescription requestDescription =
                                          RequestDescription(
                                        propertyInMeter: _propertyInMeter,
                                        requestDesc: polo,
                                        propertyType: _propertyType,
                                        location: _location,
                                      );

                                      // Create a new ServiceRequest object with data from your form and the requestDescription object
                                      ServiceRequest serviceRequest =
                                          ServiceRequest(
                                        clientName: CacheHelper.getData(
                                                key: "userName") ??
                                            "naser",
                                        providerName: serviceProvider,
                                        serviceName: serviceName,
                                        requestDescription: requestDescription,
                                      );

                                      // Call the sendServiceRequest method of your cubit and pass in the serviceRequest object
                                     cubit
                                          .sendServiceRequest(serviceRequest)
                                          .then((value) =>
                                              Navigator.pop(context));
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
