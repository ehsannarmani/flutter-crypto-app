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
  static String limitText(text,limit){
    return text.length > limit ? text.substring(0, limit)+'...' : text;
  }
}