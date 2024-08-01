import 'package:flutter/material.dart';
import 'package:practice_app/practice_app_mainpage.dart';
import 'package:practice_app/widgets.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  double results = 0;
  String resultStr = '0.0';
  bool sideMenu = false;
  bool mainPageVisibility = true;
  double moneyValue = 0.0;
  bool isLoading = false;
  String errorMessage = '';
  bool isConnected = true;
  bool visibleWhenConnect = false;
  bool sameCurrency = true;
  bool dialogSame = false;
  List<String> currentFromCurrency = ['USD', 'assets/dollar.png', 'Dollar'];
  List<String> currentToCurrency = ['USD', 'assets/dollar.png', 'Dollar'];
  List<String> fromCurrency = [];
  List<String> toCurrency = [];
  List<List<String>> currency = [
    ['USD', 'assets/dollar.png', 'Dollar'],
    ['INR', 'assets/rupee.png', 'Rupee'],
    ['EUR', 'assets/euro.png', 'Euro'],
    ['GBP', 'assets/pound.png', 'Pound'],
    ['CNY', 'assets/yuan.png', 'Yuan']
  ];

  @override
  void initState() {
    super.initState();
  }

  void handleConvertButtonPress() {
    if (sameCurrency) {
      setState(() {
        dialogSame = true;
      });
    } else {
      navigateToCurrencyConverter(currentFromCurrency, currentToCurrency);
    }
  }

  void handleScrollViewFrom(int index) {
    setState(() {
      if (currentToCurrency != currency[index]) {
        currentFromCurrency = currency[index];
        sameCurrency = false;
      } else {
        sameCurrency = true;
      }
    });
  }

  void handleScrollViewTo(int index) {
    setState(() {
      if (currentFromCurrency != currency[index]) {
        currentToCurrency = currency[index];
        sameCurrency = false;
      } else {
        sameCurrency = true;
      }
    });
  }

  Future<void> navigateToCurrencyConverter(fromCurrency, toCurrency) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CurrencyConverter(
                fromCurrency: fromCurrency, toCurrency: toCurrency)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.withOpacity(0.1),
      body: Column(
        children: [
          Container(
            height: 90,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 45),
              child: Text(
                'Conversions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          dialogSame
              ? dialogBox('Same currency found!', 'Retry', () {
                  setState(() {
                    dialogSame = false;
                  });
                })
              : Stack(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          'Scroll to select the currencies',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 250, left: 30, right: 30),
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          scrollView(currency, handleScrollViewFrom),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ImageIcon(
                              color: Colors.white,
                              AssetImage('assets/arrow.png'),
                            ),
                          ),
                          scrollView(currency, handleScrollViewTo),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 100, right: 100, top: 550),
                    child: TextButton(
                        onPressed: handleConvertButtonPress,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 50),
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Convert',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ),
                ]),
          // elevated('US Dollars <-> Indian Rupees', () async {
          //   fromCurrency = ['USD', 'assets/dollar.png'];
          //   toCurrency = ['INR', 'assets/rupee.png'];
          //   await navigateToCurrencyConverter(fromCurrency, toCurrency);
          // }),
          // const Spacer(
          //   flex: 2,
          // ),
          // elevated('Euro <-> Indian Rupees', () {
          //   fromCurrency = ['EUR', 'assets/euro.png'];
          //   toCurrency = ['INR', 'assets/rupee.png'];
          //   navigateToCurrencyConverter(fromCurrency, toCurrency);
          // }),
          // const Spacer(
          //   flex: 2,
          // ),
          // elevated('UK Pound <-> Indian Rupees', () {
          //   fromCurrency = ['GBP', 'assets/pound.png'];
          //   toCurrency = ['INR', 'assets/rupee.png'];
          //   navigateToCurrencyConverter(fromCurrency, toCurrency);
          // }),
          // const Spacer(
          //   flex: 2,
          // ),
          // elevated('Chinese Yuan <-> Indian Rupees', () {
          //   fromCurrency = ['CNY', 'assets/yuan.png'];
          //   toCurrency = ['INR', 'assets/rupee.png'];
          //   navigateToCurrencyConverter(fromCurrency, toCurrency);
          // }),
          // const Spacer(
          //   flex: 2,
          // ),
        ],
      ),
    );
  }
}
