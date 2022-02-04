import 'dart:convert';
import 'dart:io';

import 'entity/Player.dart';

void main(List<String> arguments) {
  var string = "13-15";
  var result = string.split("-");
  print(result[0]);
  print(result[1]);
}
