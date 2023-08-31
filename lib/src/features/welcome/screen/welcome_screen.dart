import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/login_function.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;
  OverlayEntry? loadingOverlay;
  late AppLogin appLogin;

  @override
  void initState() {
    appLogin = AppLogin(setLoadingState: setLoadingState, context: context);
    super.initState();
  }

  void setLoadingState(bool status) {
    setState(() {
      isLoading = status;
    });
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
                  appLogin.login();
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
