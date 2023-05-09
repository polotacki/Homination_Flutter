import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/shared/components/body.dart';

import '../../bloc/cubits/app_cupit/app_cubit.dart';
import '../../shared/style/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  Scaffold(
            appBar: buildAppBar(),
            body: Body(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: buttonColor,
              child: const Icon(
                Icons.person_add_alt_1,
                color: Colors.white,
              ),
            ),

          );
        });
}}
AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,centerTitle: true,
    title: Text('Massage',style:TextStyle(fontSize: 20.sp,fontFamily: 'Poppins',fontWeight: FontWeight.normal,)),
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
    ],
  );
}
