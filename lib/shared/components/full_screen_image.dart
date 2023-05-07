import 'package:flutter/material.dart';

class FullScreenImageWidget extends StatefulWidget {
  final String imageUrl;

  FullScreenImageWidget({required this.imageUrl});

  @override
  _FullScreenImageWidgetState createState() => _FullScreenImageWidgetState();
}

class _FullScreenImageWidgetState extends State<FullScreenImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}