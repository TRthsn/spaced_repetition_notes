import 'package:flutter/material.dart';

class TextStyleConstants extends TextStyle {
  const TextStyleConstants.noteText()
      : super(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        );
  const TextStyleConstants.noteCaption()
      : super(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        );
  const TextStyleConstants.noteCaptionCurrentDay()
      : super(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.orange,
        );
  const TextStyleConstants.noteDateAndHour()
      : super(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        );
}
