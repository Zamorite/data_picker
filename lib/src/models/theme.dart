import 'package:data_picker/src/utils/constants.dart';
import 'package:flutter/material.dart';

class PickerTheme {
  final BoxDecoration sheetDecoration;
  final InputDecoration fieldDecoration;
  final TextStyle labelStyle, leadingStyle;
  final double? horizontalPadding, marginTop, leadingWidth, itemHeight;
  final bool showLeading;

  const PickerTheme({
    this.marginTop,
    this.itemHeight,
    this.leadingWidth,
    this.horizontalPadding,
    this.showLeading = true,
    this.labelStyle = kLabelStyle,
    this.leadingStyle = kLabelStyle,
    this.fieldDecoration = kFieldDecoration,
    this.sheetDecoration = kBottomSheetDecoration,
  });
}
