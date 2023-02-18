import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;

  final bool isPrefix;
  final FormFieldValidator<String>? validator;
  final Function? ontap;
  final ValueChanged<String>? onChange;
  final ValueChanged? onSave;
  final String? hintText;
  final String? symbol;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;

  const AppInputField(
      {Key? key,
      this.controller,
      this.textInputType = TextInputType.text,
      this.isPrefix = false,
      this.onChange,
      this.onSave,
      this.ontap,
      this.enabled,
      this.validator,
      this.symbol,
      required this.hintText,
      this.maxLines,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChange,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      onSaved: onSave,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        counterText: "",
        hintStyle: const TextStyle(
            color: silverChalic, fontSize: 14, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
            borderRadius: BorderRadius.circular(8)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      keyboardType: textInputType,
    );
  }
}

class AppPasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  bool obscureText;

  final FormFieldValidator<String>? validator;
  final Function? ontap;
  final ValueChanged? onChange;
  final String? hintText;
  final int? maxLines;

  AppPasswordInputField(
      {Key? key,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.obscureText = true,
      this.onChange,
      this.ontap,
      this.validator,
      required this.hintText,
      this.maxLines})
      : super(key: key);

  @override
  State<AppPasswordInputField> createState() => _AppPasswordInputFieldState();
}

class _AppPasswordInputFieldState extends State<AppPasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            widget.obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: () {
            setState(() {
              !widget.obscureText
                  ? widget.obscureText = true
                  : widget.obscureText = false;
            });
          },
        ),
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
      obscureText: widget.obscureText,
    );
  }
}
