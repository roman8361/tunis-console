class Player implements Comparable<Player> {
  var _name;
  var _scoring = 0;
  var _wins = 0;

  Player(this._name);

  get scoring => _scoring;

  set scoring(value) {
    _scoring = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get wins => _wins;

  set wins(value) {
    _wins = value;
  }

  @override
  int compareTo(Player other) {
    int winDiference = _wins - other._wins;

    return winDiference != 0
        ? winDiference
        : this.scoring.compareTo(other.scoring);
  }
}
