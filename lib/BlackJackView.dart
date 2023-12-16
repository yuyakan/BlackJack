import 'package:black_jack/BlackJackViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlackJackView extends StatefulWidget {
  const BlackJackView({super.key, required this.title});

  final String title;

  @override
  State<BlackJackView> createState() => _BlackJackViewState();
}

class _BlackJackViewState extends State<BlackJackView> {
  BlackJackViewModel blackJackViewModel = BlackJackViewModel();
  bool isDrowed = false;
  bool isShowStartButton = true;
  double _position = 0;
  double _opacity = 0;

  RenderBox? renderBox;
  Future<void> _start() async {
    setState(() {
      isShowStartButton = false;
    });
    _position = -30;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 550), () {
      isDrowed = true;
      _opacity = 1;
      _position = 0;
    });
    setState(() {
      blackJackViewModel.start();
    });
  }

  void _open(id) {
    setState(() {
      blackJackViewModel.reverseCard(id);
    });
  }

  void _drow() {
    setState(() {
      blackJackViewModel.drow();
    });
  }

  void _reset() {
    setState(() {
      blackJackViewModel.reset();
      isDrowed = false;
      _position = 0;
      _opacity = 0;
      isShowStartButton = true;
    });
  }

  void _go() {
    setState(() {
      blackJackViewModel.go();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 82, 81, 81),
      body: Center(
          child: Stack(
        children: [
          Visibility(
              visible: !isDrowed,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Column(children: [
                Spacer(),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "img/deck.png",
                          height: size.height * 0.5,
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 500),
                      transform: Matrix4.translationValues(0, _position, 0),
                      child: Image.asset(
                        "img/deck_top.png",
                        height: size.height * 0.5,
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 30, top: 30),
                    child: Visibility(
                      visible: isShowStartButton,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: MaterialButton(
                        onPressed: _start,
                        child: Text("Start",
                            style: TextStyle(fontSize: size.height * 0.05)),
                        padding: EdgeInsets.all(size.height * 0.06),
                        color: Color.fromARGB(255, 215, 76, 211),
                        textColor: Colors.white,
                        shape: CircleBorder(),
                      ),
                    )),
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              SizedBox(
                  width: size.height > 600
                      ? size.width * 0.12
                      : (size.width < 750
                          ? size.width * 0.05
                          : size.width *
                              0.1 *
                              (2.4 -
                                  blackJackViewModel.cardsImagesString.length /
                                      10))),
              Spacer(),
              Visibility(
                visible: isDrowed,
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                child: Row(
                  children: [
                    AnimatedOpacity(
                        opacity: _opacity,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 1000),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              blackJackViewModel.firstImageString == ""
                                  ? "img/back.png"
                                  : blackJackViewModel.firstImageString,
                              height: size.height > 600
                                  ? size.height * 0.4
                                  : size.height * 0.525,
                            ))),
                    AnimatedOpacity(
                      opacity: _opacity,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 1000),
                      child: LimitedBox(
                          maxWidth: size.height > 600 ||
                                  (size.width < 750 && isDrowed)
                              ? size.width *
                                  (0.35 +
                                      0.034 *
                                          blackJackViewModel
                                              .cardsImagesString.length)
                              : size.width *
                                  (0.32 +
                                      0.034 *
                                          blackJackViewModel
                                              .cardsImagesString.length),
                          child: Stack(
                            children: [
                              for (int index = 0;
                                  index <
                                      blackJackViewModel
                                          .cardsImagesString.length;
                                  index++) ...{
                                Positioned(
                                    right: size.height > 600
                                        ? -70.0 * index +
                                            size.width *
                                                (0.14 +
                                                    0.034 *
                                                        blackJackViewModel
                                                            .cardsImagesString
                                                            .length)
                                        : -40.0 * index +
                                            size.width *
                                                (0.14 +
                                                    0.034 *
                                                        blackJackViewModel
                                                            .cardsImagesString
                                                            .length),
                                    top: size.height > 600
                                        ? size.height * 0.3
                                        : size.height * 0.2375,
                                    child: MaterialButton(
                                        onPressed: () {
                                          _open(index);
                                        },
                                        padding: EdgeInsets.zero,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.asset(
                                              blackJackViewModel
                                                  .showCardsImagesString[index],
                                              height: size.height > 600
                                                  ? size.height * 0.4
                                                  : size.height * 0.525,
                                            ))))
                              }
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Visibility(
                    visible: !blackJackViewModel.isShowSum && isDrowed,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, right: 10),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text("Fight?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('Cancel'),
                                      isDestructiveAction: true,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _go();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Text("Fight", style: TextStyle(fontSize: 20)),
                        padding: EdgeInsets.all(20),
                        color: Color.fromARGB(255, 219, 65, 41),
                        textColor: Colors.white,
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  Spacer(),
                  Visibility(
                      visible: blackJackViewModel.isShowDrowButton && isDrowed,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30, right: 10),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Drow?"),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text('Cancel'),
                                        isDestructiveAction: true,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      CupertinoDialogAction(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _drow();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Text("Drow", style: TextStyle(fontSize: 20)),
                          padding: EdgeInsets.all(20),
                          color: Color.fromARGB(255, 5, 202, 189),
                          textColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                      ))
                ],
              ),
            ],
          ),
          Visibility(
            visible: blackJackViewModel.isShowSum,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: blackJackViewModel.isShowSum,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Text(
                      "${blackJackViewModel.sum}",
                      style: TextStyle(
                        fontSize: 200,
                        color: blackJackViewModel.isUnder21
                            ? Color.fromARGB(255, 3, 225, 245)
                            : Color.fromARGB(255, 250, 43, 43),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Spacer(),
            Visibility(
              visible: blackJackViewModel.isShowSum,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, right: 10),
                    child: MaterialButton(
                      onPressed: _reset,
                      child: Text("Reset", style: TextStyle(fontSize: 20)),
                      padding: EdgeInsets.all(20),
                      color: Color.fromARGB(255, 215, 76, 211),
                      textColor: Colors.white,
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),
            ),
          ])
        ],
      )),
    );
  }
}
