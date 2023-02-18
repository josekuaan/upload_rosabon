import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final bool showLeading;
  const AppBarWidget(
      {Key? key, this.title = "", this.subTitle, this.showLeading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: athensgray, offset: Offset(0, 2.0), blurRadius: 24.0)
        ]),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: deepKoamaru,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          leadingWidth: 48.0,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
