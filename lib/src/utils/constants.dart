import 'package:flutter/material.dart';

const kLabelStyle = const TextStyle(fontSize: 18);

const kBottomSheetDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);
const kFieldDecoration = InputDecoration(
  labelText: 'Search',
  hintText: 'Start typing to search',
  prefixIcon: const Icon(Icons.search),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: const Color(0xFF8C98A8), //.withOpacity(0.2),
    ),
  ),
);
