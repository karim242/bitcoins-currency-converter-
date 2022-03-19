import'package:http/http.dart'as http;
import 'dart:convert';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

  class CoinData {

   Future getCoinData(String selectedCurrency)async{
     Map<String, String> cryptoPrices = {};
     for (String crypto in cryptoList) {
     String repuestURL='https:https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD';

     http.Response response=await http.get(repuestURL);
     if(response.statusCode==200){
       var decodedData = jsonDecode(response.body);
       double lastPrice = decodedData['last'];
       cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
     } else {
       print(response.statusCode);
       throw 'Problem with the get request';
     }
   }
   return cryptoPrices;
  }
}
