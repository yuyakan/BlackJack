import 'package:black_jack/Model/CardsDeckProvider.dart';
import 'package:black_jack/Model/numConvertCard.dart';

class BlackJackViewModel {
  bool isGameStated = false;
  var firstImageString = "";
  var cardsImagesString = [];
  var showCardsImagesString = [];
  var isCardsOpened = [];
  var isShowDrowButton = true;
  var numList = [];
  var sum = 0;
  var isUnder21 = true;
  var isShowSum = false;
  static var cardsDeck = CardsDeck();

  void start() {
    isGameStated = true;
    firstImageString = _drowImage();
    _addCardRemainedDown();
  }

  void _addCardRemainedDown() {
    cardsImagesString.add(_drowImage());
    showCardsImagesString.add("img/back.png");
    isCardsOpened.add(false);
  }

  String _drowImage() {
    NumConvertCard numConvertCard = NumConvertCard(cardsDeck.drow());
    numList.add(numConvertCard.number());
    return "img/cards/${numConvertCard.mark()}${numConvertCard.number()}.png";
  }

  void drow() {
    cardsImagesString.add(_drowImage());
    showCardsImagesString.add("img/back.png");
    isCardsOpened.add(false);
    if (cardsImagesString.length >= 7) {
      isShowDrowButton = false;
    }
  }

  void reset() {
    isGameStated = false;
    cardsDeck = CardsDeck();
    cardsImagesString = [];
    showCardsImagesString = [];
    isCardsOpened = [];
    firstImageString = "";
    isShowDrowButton = true;
    numList = [];
    sum = 0;
    isShowSum = false;
  }

  void reverseCard(id) {
    if (isCardsOpened[id]) {
      isCardsOpened[id] = false;
      showCardsImagesString[id] = "img/back.png";
    } else {
      isCardsOpened[id] = true;
      showCardsImagesString[id] = cardsImagesString[id];
    }
  }

  void go() {
    sum = calcSum();
    if (sum > 21) {
      isUnder21 = false;
    } else {
      isUnder21 = true;
    }
    showCardsImagesString = cardsImagesString;
    isShowDrowButton = false;
    isShowSum = true;
  }

  int calcSum() {
    var sumCardNum = numList.map((e) => _calcNum(e)).reduce((a, b) => a + b);
    var countANum = numList.where((element) => element == 1).length;
    print(countANum);
    for (int index = 1; index <= countANum; index++) {
      if (sumCardNum + 10 > 21) {
        break;
      }
      sumCardNum += 10;
    }
    return sumCardNum;
  }

  int _calcNum(int num) {
    if (num >= 10) {
      return 10;
    }
    return num;
  }
}
