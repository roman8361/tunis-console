import 'dart:convert';
import 'dart:io';

import '../entity/Player.dart';
import '../entity/Team.dart';

class TunisServiceImpl implements TunisService {
  static int countTour = 1;
  List<Player> _playersList;

  TunisServiceImpl(this._playersList);

  @override
  void printPlayersResult() {
    _playersList.sort();
    _playersList =
        _playersList.reversed.toList(); //todo сделать это в сущности Player

    print("+--------------+--------+----------+--------+");
    print("| Players Name | Wins   | Score    | Place  |");
    print("+--------------+--------+----------+--------+");
    for (var i = 0; i < _playersList.length; i++) {
      print(
          "|\t${_playersList[i].name} \t   |  ${_playersList[i].wins}\t    |  ${_playersList[i].scoring}\t   |   ${i + 1}    |");
    }
    print("+--------------+--------+----------+--------+");
    print('');
  }

  List<Player> get playersList => _playersList;

  set playersList(List<Player> value) {
    _playersList = value;
  }

  @override
  void checkWins(Team team1, Team team2) {
    if (team1.scoringTeam! > team2.scoringTeam!) {
      team1.isWin = true;
      team1.one.scoring = team1.scoringTeam! - team2.scoringTeam!;
      team1.two.scoring = team1.scoringTeam! - team2.scoringTeam!;
      team1.one.wins++;
      team1.two.wins++;

      team2.one.scoring = team2.scoringTeam! - team1.scoringTeam!;
      team2.two.scoring = team2.scoringTeam! - team1.scoringTeam!;
    } else {
      team2.isWin = true;
      team2.one.scoring = team2.scoringTeam! - team1.scoringTeam!;
      team2.two.scoring = team2.scoringTeam! - team1.scoringTeam!;
      team2.one.wins++;
      team2.two.wins++;

      team1.one.scoring = team1.scoringTeam! - team2.scoringTeam!;
      team1.two.scoring = team1.scoringTeam! - team2.scoringTeam!;
    }
    printPlayersResult();
  }

  @override
  void playGame(String firstPlayerName, String secondPlayerName, String thirdPlayerName, String fourthPlayerName) {

    var firstPlayer = _playersList.where((elm) => elm.name == firstPlayerName).first;
    var secondPlayer = _playersList.where((elm) => elm.name == secondPlayerName).first;
    var thirdPlayer = playersList.where((elm) => elm.name == thirdPlayerName).first;
    var fourthPlayer = playersList.where((elm) => elm.name == fourthPlayerName).first;

    print('${countTour++} - ТУР');
    print("Играют $firstPlayerName/$secondPlayerName VS $thirdPlayerName/$fourthPlayerName");
    print("Введите счёт через тире например: 15-13");
    String? resultScoringTeamOne = stdin.readLineSync(encoding: utf8);

    var resultScoringTeamList = resultScoringTeamOne?.split("-");
    var teamOne = getTeamResult(firstPlayer, secondPlayer, int.parse(resultScoringTeamList![0]));
    var teamTwo = getTeamResult(thirdPlayer, fourthPlayer, int.parse(resultScoringTeamList[1]));

    if  (teamOne.scoringTeam! > teamTwo.scoringTeam!) {
      firstPlayer.wins++;
      secondPlayer.wins++;
      firstPlayer.scoring = firstPlayer.scoring + (teamOne.scoringTeam! - teamTwo.scoringTeam!);
      secondPlayer.scoring = secondPlayer.scoring + (teamOne.scoringTeam! - teamTwo.scoringTeam!);

      thirdPlayer.scoring = thirdPlayer.scoring + (teamTwo.scoringTeam! - teamOne.scoringTeam!);
      fourthPlayer.scoring = fourthPlayer.scoring + (teamTwo.scoringTeam! - teamOne.scoringTeam!);

    } else {
      thirdPlayer.wins++;
      fourthPlayer.wins++;
      thirdPlayer.scoring = thirdPlayer.scoring + (teamTwo.scoringTeam! - teamOne.scoringTeam!);
      fourthPlayer.scoring = fourthPlayer.scoring + (teamTwo.scoringTeam! - teamOne.scoringTeam!);

      firstPlayer.scoring = firstPlayer.scoring + (teamOne.scoringTeam! - teamTwo.scoringTeam!);
      secondPlayer.scoring = secondPlayer.scoring + (teamOne.scoringTeam! - teamTwo.scoringTeam!);
    }

    printPlayersResult();
  }

  Team getTeamResult(Player playerOne, Player playerTwo, int scoringTeam){
    var result = Team(playerOne, playerTwo);
    result.scoringTeam = scoringTeam;
    return result;
  }

}

abstract class TunisService {
  void printPlayersResult();

  void checkWins(Team team1, Team team2);

  void playGame(String playerOne, String playerTwo, String playerThree,
      String playerFour);
}
