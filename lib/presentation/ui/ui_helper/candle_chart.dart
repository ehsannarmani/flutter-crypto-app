import 'package:crypto_app/data/models/candle_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';

import '../../utils/formatter.dart';

class CandleChart extends StatefulWidget {
  List<CandleModel> candles;
   CandleChart({Key? key,required this.candles}) : super(key: key);

  @override
  State<CandleChart> createState() => _CandleChartState();
}

class _CandleChartState extends State<CandleChart> {
   late ThemeData theme;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Chart(
        layers: layers(theme,widget.candles),
      ),
    );
  }

  List<ChartLayer> layers(ThemeData theme,List<CandleModel> candles) {

     TextTheme textTheme = theme.textTheme;

    DateTime minDate = DateTime(DateTime.now().year,DateTime.now().month-7);
    DateTime maxDate = DateTime.now();

    double maxPrice = getHigh(candles);
    double minPrice = getLow(maxPrice, candles);

    double priceFrequency = (maxPrice - minPrice)/7;
    final double frequency =
        (maxDate.millisecondsSinceEpoch.toDouble() -
            minDate.millisecondsSinceEpoch.toDouble()) /
            7;
    final double frequencyData = frequency / 3;
    final double from = minDate.millisecondsSinceEpoch.toDouble();
    return [
      ChartGridLayer(
        settings: ChartGridSettings(
          x: ChartGridSettingsAxis(
            color: theme.dividerColor,
            frequency: frequency,
            max: maxDate.millisecondsSinceEpoch.toDouble(),
            min: minDate.millisecondsSinceEpoch.toDouble(),
          ),
          y: ChartGridSettingsAxis(
              color: theme.dividerColor,
              frequency: priceFrequency,
              max: maxPrice,
              min: minPrice,
              thickness: 1
          ),
        ),
      ),
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: frequency,
            max: maxDate.millisecondsSinceEpoch.toDouble(),
            min: minDate.millisecondsSinceEpoch.toDouble(),
            textStyle: textTheme.bodyText1!.copyWith(
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(

            frequency: priceFrequency,
            max: maxPrice,
            min: minPrice,
            textStyle: textTheme.bodyText1!.copyWith(
              fontSize: 10,
            ),

          ),
        ),
        labelX: (value) => DateFormat('MMM')
            .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
        labelY: (value) =>Formatter.formatPrice(value),
      ),
      ChartCandleLayer(
        items: List.generate(candles.length, (index){
          CandleModel candle = candles[index];
          var x = index ==0? from : from + (index+1)*frequencyData/2.5;
          double min1;
          double max1;
          Color color;
          if(candle.close < candle.open){
            // top is open
            color = Colors.red;
            min1 = candle.open;
            max1 = candle.close;
          }else{
            // top is close
            color = Colors.green;
            min1 = candle.close;
            max1 = candle.open;
          }
          return ChartCandleDataItem(
              color: color,
              value1: ChartCandleDataItemValue(
                  max : max1,
                  min : min1
              ),
              value2: ChartCandleDataItemValue(
                  max: candle.low,
                  min: candle.high
              ),
              x: x
          );
        }),
        settings: const ChartCandleSettings(thickness: 4),
      ),
    ];
  }

  double getHigh(List<CandleModel> candles){
    double result = 0;
    for (var element in candles) {
      if(element.high > result){
        result = element.high;
      }
    }
    return result;
  }

  double getLow(double high,List<CandleModel> candles){
    double result = high;
    for (var element in candles) {
      if(element.low < result){
        result = element.low;
      }
    }
    return result;
  }
}

