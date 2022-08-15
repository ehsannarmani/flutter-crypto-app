import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  final Function? onBuyClicked;
  final Function? onSellClicked;

  const HomeButtons({Key? key, this.onBuyClicked, this.onSellClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              if (onBuyClicked != null) {
                onBuyClicked!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Buy",
                style: textTheme.headline1,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
          )),
          const SizedBox(width: 10),
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              if (onSellClicked != null) {
                onSellClicked!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Sell",
                style: textTheme.headline1,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
          )),
        ],
      ),
    );
  }
}
