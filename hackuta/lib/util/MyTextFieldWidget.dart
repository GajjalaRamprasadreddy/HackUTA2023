import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;
  final String label;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  // final ValueChanged<bool>? isPwdVisible;
  final bool isObscureText;
  final bool? readOnly;

  const MyTextFieldWidget(
      {required this.controller,
      required this.node,
      this.onChanged,
      this.onSubmitted,
      required this.label,
      this.isObscureText = false,
      this.readOnly = false});

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).unselectedWidgetColor.withOpacity(0.2),
                blurRadius: 7.0, // soften the shadow
                spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  4.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isObscureText,
            readOnly: widget.readOnly ?? false,

            decoration: InputDecoration(
              fillColor: Theme.of(context).backgroundColor,
              filled: true,
              contentPadding: EdgeInsets.all(16),
              isDense: true,
              border: OutlineInputBorder(),

              // labelStyle: theme.bodyRegular(theme.textColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            // style: theme.bodyRegular(theme.textColor),
            focusNode: widget.node,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
          ),
        )
      ],
    );
  }
}
