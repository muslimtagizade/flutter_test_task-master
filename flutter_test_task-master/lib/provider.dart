import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_task/data_model.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

abstract class BtcModel extends ChangeNotifier {
  List<Btc> _btcList = List<Btc>.empty(growable: true); //! ürün listesi

  List<Btc> get btcList;
  String get btcv;
  void cartGet(); //!ürünleri çeker

}

class BtcModelImplementation extends BtcModel {
  var data;

  List<Btc> _btcList = List<Btc>.empty();
  var btc;
  List<Btc> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Btc>((json) => Btc.fromJson(json)).toList();
  }

  Future<List<Btc>> fetchPhotos(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://api.binance.com/api/v3/ticker/24hr'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return _btcList = parsePhotos(response.body).toList();
  }

  BtcModelImplementation() {
    Future.delayed(Duration(seconds: 3)).then((_) => getIt.signalReady(this));
  }

  @override
  List<Btc> get btcList => _btcList;
  String get btcv => btc;

  @override
  void cartGet() async {
    await fetchPhotos(http.Client());

    btc = _btcList[_btcList.indexWhere((e) => e.symbol == 'BTCUSDT')].lastPrice;
    notifyListeners();
  }
}
