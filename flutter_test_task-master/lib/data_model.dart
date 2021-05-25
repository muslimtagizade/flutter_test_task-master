class Btc {
  Btc({
    this.symbol,
    this.lastPrice,
  });

  String symbol;

  String lastPrice;

  factory Btc.fromJson(Map<String, dynamic> json) => Btc(
        symbol: json["symbol"],
        lastPrice: json["lastPrice"],
      );
}
