import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rosabon/model/response_models/product_category_response.dart';

class TenorDropDown extends StatelessWidget {
  Tenor? dropdownValue;
  final ValueChanged<Tenor?> onChanged;
  final Color? dropIconColor;
  final Color? hintTextColor;
  final List<Tenor>? items;
  @required
  final String hintText;

  TenorDropDown(
      {Key? key,
      required this.onChanged,
      this.dropdownValue,
      required this.hintText,
      this.dropIconColor,
      this.hintTextColor,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<Tenor>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 20,
        color: Theme.of(context).textTheme.headline1!.color,
      ),
      iconSize: 30,
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: items!.map((item) {
        // dropdownValue = item;

        return DropdownMenuItem<Tenor>(
          value: item,
          child: Text(
            item.tenorName != null ? "${item.tenorName}" : "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      value: dropdownValue,
      validator: (value) => value == null ? 'Field cannot be empty!' : null,
      onChanged: onChanged,
    );
  }
}
