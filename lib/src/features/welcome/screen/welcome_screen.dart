import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/routes/router_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;
  OverlayEntry? loadingOverlay;
  void loginWithGoogle(WidgetRef ref) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() => isLoading = true);
    showLoadingOverlay();

    // handle Google login
    final success =
        await ref.read(routerControllerProvider.notifier).continueWithGoogle();

    setState(() => isLoading = false);
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

  void showLoadingOverlay() {
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

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return ResponsiveCenter(
        child: Scaffold(
      backgroundColor: colorScheme.surface,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height *
                  0.3, // 30% of screen height
              child: ClipOval(
                child: Container(
                  color: colorScheme.background,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.width,
                    // Use BoxFit.cover to make sure the image covers the whole circle
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            Text(
              'Welcome to LangPocket',
              style: textTheme.titleMedium!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Elevate Your Vocabulary with Interactive and Customizable Dictionary',
                style: textTheme.bodyLarge!.copyWith(
                  color: const Color.fromARGB(200, 255, 255, 255),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextButton.icon(
                onPressed: () {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () => context.pop(),
                                        icon: Icon(Icons.close,
                                            color: colorScheme.onBackground)),
                                    TextButton(
                                      onPressed: () {
                                        ref
                                            .read(routerControllerProvider
                                                .notifier)
                                            .setFirstTimeToFalse();

                                        //   context.goNamed(AppRoute.home.name);
                                      },
                                      child: Text(
                                        'Later',
                                        style: textTheme.labelLarge!.copyWith(
                                            color: colorScheme.onBackground),
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
                                  style: textTheme.bodyLarge!.copyWith(
                                      color: colorScheme.onBackground),
                                ),
                                const Spacer(flex: 2),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: ElevatedButton.icon(
                                    onPressed: () => loginWithGoogle(ref),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Ionicons.logo_apple,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Continue with Apple',
                                      style: textTheme.labelMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 1),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
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
                },
                label: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                icon: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    ));
  }
}
