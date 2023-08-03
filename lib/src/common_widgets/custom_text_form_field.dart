import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final TextStyle? style;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? readOnly;
  final Color? cursorColor;
  final int? maxLength;
  final TextAlign? textAlign;
  final bool? autofocus;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? enableIMEPersonalizedLearning;
  final bool? enableSuggestions;
  final bool? autocorrect;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.decoration = const InputDecoration(),
    this.style = const TextStyle(),
    this.onChanged,
    this.validator,
    this.maxLines,
    this.readOnly,
    this.cursorColor,
    this.maxLength,
    this.textAlign,
    this.autofocus,
    this.focusNode,
    this.enabled,
    this.enableIMEPersonalizedLearning,
    this.enableSuggestions,
    this.autocorrect,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: widget.cursorColor,
      maxLength: widget.maxLength,
      autocorrect: widget.autocorrect ?? false,
      enableIMEPersonalizedLearning:
          widget.enableIMEPersonalizedLearning ?? false,
      enableSuggestions: widget.enableSuggestions ?? false,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus ?? false,
      textAlign: widget.textAlign ?? TextAlign.start,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines,
      controller: widget.controller,
      decoration: widget.decoration,
      style: widget.style,
      textDirection: _textDirection,
      onChanged: (value) {
        final hasRtlCharacters = RegExp(r'[\u0600-\u06FF]');
        setState(() {
          _textDirection = hasRtlCharacters.hasMatch(value)
              ? TextDirection.rtl
              : TextDirection.ltr;
        });
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      validator: widget.validator,
    );
  }
}
