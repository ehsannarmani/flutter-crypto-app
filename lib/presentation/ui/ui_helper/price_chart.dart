import 'dart:math';

import 'package:crypto_app/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';

import '../../utils/formatter.dart';


class PriceChart extends StatelessWidget {
  List<double> prices;
  double price;
  PriceChart({Key? key,required this.price,required this.prices}) : super(key: key);
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double maxPrice = getHigh();
    double minPrice = getLow(maxPrice);

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Formatter.formatPrice(maxPrice),style: textTheme.bodyText1!.copyWith(
                fontSize: 10,
              ),),
              Text(Formatter.formatPrice(minPrice),style: textTheme.bodyText1!.copyWith(
                fontSize: 10,
              ),),
            ],
          ),
          const SizedBox(width: 5,)
          ,
          Expanded(child: LineChart(mainData(minPrice,maxPrice,price)))
        ],
      ),
    );
  }
  LineChartData mainData(double minPrice,double maxPrice,double price) {


    var diff = (350*price)/20000;
    double minY = minPrice-diff;
    double maxY = maxPrice+diff;
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (a,b)=>Container(),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (a,b)=>Container(),
            reservedSize: 0,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: prices.length-1.toDouble(),
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            prices.length,(index){
            return FlSpot(index.toDouble(), prices[index]);
          }),
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
  double getHigh(){
    double result = 0;
    prices.forEach((element) {
      if(element > result){
        result = element;
      }
    });
    return result;
  }
  double getLow(double high){
    double result = high;
    prices.forEach((element) {
      if(element < result){
        result = element;
      }
    });
    return result;
  }
}

