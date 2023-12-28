import 'package:flutter/material.dart';
import 'package:flutter_application_collatz/calculate.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_collatz/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late TextEditingController _controller;
  late List<int>? resultLastValue = [];
  late List<int>? inText = [];
  String informationText = '';
  bool enableButton = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor(firstPageBackGroundColor),
          appBar: AppBar(
            toolbarHeight: appbarTextHeight,
            title: Image.asset('lib/assets/images/collatz.jpg'),
            backgroundColor: HexColor(appbarBackgroundColor),
          ),
          body: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: sizeboxHeight),
              Text(firstPageText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: HexColor(firstPageTextColor))),
              SizedBox(
                width: sizeboxWidth,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: HexColor(appbarBackgroundColor))),
                  ),
                  controller: _controller,
                  style: TextStyle(
                      fontSize: 30.0,
                      height: 2.0,
                      color: HexColor(appbarBackgroundColor)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor(appbarBackgroundColor),
                              foregroundColor: HexColor(firstPageTextColor)),
                          onPressed: () async {
                            try {
                              setState(() {
                                enableButton = false;
                                final List<int>? resultLastValue =
                                    Calculate().produce(_controller);
                                inText = resultLastValue;
                                clickonInformation =
                                    '${inText?.length} adımda sonuca ulaştınız.';

                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              });
                            } catch (e) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Warning!"),
                                    content: const Text(warningTextField),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Calculate',
                              style: TextStyle(
                                  letterSpacing: letterSpacingShort,
                                  fontSize: firstPageButtonMiniFontSize))),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor(firstPageTextColor),
                              foregroundColor: HexColor(appbarBackgroundColor)),
                          onPressed: () {
                            setState(() {
                              enableButton = true;
                              _controller = TextEditingController()..text = '';
                              inText = [];
                              clickonInformation =
                                  'More Information About Collatz Conjecture';
                            });
                          },
                          child: const Text('Clear',
                              style: TextStyle(
                                  letterSpacing: letterSpacingShort,
                                  fontSize: firstPageButtonMiniFontSize))),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemCount: inText?.length,
                  itemBuilder: (context, index) {
                    return Expanded(
                        child: Card(
                            color: HexColor(appbarBackgroundColor),
                            margin: const EdgeInsets.symmetric(
                                horizontal: cardElevationMarginVertical,
                                vertical: cardElevationMarginVertical),
                            elevation: cardElevationHeight,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${index + 1}. adım  :',
                                      style: TextStyle(
                                          color: HexColor(firstPageTextColor))),
                                  Text('${inText?[index]}',
                                      style: TextStyle(
                                          fontSize: firstPageTextFontSize,
                                          color: HexColor(firstPageTextColor))),
                                ],
                              ),
                            )));
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor(firstPageTextColor),
                    foregroundColor: HexColor(appbarBackgroundColor)),
                onPressed: () {
                  enableButton == true
                      ? showModalBottomSheet(
                          backgroundColor: HexColor(firstPageBackGroundColor),
                          context: context,
                          builder: (context) {
                            return SizedBox(
                                height: 450,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(collatzInformation,
                                        style: TextStyle(
                                            color:
                                                HexColor(appbarBackgroundColor),
                                            fontSize:
                                                firstPageTextXMiniFontSize)),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              HexColor(firstPageTextColor),
                                          foregroundColor:
                                              HexColor(appbarBackgroundColor)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Close'))
                                ]));
                          })
                      : null;
                },
                child: Text(clickonInformation,
                    style: TextStyle(
                        color: HexColor(appbarBackgroundColor),
                        fontSize: firstPageTextXMiniFontSize)),
              ),
            ],
          ))),
    );
  }
}
