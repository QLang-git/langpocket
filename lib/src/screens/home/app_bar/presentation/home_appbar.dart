import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        actions: [
          IconButton(
              onPressed: () {},
              // {
              //   showSearch(context: context, delegate: CustomSearchDelegate());
              // },
              icon: Icon(Icons.search_outlined,
                  size: 35, color: primaryFontColor)),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 15),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings_outlined,
                  size: 35,
                  color: primaryFontColor,
                )),
          )
        ],
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Home',
            style: headline1Bold(primaryFontColor),
          ),
        ),
      ),
    );
  }
}
