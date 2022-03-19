import'package:flutter/material.dart';
import 'coin_data.dart';

class priceScreen extends StatefulWidget {
  @override
  _priceScreenState createState() => _priceScreenState();
}

class _priceScreenState extends State<priceScreen> {
  String selsectCurrency='USD';

  List<DropdownMenuItem>getDropdownItems(){
    List<DropdownMenuItem<String>>dropdownItems=[];

    for(String currency in currenciesList){
      var newitem=DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newitem);
    }
    return dropdownItems;
  }
  Map<String, String> coinValues = {};
  bool isWaiting = false;
  String bitcoinValueInUSD='?';

void getData()async{
  isWaiting=true;
    try {
      double data = await CoinData().getCoinData(selsectCurrency);
      bitcoinValueInUSD=data.toStringAsFixed(0);
      isWaiting=false;
      setState(() {
        coinValues = data as Map<String, String>;
      });
    }catch(e){
      print(e);
    }
}
@override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CryptoCard(
            cryptoCurrency: 'BTC',
            value: isWaiting ? '?' : coinValues['BTC'],
            selectedCurrency: selsectCurrency,
          ),
          CryptoCard(
            cryptoCurrency: 'ETH',
            value: isWaiting ? '?' : coinValues['ETH'],
              selectedCurrency: selsectCurrency,),
          CryptoCard(
              cryptoCurrency: 'LTC',
              value: isWaiting ? '?' : coinValues['LTC'],
              selectedCurrency: selsectCurrency,),
          ],),
          Container(
              height: 120.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: DropdownButton<String>(
                value: selsectCurrency,
                items: getDropdownItems(),
                onChanged: (value){
                  setState(() {
                    selsectCurrency=value;
                    getData();
                  });
                },
              )
          )
        ],
      ),
    );
  }
}
class CryptoCard extends StatelessWidget {

  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}