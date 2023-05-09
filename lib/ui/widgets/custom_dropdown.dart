import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChange(val)) {
  return DropdownButtonFormField<String>(
    menuMaxHeight: 200,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 3,
        ),
      ),
    ),
    value: value,
    onChanged: (value) {
      onChange(value);
    },
    items: items.map<DropdownMenuItem<String>>((String val) {
      return DropdownMenuItem(
        child: Text(val),
        value: val,
      );
    }).toList(),
  );
}
