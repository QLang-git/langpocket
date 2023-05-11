import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class WordViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Word wordData;
  const WordViewAppBar({
    super.key,
    required this.wordData,
  });
  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 37),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.5),
            child: IconButton(
              onPressed: () {
                context.pushNamed(AppRoute.editMode.name,
                    extra: wordData,
                    pathParameters: {'id': wordData.id.toString()});
              },
              icon: const Icon(
                Icons.edit_document,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
        title: Text(
          wordData.foreignWord,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
