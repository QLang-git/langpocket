import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key,
      required this.value,
      required this.child,
      this.padding = const EdgeInsets.all(0),
      this.loading = const CircularProgressIndicator()});
  final AsyncValue<T> value;
  final Widget Function(T) child;
  final EdgeInsetsGeometry padding;
  final Widget loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: child,
      error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      loading: () => Center(
          child: Padding(
        padding: padding,
        child: const CircularProgressIndicator(),
      )),
    );
  }
}
