import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_num.dart';

class Appbutton extends StatefulWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? textColor;
  final Color? outlineColor;
  final Color? backgroundColor;
  final AppButtonState buttonState;

  const Appbutton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.buttonState = AppButtonState.idle,
      this.textColor,
      this.outlineColor,
      this.backgroundColor})
      : super(key: key);

  @override
  State<Appbutton> createState() => _AppbuttonState();
}

class _AppbuttonState extends State<Appbutton> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.buttonState == AppButtonState.loading,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0,
                  color:
                      widget.outlineColor == null ? Colors.transparent : deepKoamaru),
              borderRadius: BorderRadius.circular(30),
              color: widget.backgroundColor ?? Colors.white.withOpacity(0.5)),
          child: Center(
            child: widget.buttonState == AppButtonState.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      // valueColor:
                      //     AlwaysStoppedAnimation<Color>(),
                      // backgroundColor: silverChalice,
                    ),
                  )
                : Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        color: widget.textColor),
                  ),
          ),
        ),
      ),
    );
  }
}
