import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_app/widgets.dart';
import 'package:practice_app/currency_api.dart';
import 'package:practice_app/network_connectivity.dart';

class CurrencyConverter extends StatefulWidget {
  final List<String> fromCurrency;
  final List<String> toCurrency;

  const CurrencyConverter(
      {super.key, required this.fromCurrency, required this.toCurrency});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController controllerVar = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();

  late double results;
  late String resultStr;
  late double moneyValue;
  late bool isLoading;
  late String errorMessage;
  late bool isConnected;

  List<String> fromCurrency = [];
  List<String> toCurrency = [];

  @override
  void initState() {
    super.initState();
    isConnected = true;
    isLoading = false;
    errorMessage = '';
    results = 0;
    resultStr = '0.0';
    moneyValue = 0;
    fromCurrency = widget.fromCurrency;
    toCurrency = widget.toCurrency;
    controllerVar.clear();
    checkConnectivityAndUpdate();
  }

  Future<void> checkConnectivityAndUpdate() async {
    bool connected = await check();
    setState(() {
      isConnected = connected;
      if (isConnected) {
        updateMoneyValue(fromCurrency, toCurrency);
      }
    });
  }

  Future<void> updateMoneyValue(fromCurrency, toCurrency) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      isConnected = true;
    });

    try {
      CurrencyApi currencyApi = CurrencyApi(fromCurrency[0], toCurrency[0]);
      await currencyApi.fetchExchangeRate();
      setState(() {
        moneyValue = currencyApi.rate;
        errorMessage = currencyApi.error;
        resultStr = '0.0';
        controllerVar.clear();
        isLoading = false;
      });
    } catch (error) {
      errorMessage = 'Failed to load exchange rates. Please try again later';
      isLoading = false;
    }
  }

  void swapCurrency() {
    setState(() {
      final tempCurrencyHolder = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = tempCurrencyHolder;
      moneyValue = 1 / moneyValue;
      resultStr = '0.0';
      controllerVar.clear();
    });
  }

  void converterFunc() {
    setState(() {
      if (controllerVar.text == '') {
        resultStr = '0.0';
      } else {
        results = (double.parse(controllerVar.text) * moneyValue);
        if (results.toInt().toString().length < 2) {
          resultStr = results.toStringAsFixed(3);
        } else {
          resultStr = results.toStringAsFixed(2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height - 60;
    final double pageWidth = MediaQuery.of(context).size.width;
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.teal.withOpacity(0.1),
      body: Column(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      tooltip: 'Back',
                      color: Colors.white,
                      highlightColor: Colors.black45,
                      onPressed: () async {
                        await SystemChannels.textInput
                            .invokeMethod('TextInput.hide');
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/back.png'),
                        size: 30,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const Text(
                    "Currency converter",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
          isConnected
              ? isLoading
                  ? loadingBox('Fetching data...')
                  : (errorMessage == '')
                      ? Expanded(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Flexible(
                                    child: mainPage(
                                      (pageHeight - keyboardHeight),
                                      pageWidth,
                                      resultStr,
                                      results,
                                      fromCurrency,
                                      toCurrency,
                                      moneyValue,
                                      controllerVar,
                                      textFieldFocus,
                                      swapCurrency,
                                      converterFunc,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : dialogBox(
                          errorMessage, 'Retry', checkConnectivityAndUpdate)
              : dialogBox('Check the Network connectivity!', 'Retry',
                  checkConnectivityAndUpdate),
        ],
      ),
    );
  }
}
