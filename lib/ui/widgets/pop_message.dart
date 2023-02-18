import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_num.dart';

class PopMessage {
  displayPopup(
      {required BuildContext context,
      required String text,
      VoidCallback? onPop,
      PopupType type = PopupType.success,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end}) {
    var mounted = true;
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        var popDialog = () {
          mounted = false;
          if (onPop == null) {
            Navigator.pop(context);
          } else {
            onPop.call();
          }
        };
        var success = type == PopupType.success;
        return WillPopScope(
          onWillPop: () {
            mounted = false;
            if (onPop == null) {
              return Future.value(true);
            } else {
              onPop.call();
              return Future.value(false);
            }
          },
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TweenAnimationBuilder<double>(
                builder: (context, value, child) => Transform.translate(
                    offset: Offset(0, value), child: child!),
                duration: const Duration(seconds: 2),
                tween: Tween(begin: 24, end: 0),
                curve: Curves.bounceOut,
                onEnd: () async =>
                    await Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) popDialog();
                }),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Material(
                    borderRadius: BorderRadius.circular(4),
                    color: type == PopupType.success ? deepKoamaru : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            success
                                ? Icons.check_circle
                                : Icons.remove_circle_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Text(
                              text,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: popDialog,
                              icon: const Icon(Icons.close, size: 12),
                              padding: const EdgeInsets.all(6),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
