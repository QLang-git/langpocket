import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_controller/login_function.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/custom_text_form_field.dart';
import 'package:langpocket/src/data/modules/user_module.dart';
import 'package:langpocket/src/features/home/settings/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsMenu extends ConsumerStatefulWidget {
  const SettingsMenu({super.key});

  @override
  ConsumerState<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends ConsumerState<SettingsMenu> {
  late final FlagCache _cache = FlagCache();
  late Future<void> preloading;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    preloading = _cache.preload(['us', 'fr', 'ru', 'es', 'iq']);
  }

  bool _showTimeSubMenu = false;
  bool _showLanguageSubMenu = false;
  List<String> hoursInDay = List.generate(24, (hour) {
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    final amPm = hour < 12 ? 'AM' : 'PM';
    return '$formattedHour:00 $amPm';
  });

  List<({CircleFlag flag, String lang})> languageSupport() => [
        (
          flag: CircleFlag(
            'us',
            size: 30,
            cache: _cache,
          ),
          lang: 'English'
        ),
        (
          flag: CircleFlag(
            'fr',
            size: 30,
            cache: _cache,
          ),
          lang: 'French'
        ),
        (
          flag: CircleFlag(
            'es',
            size: 30,
            cache: _cache,
          ),
          lang: 'Spanish'
        ),
        (
          flag: CircleFlag(
            'ru',
            size: 30,
            cache: _cache,
          ),
          lang: 'Russian'
        ),
        (
          flag: CircleFlag(
            'iq',
            size: 30,
            cache: _cache,
          ),
          lang: 'Arabic'
        ),
      ];

  var selectedTimeToStudy = '';
  @override
  Widget build(BuildContext context) {
    final settingInfo = ref.watch(appSettingsProvider);
    return Drawer(
      child: AsyncValueWidget(
        value: settingInfo,
        child: (currentInfo) {
          final UserModule(:email, :name, :photoUrl, :isPro) =
              currentInfo.userModule;
          var defaultTime = currentInfo.studyTime;
          var defaultLanguage = currentInfo.studyLanguage;
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            email.isEmpty
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        photoUrl), // Replace with your avatar image
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    backgroundImage: NetworkImage(photoUrl),
                                  ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical:
                                      3), // Providing padding to give space around the text
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline, // Light purple background
                                borderRadius: BorderRadius.circular(
                                    20), // Rounded corners
                                boxShadow: const [
                                  // Adding a subtle shadow for depth
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 2),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: isPro
                                  ? Text(
                                      'Premium',
                                      style: TextStyle(
                                        color: Colors.yellow[
                                            600], // A slightly darker shade of blue
                                        fontSize: 18, // Increased font size
                                        fontWeight:
                                            FontWeight.bold, // Bold text
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        'Free',
                                        style: TextStyle(
                                          color: Colors.blue[
                                              800], // A slightly darker shade of blue
                                          fontSize: 18, // Increased font size
                                          fontWeight:
                                              FontWeight.bold, // Bold text
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white)),
                              Text(email,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white)),
                            ],
                          ),
                        )
                      ]),
                    ),

                    ListTile(
                      title: InkWell(
                        onTap: () {
                          setState(() {
                            _showTimeSubMenu = !_showTimeSubMenu;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '- Study Start Alert',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Icon(
                              _showTimeSubMenu
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showTimeSubMenu)
                      ExpansionTile(
                        title: Text(
                          'Choose Time',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        children: hoursInDay
                            .map((hour) => ListTile(
                                  title: Text(
                                    hour,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedTimeToStudy = hour;
                                    });
                                    ref
                                        .read(appSettingsProvider.notifier)
                                        .setTimeToStudy(hour);
                                    // Handle time selection
                                  },
                                  selected: _setSelectedTime(defaultTime, hour),
                                  trailing: _setSelectedTime(defaultTime, hour)
                                      ? const Icon(Icons.check)
                                      : const SizedBox.shrink(),
                                ))
                            .toList(),
                      ),
                    // Add other menu items here

                    ListTile(
                      title: InkWell(
                        onTap: () {
                          setState(() {
                            _showLanguageSubMenu = !_showLanguageSubMenu;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('- Set Language To study',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Icon(
                              _showTimeSubMenu
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showLanguageSubMenu)
                      ExpansionTile(
                        title: Text('Choose Language',
                            style: Theme.of(context).textTheme.bodyMedium),
                        children: languageSupport()
                            .map((language) => ListTile(
                                  title: Text(
                                    language.lang,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  leading: language.flag,
                                  onTap: () {
                                    setState(() {
                                      selectedTimeToStudy = language.lang;
                                    });
                                    ref
                                        .read(appSettingsProvider.notifier)
                                        .setLanguageToStudy(language.lang);
                                    // Handle time selection
                                  },
                                  selected: _setSelectedTime(
                                      defaultLanguage, language.lang),
                                  trailing: _setSelectedTime(
                                          defaultLanguage, language.lang)
                                      ? const Icon(Icons.check)
                                      : const SizedBox.shrink(),
                                ))
                            .toList(),
                      ),

                    // Add more menu items as needed
                  ],
                ),
              ),
              const Divider(thickness: 2),
              if (isPro == false && email.isNotEmpty) const PayButton(),
              if (email.isEmpty) const LoginButton(),
              const SendFeedbackButton(),
              if (email.isNotEmpty) const LogoutButton(),
              const SizedBox(height: 10)
            ],
          );
        },
      ),
    );
  }

  bool _setSelectedTime(String defaultTime, String hour) {
    return selectedTimeToStudy.isEmpty
        ? defaultTime == hour
        : selectedTimeToStudy == hour;
  }
}

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
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
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Consumer(
        builder: (context, ref, child) => ElevatedButton(
          onPressed: () => appLogin.logOut(ref),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 15, vertical: 7)),
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
            shadowColor: MaterialStateProperty.all(Colors.red[200]),
            elevation: MaterialStateProperty.all(8),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'Sign Out',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SendFeedbackButton extends StatelessWidget {
  const SendFeedbackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final feedbackController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: ElevatedButton(
        onPressed: () => _showFeedbackDialog(context, feedbackController),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
          backgroundColor: MaterialStateProperty.all(Colors.teal),
          shadowColor: MaterialStateProperty.all(Colors.teal.shade200),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
        ),
        child: Text(
          '💌 Share Your Thoughts',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  _showFeedbackDialog(
      BuildContext context, TextEditingController feedbackController) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Share Your Thoughts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 20),
                  controller: feedbackController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback here...',
                    hintStyle: const TextStyle(fontSize: 20),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.redAccent)),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _sendEmail(feedbackController.text);
                        context.pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _sendEmail(String feedback) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'aliamer19ali@example.com',
      query: 'subject=User Feedback&body=$feedback',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email app');
    }
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
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
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ElevatedButton(
        onPressed: () => appLogin.login(),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
          shadowColor: MaterialStateProperty.all(Colors.indigo.shade200),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
        ),
        child: Text(
          'Login',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle button press, e.g., navigate to a payment screen
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
          shadowColor: MaterialStateProperty.all(Colors.deepPurple.shade200),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
        ),
        child: Row(
          mainAxisSize:
              MainAxisSize.min, // This will take space as much as it can
          children: [
            const Icon(Icons.payment, color: Colors.white),
            const SizedBox(
                width:
                    10), // Gives a little space between the icon and the text
            Text(
              'Pay for Subscription',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
