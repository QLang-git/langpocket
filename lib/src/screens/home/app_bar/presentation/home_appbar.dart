import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  final double screenHeight;
  final String userName;
  const HomeAppBar(
      {super.key, required this.screenHeight, required this.userName});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
  @override
  Size get preferredSize =>
      Size.fromHeight(screenHeight >= 770 ? screenHeight * 0.28 : 800 * 0.28);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorSearch = Theme.of(context).colorScheme.secondary;
    return ResponsiveCenter(
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        size: 50,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                    )),
                Padding(
                    padding: const EdgeInsets.only(right: 37),
                    child: IconButton(
                      icon: const Icon(
                        Icons.account_box_rounded,
                        size: 50,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 24),
              child: Text(
                'Hi, ${widget.userName}',
                style: textStyle.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            if (widget.screenHeight > 825)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 24),
                child: Text(
                  'what are your words today',
                  style: textStyle.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
              child: TextField(
                cursorColor: Colors.white,
                style: textStyle.bodyMedium?.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorSearch,
                  labelStyle:
                      textStyle.bodyMedium?.copyWith(color: Colors.white70),
                  hintText: ' Search for one of your words',
                  hintStyle:
                      textStyle.bodyMedium?.copyWith(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  focusedBorder: const OutlineInputBorder(),
                  border: const OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
