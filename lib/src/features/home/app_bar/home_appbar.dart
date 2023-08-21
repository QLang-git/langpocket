import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/home/app_bar/custom_search_delegate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double screenHeight;
  final String userName;
  const HomeAppBar(
      {super.key, required this.screenHeight, required this.userName});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(
      (screenHeight >= 770 ? screenHeight * 0.28 : 800 * 0.28) + 24.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorSearch = Theme.of(context).colorScheme.secondary;
    return ResponsiveCenter(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          size: 50,
                        ),
                        color: Colors.white,
                        onPressed: () async {
                          Scaffold.of(context).openDrawer();
                        },
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 24),
                child: Text(
                  'Hi, ${widget.userName}',
                  style: textStyle.titleLarge?.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 24),
                child: Text(
                  'Today\'s journey starts with your words',
                  style: textStyle.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
                child: TextField(
                  cursorColor: Colors.white,
                  style: textStyle.bodyMedium?.copyWith(color: Colors.white),
                  onSubmitted: (String value) {
                    if (value.trim().isNotEmpty) {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                        query: value,
                      );
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    filled: true,
                    fillColor: colorSearch,
                    labelStyle:
                        textStyle.bodySmall?.copyWith(color: Colors.white70),
                    hintText: ' Explore your vocabulary here…',
                    hintStyle:
                        textStyle.bodySmall?.copyWith(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    focusedBorder: const OutlineInputBorder(),
                    border: const OutlineInputBorder(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
