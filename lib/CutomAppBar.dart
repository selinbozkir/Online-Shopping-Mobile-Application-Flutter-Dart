import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CutomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CutomAppBar({
    Key? key,
  }) : super(key: key);
  Size get preferredSize => Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 2, 161),
      centerTitle: true,
      title: Text(
        'RecycleShop',
        style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontSize: 30),
      ),
    );
  }
}
