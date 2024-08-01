import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

//loadingBox
Widget loadingBox(String message) {
  return Expanded(
    child: Center(
        child: Dialog(
      shadowColor: Colors.white.withOpacity(0.1),
      backgroundColor: Colors.black54,
      child: SizedBox(
        height: 200,
        width: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 40),
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: Colors.teal,
                rightDotColor: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    )),
  );
}

//dialog box
Widget dialogBox(String message, String buttonText, VoidCallback action) {
  return Expanded(
    child: Center(
      child: Dialog(
        shadowColor: Colors.white.withOpacity(0.1),
        backgroundColor: Colors.black,
        child: SizedBox(
          height: 200,
          width: 300,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Text(
                textAlign: TextAlign.center,
                message,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              const Divider(
                color: Colors.white30,
                thickness: 0.5,
                height: 0,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: RawMaterialButton(
                  onPressed: action,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  )),
                  child: Text(
                    textAlign: TextAlign.center,
                    buttonText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .animate()
          .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 300.ms,
              curve: Curves.easeOutBack)
          .moveY(
              begin: 50, end: 0, duration: 300.ms, curve: Curves.easeOutBack),
    ),
  );
}

// function for elevated buttons
Widget elevated(String content, VoidCallback action) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30),
    child: TextButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        content,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}

//main page function
Widget mainPage(
    double pageHeight,
    double pageWidth,
    String resultStr,
    double results,
    List<String> fromCurrency,
    List<String> toCurrency,
    double moneyValue,
    TextEditingController controllerVar,
    FocusNode textFieldFocus,
    VoidCallback swapCurrency,
    VoidCallback converterFunc) {
  const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    gapPadding: 8,
    borderSide: BorderSide(
      color: Colors.teal,
      width: 2,
    ),
  );

  return SizedBox(
    height: pageHeight,
    width: pageWidth,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(
          flex: 3,
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage(toCurrency[1]),
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  resultStr,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  fromCurrency[0],
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            TextButton(
              onPressed: swapCurrency,
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(100, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Swap',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Image(
                    image: AssetImage('assets/swap.png'),
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  toCurrency[0],
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(
          flex: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            maxLength: 10,
            focusNode: textFieldFocus,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,10}'))
            ],
            controller: controllerVar,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: 'Enter the amount in ${fromCurrency[0]}',
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: ImageIcon(
                  AssetImage(fromCurrency[1]),
                  size: 20,
                ),
              ),
              prefixIconColor: Colors.black,
              filled: true,
              fillColor: Colors.white,
              focusedBorder: border,
              enabledBorder: border,
            ),
            cursorColor: Colors.teal,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: SizedBox(
            width: double.maxFinite,
            height: 45,
            child: RawMaterialButton(
              onPressed: converterFunc,
              fillColor: Colors.teal,
              splashColor: Colors.black.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Convert',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    ),
  );
}

//listview
Widget scrollView(final list, final action) {
  return Expanded(
    child: Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Spacer(),
              ],
            )),
        ListWheelScrollView(
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: action,
          squeeze: 0.9,
          diameterRatio: 1.6,
          itemExtent: 35,
          magnification: 1.4,
          useMagnifier: true,
          perspective: 0.004,
          children: list
              .map<Widget>(
                (value) => SizedBox(
                  width: 200,
                  child: Center(
                    child: Text(
                      '${value[0]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}
