import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/utils/routes/router_controller.dart';

class AppLogin {
  final ValueChanged<bool> setLoadingState;
  OverlayEntry? loadingOverlay;
  BuildContext context;

  AppLogin(
      {required this.setLoadingState,
      required this.context,
      this.loadingOverlay});

  void login() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Consumer(
              builder: (context, ref, _) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(Icons.close,
                              color: colorScheme.onBackground)),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(routerControllerProvider.notifier)
                              .setFirstTimeToFalse();

                          //   context.goNamed(AppRoute.home.name);
                        },
                        child: Text(
                          'Later',
                          style: textTheme.labelLarge!
                              .copyWith(color: colorScheme.onBackground),
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Get Started with Just a Click!',
                    style: textTheme.headlineLarge!
                        .copyWith(color: colorScheme.outline),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    'Choose your favorite social media platform and jump right in',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                  const Spacer(flex: 2),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton.icon(
                      onPressed: () => _loginWithGoogle(ref, context),
                      icon: const Icon(
                        Ionicons.logo_google,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Continue with Google',
                        style: textTheme.labelMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton.icon(
                      onPressed: () => _loginWithFacebook(ref, context),
                      icon: const Icon(
                        Ionicons.logo_facebook,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Continue with Facebook',
                        style: textTheme.labelMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void logOut(WidgetRef ref) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    setLoadingState(true);
    showLoadingOverlay(context);

    // handle Google login
    final success = await ref.read(routerControllerProvider.notifier).logOut();
    setLoadingState(false);
    hideLoadingOverlay();

    if (success) {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.green[700],
        content: const Text('Sign Out successful!'),
      ));

      ref.read(routerControllerProvider.notifier).setFirstTimeToFalse();
    } else {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
        content: const Text('Sign Out Failed, please try again..'),
      ));
    }
  }

  void _loginWithGoogle(WidgetRef ref, BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    setLoadingState(true);
    showLoadingOverlay(context);

    // handle Google login
    final success =
        await ref.read(routerControllerProvider.notifier).continueWithGoogle();
    setLoadingState(false);
    hideLoadingOverlay();

    if (success) {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text('Login successful!'),
      ));

      ref.read(routerControllerProvider.notifier).setFirstTimeToFalse();
    } else {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
        content: const Text('Login Failed, please try again..'),
      ));
    }
  }

  void _loginWithFacebook(WidgetRef ref, BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    setLoadingState(true);
    showLoadingOverlay(context);

    // handle Google login
    final success = await ref
        .read(routerControllerProvider.notifier)
        .continueWithFacebook();

    setLoadingState(false);
    hideLoadingOverlay();

    if (success) {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text('Login successful!'),
      ));

      ref.read(routerControllerProvider.notifier).setFirstTimeToFalse();
    } else {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
        content: const Text('Login Failed, please try again..'),
      ));
    }
  }

  void showLoadingOverlay(BuildContext context) {
    loadingOverlay = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54, // Shadow effect
        child: const Center(
          child: CircularProgressIndicator(), // Loading indicator
        ),
      ),
    );

    Overlay.of(context).insert(loadingOverlay!);
  }

  void hideLoadingOverlay() {
    loadingOverlay?.remove();
    loadingOverlay = null;
  }
}
