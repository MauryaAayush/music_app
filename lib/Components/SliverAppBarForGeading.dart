import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliverForGreading extends StatelessWidget {
  const SliverForGreading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 135,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Hi There,',
                    style: GoogleFonts.roboto(
                      fontSize: 26,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Aayush',
                    style: GoogleFonts.roboto(
                      fontSize: 18.5,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
