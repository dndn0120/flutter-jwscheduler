import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jw_calendar/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({
    required this.isTime,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
        style: TextStyle(
          color: PRIMARY_COLOR,
          fontWeight: FontWeight.w600,
        ),),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return
      TextField(
        cursorColor: Colors.grey,
        maxLines: isTime ? 1 : null,
        expands: !isTime,
        inputFormatters: isTime ? [
          FilteringTextInputFormatter.digitsOnly,
        ] : [],
        keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: PRIMARY_COLOR,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      );
  }
}


