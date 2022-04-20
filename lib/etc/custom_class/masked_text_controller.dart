import 'package:flutter/services.dart';

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    print('value = ${newValue.text}');
    if (newTextLength >= 4 && newValue.text[3] != '-') {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '-');
      if (newValue.selection.end >= 3) {
        selectionIndex += 1;
      }
    } else if (newTextLength >= 8 && newTextLength <= 12 && newValue.text[7] != '-') {
      newText.write(newValue.text.substring(5, usedSubstringIndex = 8) + '-');
      if (newValue.selection.end >= 8) {
        selectionIndex++;
      }
    } else if (newTextLength > 12 && newValue.text[8] != '-') {
      newText.write(newValue.text.substring(5, usedSubstringIndex = 9));
      if (newValue.selection.end >= 9) {
        selectionIndex++;
      }
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
