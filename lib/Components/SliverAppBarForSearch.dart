import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverForSearch extends StatelessWidget {
  const SliverForSearch({
    super.key,
    required ScrollController scrollController,
    required double containerWidth,
  }) : _scrollController = scrollController, _containerWidth = containerWidth;

  final ScrollController _scrollController;
  final double _containerWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      elevation: 0,
      stretch: true,
      toolbarHeight: 85,
      title: Align(
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            return GestureDetector(
              child: AnimatedContainer(
                width:_containerWidth,
                height: 52.0,
                duration:
                const Duration(milliseconds: 150),
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(10.0),
                  color: Theme.of(context).cardColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(1.5, 1.5),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 10.0),
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.tealAccent,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Songs, albums or artists",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              // Uncomment the following code if you want to navigate to a search page
              // onTap: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SearchPage(
              //       query: '',
              //       fromHome: true,
              //       autofocus: true,
              //     ),
              //   ),
              // ),
            );
          },
        ),
      ),
    );
  }
}