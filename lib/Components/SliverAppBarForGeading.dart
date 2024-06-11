import 'package:flutter/material.dart';

class SliverForGreading extends StatelessWidget {
  const SliverForGreading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 165,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return const FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0),
                  child: Text(
                    'Hi There,',
                    style: TextStyle(
                      fontSize: 29,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0),
                  child: Text(
                    'Aayush',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1,
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