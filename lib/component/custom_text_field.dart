import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jw_calendar/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.isTime,
    required this.label,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,
      // null 이 리턴되면 에러가 없다.
      // 에러가 있으면 에러를 string으로 리턴
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력해주세요.';
        }

        if (isTime) {
          int time = int.parse(val!);
          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요.';
          }

          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요.';
          }
        } else {
          if (val!.length > 500) {
            return '500자 이하로 입력해주세요.';
          }
        }

        return null;
      },
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      decoration: InputDecoration(
        suffixText: isTime ? '시' : null,
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
