import 'package:flutter/material.dart';

import '../color_utils.dart';
import './color_pickers.dart';

enum ColorMode { rgb, hsl }

class ColorPickerDialog extends StatefulWidget {
  final ColorMode mode;

  ColorPickerDialog(this.mode);

  @override
  _ColorPickerDialogState createState() => new _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color currentColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final picker =
    widget.mode == ColorMode.hsl ? _buildHSLPicker() : _buildRGBPicker();

    return AlertDialog(
      contentPadding: EdgeInsets.all(8.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100.0,
              color: currentColor,
              child: Center(
                child: Text("${colorToHex32(currentColor)}"),
              ),
            ),
            picker
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        IconButton(
          icon: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          onPressed: () => Navigator.of(context).pop(currentColor),
        ),
      ],
    );
  }

  _buildRGBPicker() => RGBPicker(
    onColor: (Color color) => setState(() => currentColor = color),
    color: currentColor,
  );

  _buildHSLPicker() => HSLPicker(
    onColor: (Color color) => setState(() => currentColor = color),
    color: currentColor,
  );
}
