import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../style/constants.dart';

class ColorPickerFormField extends StatefulWidget {
  const ColorPickerFormField({
    Key? key,
    required this.initialColor,
    required this.onChanged,
  }) : super(key: key);

  final Color initialColor;
  final void Function(String color) onChanged;

  @override
  _ColorPickerFormFieldState createState() => _ColorPickerFormFieldState();
}

class _ColorPickerFormFieldState extends State<ColorPickerFormField> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
  }

  Future<void> _selectColor(BuildContext context) async {
    final selectedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _color,
              onColorChanged: (color) {
                _color = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_color);
              },
            ),
          ],
        );
      },
    );
    if (selectedColor != null) {
      setState(() {
        _color = selectedColor;
        widget.onChanged('#${_color.value.toRadixString(16).substring(2)}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _selectColor(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(labelStyle: TextStyle(fontFamily: "Poppins",fontSize: 16.sp ,fontWeight: FontWeight.w600) ,
          labelText: 'Select a color',prefixIcon: Icon(Iconsax.colors_square,color: buttonColor,),
          border: OutlineInputBorder(),
        ),
        child: Container(decoration: BoxDecoration( color: _color,borderRadius: BorderRadius.circular(10)),
          height: 30,

        ),
      ),
    );
  }
}