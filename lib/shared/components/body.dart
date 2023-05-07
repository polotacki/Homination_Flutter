
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../data/chat_data.dart';
import 'chat_card.dart';



class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) =>  AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 300),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child:ChatCard(
              chat: chatsData[index],
              press: () {
    })))

              /*Navigator.push(
                context,
               MaterialPageRoute(
                  builder: (context) => MessagesScreen(),
                ),
              ),*/
            ),
          ),
        ),
      ],
    );
  }
}
