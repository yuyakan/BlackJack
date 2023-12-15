class CardsDeck {
  var _cards = [];
  static const int _TOTAL_NUMBER = 52;

  CardsDeck() {
    _cards = List.generate(_TOTAL_NUMBER, (i) => i);
    _cards.shuffle();
  }

  void reset() {
    _cards = List.generate(_TOTAL_NUMBER, (i) => i);
  }

  int drow() {
    return _cards.removeLast();
  }
}
