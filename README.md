# langpocket

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

![architecture](https://github.com/QLang-git/langpocket/assets/76897266/5ebcee06-9006-4696-b367-d15ae60664a6)

```
langpocket
├─ .git
│  ├─ COMMIT_EDITMSG
│  ├─ FETCH_HEAD
│  ├─ HEAD
│  ├─ ORIG_HEAD
│  ├─ branches
│  ├─ config
│  ├─ description
│  ├─ hooks
│  │  ├─ applypatch-msg.sample
│  │  ├─ commit-msg.sample
│  │  ├─ fsmonitor-watchman.sample
│  │  ├─ post-update.sample
│  │  ├─ pre-applypatch.sample
│  │  ├─ pre-commit.sample
│  │  ├─ pre-merge-commit.sample
│  │  ├─ pre-push.sample
│  │  ├─ pre-rebase.sample
│  │  ├─ pre-receive.sample
│  │  ├─ prepare-commit-msg.sample
│  │  ├─ push-to-checkout.sample
│  │  └─ update.sample
│  ├─ index
│  ├─ info
│  │  └─ exclude
│  ├─ logs
│  │  ├─ HEAD
│  │  └─ refs
│  │     ├─ heads
│  │     │  ├─ app-beta
│  │     │  ├─ dev
│  │     │  ├─ fix-routing
│  │     │  ├─ master
│  │     │  └─ web-bet-stable
│  │     ├─ remotes
│  │     │  └─ origin
│  │     │     ├─ app-beta
│  │     │     ├─ dev
│  │     │     ├─ fix-routing
│  │     │     ├─ master
│  │     │     └─ web-bet-stable
│  │     └─ stash
│  │  
│  │  
│  └─ refs
│     ├─ heads
│     │  ├─ app-beta
│     │  ├─ dev
│     │  ├─ fix-routing
│     │  ├─ master
│     │  └─ web-bet-stable
│     ├─ remotes
│     │  └─ origin
│     │     ├─ app-beta
│     │     ├─ dev
│     │     ├─ fix-routing
│     │     ├─ master
│     │     └─ web-bet-stable
│     ├─ stash
│     └─ tags
├─ .github
│  └─ workflows
│     └─ testing.yaml
├─ .gitignore
├─ .metadata
├─ .vscode
│  ├─ launch.json
│  └─ settings.json
├─ README.md
├─ analysis_options.yaml
├─ android
│  ├─ .gitignore
│  ├─ .gradle
│  │  ├─ 7.4
│  │  │  ├─ checksums
│  │  │  │  ├─ checksums.lock
│  │  │  │  ├─ md5-checksums.bin
│  │  │  │  └─ sha1-checksums.bin
│  │  │  ├─ dependencies-accessors
│  │  │  │  ├─ dependencies-accessors.lock
│  │  │  │  └─ gc.properties
│  │  │  ├─ executionHistory
│  │  │  │  ├─ executionHistory.bin
│  │  │  │  └─ executionHistory.lock
│  │  │  ├─ fileChanges
│  │  │  │  └─ last-build.bin
│  │  │  ├─ fileHashes
│  │  │  │  ├─ fileHashes.bin
│  │  │  │  ├─ fileHashes.lock
│  │  │  │  └─ resourceHashesCache.bin
│  │  │  ├─ gc.properties
│  │  │  └─ vcsMetadata
│  │  ├─ buildOutputCleanup
│  │  │  ├─ buildOutputCleanup.lock
│  │  │  ├─ cache.properties
│  │  │  └─ outputFiles.bin
│  │  ├─ file-system.probe
│  │  └─ vcs-1
│  │     └─ gc.properties
│  ├─ app
│  │  ├─ build.gradle
│  │  └─ src
│  │     ├─ debug
│  │     │  └─ AndroidManifest.xml
│  │     ├─ main
│  │     │  ├─ AndroidManifest.xml
│  │     │  ├─ java
│  │     │  │  └─ io
│  │     │  │     └─ flutter
│  │     │  │        └─ plugins
│  │     │  │           └─ GeneratedPluginRegistrant.java
│  │     │  ├─ kotlin
│  │     │  │  └─ com
│  │     │  │     └─ example
│  │     │  │        └─ langpocket
│  │     │  │           └─ MainActivity.kt
│  │     │  └─ res
│  │     │     ├─ drawable
│  │     │     │  ├─ background.png
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ drawable-hdpi
│  │     │     │  └─ splash.png
│  │     │     ├─ drawable-mdpi
│  │     │     │  └─ splash.png
│  │     │     ├─ drawable-v21
│  │     │     │  ├─ background.png
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ drawable-xhdpi
│  │     │     │  └─ splash.png
│  │     │     ├─ drawable-xxhdpi
│  │     │     │  └─ splash.png
│  │     │     ├─ drawable-xxxhdpi
│  │     │     │  └─ splash.png
│  │     │     ├─ mipmap-hdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-mdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ values
│  │     │     │  └─ styles.xml
│  │     │     └─ values-night
│  │     │        └─ styles.xml
│  │     └─ profile
│  │        └─ AndroidManifest.xml
│  ├─ build.gradle
│  ├─ gradle
│  │  └─ wrapper
│  │     ├─ gradle-wrapper.jar
│  │     └─ gradle-wrapper.properties
│  ├─ gradle.properties
│  ├─ gradlew
│  ├─ gradlew.bat
│  ├─ local.properties
│  └─ settings.gradle
├─ build
│  ├─ 4d25a1cda3833f76c80232d3b1a3704b.cache.dill.track.dill
│  ├─ 685b153a5ec3c56ea7b25a2a8a89883d
│  │  ├─ _composite.stamp
│  │  ├─ gen_dart_plugin_registrant.stamp
│  │  └─ gen_localizations.stamp
│  ├─ 848be5db5f481ecf6e25c915e63fdf38
│  │  ├─ _composite.stamp
│  │  ├─ gen_dart_plugin_registrant.stamp
│  │  └─ gen_localizations.stamp
│  ├─ ade00fc64fa695e0daed02c1105f6d67.cache.dill.track.dill
│  ├─ flutter_assets
│  │  ├─ AssetManifest.bin
│  │  ├─ AssetManifest.json
│  │  ├─ FontManifest.json
│  │  ├─ NOTICES
│  │  ├─ fonts
│  │  │  └─ MaterialIcons-Regular.otf
│  │  ├─ images
│  │  │  ├─ books.png
│  │  │  ├─ books_stack.png
│  │  │  └─ logo.png
│  │  ├─ packages
│  │  │  ├─ cupertino_icons
│  │  │  │  └─ assets
│  │  │  │     └─ CupertinoIcons.ttf
│  │  │  ├─ im_stepper
│  │  │  │  └─ assets
│  │  │  │     └─ me.jpg
│  │  │  └─ ionicons
│  │  │     └─ assets
│  │  │        └─ fonts
│  │  │           └─ Ionicons.ttf
│  │  └─ shaders
│  │     └─ ink_sparkle.frag
│  ├─ test_cache
│  │  └─ build
│  │     └─ c075001b96339384a97db4862b8ab8db.cache.dill.track.dill
│  └─ unit_test_assets
│     ├─ AssetManifest.bin
│     ├─ AssetManifest.json
│     ├─ FontManifest.json
│     ├─ NOTICES.Z
│     ├─ fonts
│     │  └─ MaterialIcons-Regular.otf
│     ├─ images
│     │  ├─ books.png
│     │  ├─ books_stack.png
│     │  └─ logo.png
│     ├─ packages
│     │  ├─ cupertino_icons
│     │  │  └─ assets
│     │  │     └─ CupertinoIcons.ttf
│     │  ├─ im_stepper
│     │  │  └─ assets
│     │  │     └─ me.jpg
│     │  └─ ionicons
│     │     └─ assets
│     │        └─ fonts
│     │           └─ Ionicons.ttf
│     └─ shaders
│        └─ ink_sparkle.frag
├─ flutter_native_splash.yaml
├─ images
│  ├─ books.png
│  ├─ books_stack.png
│  └─ logo.png
├─ ios
│  ├─ .gitignore
│  ├─ Flutter
│  │  ├─ AppFrameworkInfo.plist
│  │  ├─ Debug.xcconfig
│  │  ├─ Generated.xcconfig
│  │  ├─ Release.xcconfig
│  │  └─ flutter_export_environment.sh
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  ├─ AppIcon.appiconset
│  │  │  │  ├─ Contents.json
│  │  │  │  ├─ Icon-App-1024x1024@1x.png
│  │  │  │  ├─ Icon-App-20x20@1x.png
│  │  │  │  ├─ Icon-App-20x20@2x.png
│  │  │  │  ├─ Icon-App-20x20@3x.png
│  │  │  │  ├─ Icon-App-29x29@1x.png
│  │  │  │  ├─ Icon-App-29x29@2x.png
│  │  │  │  ├─ Icon-App-29x29@3x.png
│  │  │  │  ├─ Icon-App-40x40@1x.png
│  │  │  │  ├─ Icon-App-40x40@2x.png
│  │  │  │  ├─ Icon-App-40x40@3x.png
│  │  │  │  ├─ Icon-App-60x60@2x.png
│  │  │  │  ├─ Icon-App-60x60@3x.png
│  │  │  │  ├─ Icon-App-76x76@1x.png
│  │  │  │  ├─ Icon-App-76x76@2x.png
│  │  │  │  └─ Icon-App-83.5x83.5@2x.png
│  │  │  ├─ LaunchBackground.imageset
│  │  │  │  ├─ Contents.json
│  │  │  │  └─ background.png
│  │  │  └─ LaunchImage.imageset
│  │  │     ├─ Contents.json
│  │  │     ├─ LaunchImage.png
│  │  │     ├─ LaunchImage@2x.png
│  │  │     ├─ LaunchImage@3x.png
│  │  │     └─ README.md
│  │  ├─ Base.lproj
│  │  │  ├─ LaunchScreen.storyboard
│  │  │  └─ Main.storyboard
│  │  ├─ GeneratedPluginRegistrant.h
│  │  ├─ GeneratedPluginRegistrant.m
│  │  ├─ Info.plist
│  │  └─ Runner-Bridging-Header.h
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  ├─ contents.xcworkspacedata
│  │  │  └─ xcshareddata
│  │  │     ├─ IDEWorkspaceChecks.plist
│  │  │     └─ WorkspaceSettings.xcsettings
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  └─ Runner.xcworkspace
│     ├─ contents.xcworkspacedata
│     └─ xcshareddata
│        ├─ IDEWorkspaceChecks.plist
│        └─ WorkspaceSettings.xcsettings
├─ lib
│  ├─ main.dart
│  └─ src
│     ├─ app.dart
│     ├─ common_controller
│     │  ├─ microphone_controller.dart
│     │  ├─ microphone_usage.dart
│     │  └─ word_records_notifier.dart
│     ├─ common_widgets
│     │  ├─ async_value_widget.dart
│     │  ├─ custom_dialog_practice.dart
│     │  ├─ custom_warning_dialog.dart
│     │  ├─ empty_placeholder_widget.dart
│     │  ├─ error_message_widget.dart
│     │  ├─ keep_alive_page.dart
│     │  ├─ primary_button.dart
│     │  ├─ responsive_center.dart
│     │  ├─ responsive_two_column_layout.dart
│     │  └─ views
│     │     ├─ examples_view
│     │     │  ├─ example_view.dart
│     │     │  └─ examples_view.dart
│     │     ├─ image_view
│     │     │  └─ image_view.dart
│     │     ├─ note_view
│     │     │  └─ note_view.dart
│     │     └─ word_view
│     │        └─ word_view.dart
│     ├─ data
│     │  ├─ data_flow
│     │  │  └─ data_flow.dart
│     │  ├─ local
│     │  │  ├─ connection
│     │  │  │  ├─ connection.dart
│     │  │  │  ├─ native.dart
│     │  │  │  ├─ unsupported.dart
│     │  │  │  └─ web.dart
│     │  │  ├─ entities
│     │  │  │  ├─ group_entity.dart
│     │  │  │  └─ word_entity.dart
│     │  │  └─ repository
│     │  │     ├─ drift_group_repository.dart
│     │  │     ├─ drift_group_repository.g.dart
│     │  │     ├─ images.dart
│     │  │     ├─ insert_default_data.dart
│     │  │     └─ local_group_repository.dart
│     │  ├─ modules
│     │  │  ├─ extensions.dart
│     │  │  ├─ group_module.dart
│     │  │  └─ word_module.dart
│     │  ├─ remote
│     │  │  ├─ remote_db.dart
│     │  │  └─ remote_group_repository.dart
│     │  └─ services
│     │     └─ word_service.dart
│     ├─ screens
│     │  ├─ group
│     │  │  ├─ app_bar
│     │  │  │  └─ group_appbar.dart
│     │  │  ├─ controller
│     │  │  │  └─ group_controller.dart
│     │  │  ├─ screen
│     │  │  │  └─ group_screen.dart
│     │  │  └─ widgets
│     │  │     ├─ custom_practice_dialog.dart
│     │  │     ├─ word_info.dart
│     │  │     └─ words_list.dart
│     │  ├─ home
│     │  │  ├─ app_bar
│     │  │  │  ├─ controller
│     │  │  │  │  └─ custom_search_delegate.dart
│     │  │  │  └─ presentation
│     │  │  │     └─ home_appbar.dart
│     │  │  ├─ controller
│     │  │  │  └─ home_controller.dart
│     │  │  ├─ screen
│     │  │  │  └─ home_screen.dart
│     │  │  └─ widgets
│     │  │     └─ groups_list
│     │  │        ├─ controller
│     │  │        └─ groups_list.dart
│     │  ├─ new_word
│     │  │  ├─ app_bar
│     │  │  │  └─ new_word_appbar.dart
│     │  │  ├─ controller
│     │  │  │  └─ save_word_controller.dart
│     │  │  ├─ screen
│     │  │  │  └─ new_word_screen.dart
│     │  │  └─ widgets
│     │  │     ├─ form
│     │  │     │  ├─ fields
│     │  │     │  │  ├─ example_word.dart
│     │  │     │  │  ├─ foreign_word.dart
│     │  │     │  │  ├─ mean_word.dart
│     │  │     │  │  └─ notes_word.dart
│     │  │     │  └─ word_form.dart
│     │  │     └─ image_picker
│     │  │        └─ images_dashboard.dart
│     │  ├─ practice
│     │  │  ├─ audio
│     │  │  │  ├─ controller
│     │  │  │  │  └─ audio_controller.dart
│     │  │  │  └─ screen
│     │  │  │     ├─ audio_appbar.dart
│     │  │  │     └─ audio_screen.dart
│     │  │  ├─ interactive
│     │  │  │  ├─ app_bar
│     │  │  │  │  └─ practice_interactive_appbar.dart
│     │  │  │  ├─ controller
│     │  │  │  │  └─ practice_stepper_controller.dart
│     │  │  │  ├─ screen
│     │  │  │  │  └─ practice_interactive_screen.dart
│     │  │  │  └─ widgets
│     │  │  │     ├─ practice_stepper
│     │  │  │     │  ├─ animated_sound_icon.dart
│     │  │  │     │  ├─ practice_stepper.dart
│     │  │  │     │  ├─ step_message.dart
│     │  │  │     │  └─ steps_microphone_button.dart
│     │  │  │     └─ steps
│     │  │  │        ├─ listen_and_repeat
│     │  │  │        │  ├─ listen_repeat.dart
│     │  │  │        │  └─ listen_repeat_controller.dart
│     │  │  │        ├─ listen_and_write
│     │  │  │        │  ├─ listen_and_write.dart
│     │  │  │        │  └─ listen_write_controller.dart
│     │  │  │        └─ read_and_speak
│     │  │  │           ├─ read_and_speak.dart
│     │  │  │           └─ read_and_speak_controller.dart
│     │  │  ├─ pronunciation
│     │  │  │  ├─ app_bar
│     │  │  │  │  └─ pron_appbar.dart
│     │  │  │  ├─ controllers
│     │  │  │  │  ├─ mic_controller.dart
│     │  │  │  │  ├─ mic_group_controller.dart
│     │  │  │  │  └─ mic_single_controller.dart
│     │  │  │  ├─ screen
│     │  │  │  │  ├─ practice_pron_group_screen.dart
│     │  │  │  │  └─ practice_pron_single_screen.dart
│     │  │  │  └─ widgets
│     │  │  │     ├─ microphone_button.dart
│     │  │  │     └─ practice_pronunciation.dart
│     │  │  └─ spelling
│     │  │     ├─ app_bar
│     │  │     │  └─ spelling_appbar.dart
│     │  │     ├─ controllers
│     │  │     │  ├─ spelling_controller.dart
│     │  │     │  ├─ spelling_group_controller.dart
│     │  │     │  └─ spelling_word_controller.dart
│     │  │     ├─ screens
│     │  │     │  ├─ practice_spelling_group_screen.dart
│     │  │     │  └─ practice_spelling_single_screen.dart
│     │  │     └─ widgets
│     │  │        └─ practice_spelling.dart
│     │  ├─ todo
│     │  │  ├─ appbar
│     │  │  │  └─ todo_appbar.dart
│     │  │  ├─ controller
│     │  │  └─ screen
│     │  │     └─ todo_screen.dart
│     │  ├─ word_edit
│     │  │  ├─ app_bar
│     │  │  │  └─ word_editor_app_bar.dart
│     │  │  ├─ controller
│     │  │  │  └─ word_editor_controller.dart
│     │  │  ├─ screen
│     │  │  │  └─ edit_mode_word_screen.dart
│     │  │  └─ widgets
│     │  │     ├─ edit_form
│     │  │     │  ├─ edit_word_form.dart
│     │  │     │  └─ fields
│     │  │     │     ├─ edit_example_word.dart
│     │  │     │     ├─ edit_foreign_word.dart
│     │  │     │     ├─ mean_word.dart
│     │  │     │     └─ notes_word.dart
│     │  │     └─ edit_word_image
│     │  │        └─ edit_word_image.dart
│     │  ├─ word_previewer
│     │  │  ├─ app_bar
│     │  │  │  └─ word_previewer_appbar.dart
│     │  │  └─ screen
│     │  │     └─ word_previewer_screen.dart
│     │  └─ word_view
│     │     ├─ controller
│     │     │  └─ word_view_controller.dart
│     │     ├─ screen
│     │     │  └─ word_view_screen.dart
│     │     └─ word_view_appbar
│     │        └─ word_view_appbar.dart
│     ├─ styles
│     │  └─ light_mode.dart
│     └─ utils
│        ├─ constants
│        │  ├─ breakpoints.dart
│        │  └─ messages.dart
│        └─ routes
│           ├─ app_routes.dart
│           ├─ error_nav_screen.dart
│           └─ not_found_screen.dart
├─ linux
│  ├─ .gitignore
│  ├─ CMakeLists.txt
│  ├─ flutter
│  │  ├─ CMakeLists.txt
│  │  ├─ ephemeral
│  │  │  ├─ .plugin_symlinks
│  │  │  │  ├─ file_selector_linux
│  │  │  │  │  ├─ AUTHORS
│  │  │  │  │  ├─ CHANGELOG.md
│  │  │  │  │  ├─ LICENSE
│  │  │  │  │  ├─ README.md
│  │  │  │  │  ├─ example
│  │  │  │  │  │  ├─ README.md
│  │  │  │  │  │  ├─ lib
│  │  │  │  │  │  │  ├─ get_directory_page.dart
│  │  │  │  │  │  │  ├─ get_multiple_directories_page.dart
│  │  │  │  │  │  │  ├─ home_page.dart
│  │  │  │  │  │  │  ├─ main.dart
│  │  │  │  │  │  │  ├─ open_image_page.dart
│  │  │  │  │  │  │  ├─ open_multiple_images_page.dart
│  │  │  │  │  │  │  ├─ open_text_page.dart
│  │  │  │  │  │  │  └─ save_text_page.dart
│  │  │  │  │  │  ├─ linux
│  │  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  │  ├─ flutter
│  │  │  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  │  │  └─ generated_plugins.cmake
│  │  │  │  │  │  │  ├─ main.cc
│  │  │  │  │  │  │  ├─ my_application.cc
│  │  │  │  │  │  │  └─ my_application.h
│  │  │  │  │  │  └─ pubspec.yaml
│  │  │  │  │  ├─ lib
│  │  │  │  │  │  └─ file_selector_linux.dart
│  │  │  │  │  ├─ linux
│  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  ├─ file_selector_plugin.cc
│  │  │  │  │  │  ├─ file_selector_plugin_private.h
│  │  │  │  │  │  ├─ include
│  │  │  │  │  │  │  └─ file_selector_linux
│  │  │  │  │  │  │     └─ file_selector_plugin.h
│  │  │  │  │  │  └─ test
│  │  │  │  │  │     ├─ file_selector_plugin_test.cc
│  │  │  │  │  │     └─ test_main.cc
│  │  │  │  │  ├─ pubspec.yaml
│  │  │  │  │  └─ test
│  │  │  │  │     └─ file_selector_linux_test.dart
│  │  │  │  ├─ image_picker_linux
│  │  │  │  │  ├─ AUTHORS
│  │  │  │  │  ├─ CHANGELOG.md
│  │  │  │  │  ├─ LICENSE
│  │  │  │  │  ├─ README.md
│  │  │  │  │  ├─ example
│  │  │  │  │  │  ├─ README.md
│  │  │  │  │  │  ├─ lib
│  │  │  │  │  │  │  └─ main.dart
│  │  │  │  │  │  ├─ linux
│  │  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  │  ├─ flutter
│  │  │  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  │  │  └─ generated_plugins.cmake
│  │  │  │  │  │  │  ├─ main.cc
│  │  │  │  │  │  │  ├─ my_application.cc
│  │  │  │  │  │  │  └─ my_application.h
│  │  │  │  │  │  └─ pubspec.yaml
│  │  │  │  │  ├─ lib
│  │  │  │  │  │  └─ image_picker_linux.dart
│  │  │  │  │  ├─ pubspec.yaml
│  │  │  │  │  └─ test
│  │  │  │  │     ├─ image_picker_linux_test.dart
│  │  │  │  │     └─ image_picker_linux_test.mocks.dart
│  │  │  │  ├─ path_provider_linux
│  │  │  │  │  ├─ AUTHORS
│  │  │  │  │  ├─ CHANGELOG.md
│  │  │  │  │  ├─ LICENSE
│  │  │  │  │  ├─ README.md
│  │  │  │  │  ├─ example
│  │  │  │  │  │  ├─ README.md
│  │  │  │  │  │  ├─ integration_test
│  │  │  │  │  │  │  └─ path_provider_test.dart
│  │  │  │  │  │  ├─ lib
│  │  │  │  │  │  │  └─ main.dart
│  │  │  │  │  │  ├─ linux
│  │  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  │  ├─ flutter
│  │  │  │  │  │  │  │  ├─ CMakeLists.txt
│  │  │  │  │  │  │  │  └─ generated_plugins.cmake
│  │  │  │  │  │  │  ├─ main.cc
│  │  │  │  │  │  │  ├─ my_application.cc
│  │  │  │  │  │  │  └─ my_application.h
│  │  │  │  │  │  ├─ pubspec.yaml
│  │  │  │  │  │  └─ test_driver
│  │  │  │  │  │     └─ integration_test.dart
│  │  │  │  │  ├─ lib
│  │  │  │  │  │  ├─ path_provider_linux.dart
│  │  │  │  │  │  └─ src
│  │  │  │  │  │     ├─ get_application_id.dart
│  │  │  │  │  │     ├─ get_application_id_real.dart
│  │  │  │  │  │     ├─ get_application_id_stub.dart
│  │  │  │  │  │     └─ path_provider_linux.dart
│  │  │  │  │  ├─ pubspec.yaml
│  │  │  │  │  └─ test
│  │  │  │  │     ├─ get_application_id_test.dart
│  │  │  │  │     └─ path_provider_linux_test.dart
│  │  │  │  └─ sqlite3_flutter_libs
│  │  │  │     ├─ CHANGELOG.md
│  │  │  │     ├─ LICENSE
│  │  │  │     ├─ README.md
│  │  │  │     ├─ android
│  │  │  │     │  ├─ build.gradle
│  │  │  │     │  ├─ gradle
│  │  │  │     │  │  └─ wrapper
│  │  │  │     │  │     └─ gradle-wrapper.properties
│  │  │  │     │  ├─ gradle.properties
│  │  │  │     │  ├─ settings.gradle
│  │  │  │     │  └─ src
│  │  │  │     │     └─ main
│  │  │  │     │        ├─ AndroidManifest.xml
│  │  │  │     │        └─ java
│  │  │  │     │           └─ eu
│  │  │  │     │              └─ simonbinder
│  │  │  │     │                 └─ sqlite3_flutter_libs
│  │  │  │     │                    └─ Sqlite3FlutterLibsPlugin.java
│  │  │  │     ├─ example
│  │  │  │     │  ├─ README.md
│  │  │  │     │  └─ pubspec.yaml
│  │  │  │     ├─ ios
│  │  │  │     │  ├─ Classes
│  │  │  │     │  │  ├─ Sqlite3FlutterLibsPlugin.h
│  │  │  │     │  │  └─ Sqlite3FlutterLibsPlugin.m
│  │  │  │     │  └─ sqlite3_flutter_libs.podspec
│  │  │  │     ├─ lib
│  │  │  │     │  └─ sqlite3_flutter_libs.dart
│  │  │  │     ├─ linux
│  │  │  │     │  ├─ CMakeLists.txt
│  │  │  │     │  ├─ include
│  │  │  │     │  │  └─ sqlite3_flutter_libs
│  │  │  │     │  │     └─ sqlite3_flutter_libs_plugin.h
│  │  │  │     │  └─ sqlite3_flutter_libs_plugin.cc
│  │  │  │     ├─ macos
│  │  │  │     │  ├─ Classes
│  │  │  │     │  │  ├─ Sqlite3FlutterLibsPlugin.h
│  │  │  │     │  │  └─ Sqlite3FlutterLibsPlugin.m
│  │  │  │     │  └─ sqlite3_flutter_libs.podspec
│  │  │  │     ├─ pubspec.yaml
│  │  │  │     └─ windows
│  │  │  │        ├─ CMakeLists.txt
│  │  │  │        ├─ include
│  │  │  │        │  └─ sqlite3_flutter_libs
│  │  │  │        │     └─ sqlite3_flutter_libs_plugin.h
│  │  │  │        ├─ sqlite3_flutter.c
│  │  │  │        └─ sqlite3_flutter_libs_plugin.cpp
│  │  │  └─ generated_config.cmake
│  │  ├─ generated_plugin_registrant.cc
│  │  ├─ generated_plugin_registrant.h
│  │  └─ generated_plugins.cmake
│  ├─ main.cc
│  ├─ my_application.cc
│  └─ my_application.h
├─ macos
│  ├─ .gitignore
│  ├─ Flutter
│  │  ├─ Flutter-Debug.xcconfig
│  │  ├─ Flutter-Release.xcconfig
│  │  ├─ GeneratedPluginRegistrant.swift
│  │  └─ ephemeral
│  │     ├─ Flutter-Generated.xcconfig
│  │     └─ flutter_export_environment.sh
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  └─ AppIcon.appiconset
│  │  │     ├─ Contents.json
│  │  │     ├─ app_icon_1024.png
│  │  │     ├─ app_icon_128.png
│  │  │     ├─ app_icon_16.png
│  │  │     ├─ app_icon_256.png
│  │  │     ├─ app_icon_32.png
│  │  │     ├─ app_icon_512.png
│  │  │     └─ app_icon_64.png
│  │  ├─ Base.lproj
│  │  │  └─ MainMenu.xib
│  │  ├─ Configs
│  │  │  ├─ AppInfo.xcconfig
│  │  │  ├─ Debug.xcconfig
│  │  │  ├─ Release.xcconfig
│  │  │  └─ Warnings.xcconfig
│  │  ├─ DebugProfile.entitlements
│  │  ├─ Info.plist
│  │  ├─ MainFlutterWindow.swift
│  │  └─ Release.entitlements
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  └─ xcshareddata
│  │  │     └─ IDEWorkspaceChecks.plist
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  └─ Runner.xcworkspace
│     ├─ contents.xcworkspacedata
│     └─ xcshareddata
│        └─ IDEWorkspaceChecks.plist
├─ pubspec.lock
├─ pubspec.yaml
├─ test
│  ├─ images_testing
│  │  └─ img_test.png
│  └─ src
│     ├─ data
│     │  ├─ local
│     │  │  └─ repository
│     │  │     └─ drift_group_repository_test.dart
│     │  └─ modules
│     │     └─ extensions_test.dart
│     └─ screens
│        ├─ group
│        │  ├─ app_bar
│        │  │  └─ group_appbar_test.dart
│        │  ├─ controller
│        │  │  └─ group_controller_test.dart
│        │  ├─ group_robot.dart
│        │  └─ screen
│        │     └─ group_screen_test.dart
│        ├─ home
│        │  ├─ screen
│        │  │  ├─ home_robot.dart
│        │  │  └─ home_screen_test.dart
│        │  └─ widgets
│        │     └─ groups_list
│        │        ├─ controller
│        │        │  └─ groups_controller_test.dart
│        │        └─ groups_list_test.dart
│        ├─ new_word
│        │  └─ controller
│        │     └─ save_word_controller_test.dart
│        ├─ word_edit
│        │  └─ controller
│        │     └─ word_editor_controller_test.dart
│        └─ word_view
│           └─ controller
│              └─ word_view_controller_test.dart
├─ web
│  ├─ favicon.png
│  ├─ icons
│  │  ├─ Icon-192.png
│  │  ├─ Icon-512.png
│  │  ├─ Icon-maskable-192.png
│  │  └─ Icon-maskable-512.png
│  ├─ index.html
│  ├─ manifest.json
│  ├─ shared_worker.dart.js
│  ├─ splash
│  │  ├─ img
│  │  │  ├─ dark-1x.png
│  │  │  ├─ dark-2x.png
│  │  │  ├─ dark-3x.png
│  │  │  ├─ dark-4x.png
│  │  │  ├─ light-1x.png
│  │  │  ├─ light-2x.png
│  │  │  ├─ light-3x.png
│  │  │  └─ light-4x.png
│  │  ├─ splash.js
│  │  └─ style.css
│  ├─ sqlite3.wasm
│  └─ worker.dart
└─ windows
   ├─ .gitignore
   ├─ CMakeLists.txt
   ├─ flutter
   │  ├─ CMakeLists.txt
   │  ├─ ephemeral
   │  │  └─ .plugin_symlinks
   │  │     ├─ file_selector_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ LICENSE
   │  │     │  ├─ README.md
   │  │     │  ├─ example
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ lib
   │  │     │  │  │  ├─ get_directory_page.dart
   │  │     │  │  │  ├─ get_multiple_directories_page.dart
   │  │     │  │  │  ├─ home_page.dart
   │  │     │  │  │  ├─ main.dart
   │  │     │  │  │  ├─ open_image_page.dart
   │  │     │  │  │  ├─ open_multiple_images_page.dart
   │  │     │  │  │  ├─ open_text_page.dart
   │  │     │  │  │  └─ save_text_page.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ lib
   │  │     │  │  ├─ file_selector_windows.dart
   │  │     │  │  └─ src
   │  │     │  │     └─ messages.g.dart
   │  │     │  ├─ pigeons
   │  │     │  │  ├─ copyright.txt
   │  │     │  │  └─ messages.dart
   │  │     │  ├─ pubspec.yaml
   │  │     │  ├─ test
   │  │     │  │  ├─ file_selector_windows_test.dart
   │  │     │  │  ├─ file_selector_windows_test.mocks.dart
   │  │     │  │  └─ test_api.g.dart
   │  │     │  └─ windows
   │  │     │     ├─ CMakeLists.txt
   │  │     │     ├─ file_dialog_controller.cpp
   │  │     │     ├─ file_dialog_controller.h
   │  │     │     ├─ file_selector_plugin.cpp
   │  │     │     ├─ file_selector_plugin.h
   │  │     │     ├─ file_selector_windows.cpp
   │  │     │     ├─ include
   │  │     │     │  └─ file_selector_windows
   │  │     │     │     └─ file_selector_windows.h
   │  │     │     ├─ messages.g.cpp
   │  │     │     ├─ messages.g.h
   │  │     │     ├─ string_utils.cpp
   │  │     │     ├─ string_utils.h
   │  │     │     └─ test
   │  │     │        ├─ file_selector_plugin_test.cpp
   │  │     │        ├─ test_file_dialog_controller.cpp
   │  │     │        ├─ test_file_dialog_controller.h
   │  │     │        ├─ test_main.cpp
   │  │     │        ├─ test_utils.cpp
   │  │     │        └─ test_utils.h
   │  │     ├─ image_picker_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ LICENSE
   │  │     │  ├─ README.md
   │  │     │  ├─ example
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ lib
   │  │     │  │  └─ image_picker_windows.dart
   │  │     │  ├─ pubspec.yaml
   │  │     │  └─ test
   │  │     │     ├─ image_picker_windows_test.dart
   │  │     │     └─ image_picker_windows_test.mocks.dart
   │  │     ├─ path_provider_windows
   │  │     │  ├─ AUTHORS
   │  │     │  ├─ CHANGELOG.md
   │  │     │  ├─ LICENSE
   │  │     │  ├─ README.md
   │  │     │  ├─ example
   │  │     │  │  ├─ README.md
   │  │     │  │  ├─ integration_test
   │  │     │  │  │  └─ path_provider_test.dart
   │  │     │  │  ├─ lib
   │  │     │  │  │  └─ main.dart
   │  │     │  │  ├─ pubspec.yaml
   │  │     │  │  ├─ test_driver
   │  │     │  │  │  └─ integration_test.dart
   │  │     │  │  └─ windows
   │  │     │  │     ├─ CMakeLists.txt
   │  │     │  │     ├─ flutter
   │  │     │  │     │  ├─ CMakeLists.txt
   │  │     │  │     │  └─ generated_plugins.cmake
   │  │     │  │     └─ runner
   │  │     │  │        ├─ CMakeLists.txt
   │  │     │  │        ├─ Runner.rc
   │  │     │  │        ├─ flutter_window.cpp
   │  │     │  │        ├─ flutter_window.h
   │  │     │  │        ├─ main.cpp
   │  │     │  │        ├─ resource.h
   │  │     │  │        ├─ resources
   │  │     │  │        │  └─ app_icon.ico
   │  │     │  │        ├─ run_loop.cpp
   │  │     │  │        ├─ run_loop.h
   │  │     │  │        ├─ runner.exe.manifest
   │  │     │  │        ├─ utils.cpp
   │  │     │  │        ├─ utils.h
   │  │     │  │        ├─ win32_window.cpp
   │  │     │  │        └─ win32_window.h
   │  │     │  ├─ lib
   │  │     │  │  ├─ path_provider_windows.dart
   │  │     │  │  └─ src
   │  │     │  │     ├─ folders.dart
   │  │     │  │     ├─ folders_stub.dart
   │  │     │  │     ├─ path_provider_windows_real.dart
   │  │     │  │     └─ path_provider_windows_stub.dart
   │  │     │  ├─ pubspec.yaml
   │  │     │  └─ test
   │  │     │     └─ path_provider_windows_test.dart
   │  │     └─ sqlite3_flutter_libs
   │  │        ├─ CHANGELOG.md
   │  │        ├─ LICENSE
   │  │        ├─ README.md
   │  │        ├─ android
   │  │        │  ├─ build.gradle
   │  │        │  ├─ gradle
   │  │        │  │  └─ wrapper
   │  │        │  │     └─ gradle-wrapper.properties
   │  │        │  ├─ gradle.properties
   │  │        │  ├─ settings.gradle
   │  │        │  └─ src
   │  │        │     └─ main
   │  │        │        ├─ AndroidManifest.xml
   │  │        │        └─ java
   │  │        │           └─ eu
   │  │        │              └─ simonbinder
   │  │        │                 └─ sqlite3_flutter_libs
   │  │        │                    └─ Sqlite3FlutterLibsPlugin.java
   │  │        ├─ example
   │  │        │  ├─ README.md
   │  │        │  └─ pubspec.yaml
   │  │        ├─ ios
   │  │        │  ├─ Classes
   │  │        │  │  ├─ Sqlite3FlutterLibsPlugin.h
   │  │        │  │  └─ Sqlite3FlutterLibsPlugin.m
   │  │        │  └─ sqlite3_flutter_libs.podspec
   │  │        ├─ lib
   │  │        │  └─ sqlite3_flutter_libs.dart
   │  │        ├─ linux
   │  │        │  ├─ CMakeLists.txt
   │  │        │  ├─ include
   │  │        │  │  └─ sqlite3_flutter_libs
   │  │        │  │     └─ sqlite3_flutter_libs_plugin.h
   │  │        │  └─ sqlite3_flutter_libs_plugin.cc
   │  │        ├─ macos
   │  │        │  ├─ Classes
   │  │        │  │  ├─ Sqlite3FlutterLibsPlugin.h
   │  │        │  │  └─ Sqlite3FlutterLibsPlugin.m
   │  │        │  └─ sqlite3_flutter_libs.podspec
   │  │        ├─ pubspec.yaml
   │  │        └─ windows
   │  │           ├─ CMakeLists.txt
   │  │           ├─ include
   │  │           │  └─ sqlite3_flutter_libs
   │  │           │     └─ sqlite3_flutter_libs_plugin.h
   │  │           ├─ sqlite3_flutter.c
   │  │           └─ sqlite3_flutter_libs_plugin.cpp
   │  ├─ generated_plugin_registrant.cc
   │  ├─ generated_plugin_registrant.h
   │  └─ generated_plugins.cmake
   └─ runner
      ├─ CMakeLists.txt
      ├─ Runner.rc
      ├─ flutter_window.cpp
      ├─ flutter_window.h
      ├─ main.cpp
      ├─ resource.h
      ├─ resources
      │  └─ app_icon.ico
      ├─ runner.exe.manifest
      ├─ utils.cpp
      ├─ utils.h
      ├─ win32_window.cpp
      └─ win32_window.h

```
