import 'dart:convert';

String utf8decode(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}
