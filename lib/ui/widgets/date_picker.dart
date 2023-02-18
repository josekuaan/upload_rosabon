import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';

class DatePicker extends StatefulWidget {
  DatePicker(
      {Key? key,
      this.controller,
      this.hintText,
      this.enableText,
      this.onChange,
      this.ontap,
      this.textInputType,
      this.validator})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType? textInputType;

  final FormFieldValidator<String>? validator;
  final Function? ontap;
  final ValueChanged? onChange;
  final String? hintText;
  final bool? enableText;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        if (picked != null) {
          setState(() {
            widget.controller!.text = yMDDate(picked);
          });
        }
      },
      readOnly: true,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        suffixIcon: const Icon(Icons.calendar_today_outlined),
        hintStyle: const TextStyle(
            color: silverChalic, fontSize: 14, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
            borderRadius: BorderRadius.circular(5)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      keyboardType: widget.textInputType,
      enabled: widget.enableText,
    );
  }
}
