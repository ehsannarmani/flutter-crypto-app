class Formatter{
  static String formatPrice(double price){
    if(price < 0.1){
      return double.parse(price.toString()).toStringAsFixed(7);
    }else if(price < 1){
      return double.parse(price.toString()).toStringAsFixed(5);
    }else if(price > 1 && price < 10){
      return double.parse(price.toString()).toStringAsFixed(3);
    }else{
      return double.parse(price.toString()).toStringAsFixed(2);
    }
  }
  static String formatPercent(double percent){
    if(percent < 1){
      return double.parse(percent.toString()).toStringAsFixed(2);
    }else {
      return double.parse(percent.toString()).toStringAsFixed(0);
    }
  }
  static String formatNumber(double? num){
    if(num == null) return "-";
      if (num > 999 && num < 99999) {
        return "${(num / 1000).toStringAsFixed(1)} K";
      } else if (num > 99999 && num < 999999) {
        return "${(num / 1000).toStringAsFixed(0)} K";
      } else if (num > 999999 && num < 999999999) {
        return "${(num / 1000000).toStringAsFixed(1)} M";
      } else if (num > 999999999) {
        return "${(num / 1000000000).toStringAsFixed(1)} B";
      } else {
        return num.toString();
      }
  }
  static String limitText(text,limit){
    return text.length > limit ? text.substring(0, limit)+'...' : text;
  }
}