import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/primary_button.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

/// Simple error screen used for 404 errors (page not found on web)
class ErrorNavScreen extends StatelessWidget {
  const ErrorNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 75,
            foregroundColor: Colors.black87,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  context.goNamed(AppRoute.home.name);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Navigation Error')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'please don\'t use buttons Navigator',
                  style: headline2Bold(primaryFontColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  onPressed: () {
                    context.goNamed(AppRoute.home.name);
                  },
                  text: 'Go Home',
                )
              ],
            ),
          ),
        ));
  }
}
