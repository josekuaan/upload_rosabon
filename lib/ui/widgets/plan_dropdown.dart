import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rosabon/model/response_models/plan_response.dart';

class PlanDropDown extends StatelessWidget {
  final String? dropdownValue;
  final ValueChanged<Plan?> onChanged;
  final Color? dropIconColor;
  final Color? hintTextColor;
  final List<Plan>? items;
  @required
  final String hintText;

  const PlanDropDown(
      {Key? key,
      required this.onChanged,
      required this.dropdownValue,
      required this.hintText,
      this.dropIconColor,
      this.hintTextColor,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<Plan>(
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
      items: items!
          .map((item) => DropdownMenuItem<Plan>(
                value: item,
                child: Text(
                  item.planName != null ? "${item.planName}" : "",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) => value == null ? 'Field cannot be empty!' : null,
      onChanged: onChanged,
    );
  }
}
