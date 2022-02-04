import '../entity/Player.dart';

/**
 * Паттерн Singleton
 * можно попробовать переписать на другой принцип создания, но позже
 * побаловаться. В проекте не используется сейчас, далее может пригодиться.
 */

class PlayersRepository {
  static PlayersRepository? _instance;

  List<Player> _competitors = <Player>[];

  factory PlayersRepository.getInstance() {
    _instance ??= PlayersRepository();
    return _instance!;
  }

  PlayersRepository();

  List<Player> get competitors => _competitors;

  set competitors(List<Player> value) {
    _competitors = value;
  }

}
