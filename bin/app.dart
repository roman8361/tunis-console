import 'dart:convert';

import 'dart:io';

import 'entity/Player.dart';
import 'service/TunisService.dart';

var listPlayers = fellAndShuffleListPlayers();
var doubleList = <Player>[];

void main(List<String> arguments) {
  listPlayers.forEach((elm) => doubleList.add(elm));

  var tunisService = TunisServiceImpl(listPlayers);

  //todo логика игр команд, можно придумать структуру данных куда всё это зашить
  tunisService.playGame(getNameByIndex(1), getNameByIndex(2), getNameByIndex(3), getNameByIndex(4));
  tunisService.playGame(getNameByIndex(2), getNameByIndex(4), getNameByIndex(3), getNameByIndex(5));
  tunisService.playGame(getNameByIndex(1), getNameByIndex(5), getNameByIndex(3), getNameByIndex(4));
  tunisService.playGame(getNameByIndex(1), getNameByIndex(2), getNameByIndex(4), getNameByIndex(5));
  tunisService.playGame(getNameByIndex(1), getNameByIndex(3), getNameByIndex(2), getNameByIndex(5));
}

String getNameByIndex(int index) {
  return doubleList[index - 1].name;
}

void console() {
  print('1 + 1 = ...');
  var line = stdin.readLineSync(encoding: utf8);
  print(line?.trim() == '2' ? 'Yup!' : 'Nope :(');
}

List<Player> fellAndShuffleListPlayers() {
  var players = <Player>[];
  players.shuffle();
  print('Введите имена пять игроков.');
  for (var i = 0; i < 5; i++) {
    stdout.write('Игрок ${i + 1}: ');
    var name = stdin.readLineSync(encoding: utf8);
    players.add(Player(name));
  }

  return players;
}
