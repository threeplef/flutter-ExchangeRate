import 'package:exchange_rate/debounce.dart';
import 'package:exchange_rate/view_model/exchange_rate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  final _textController = TextEditingController();

  final _debounce = Debounce(milliseconds: 500);


  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExchangeRateViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("환율조회"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
            child: TextField(
              controller: _textController,
              onChanged: _debounce.run(() => setState(() {
                viewModel.fetchConversionRates(_textController.text);
              })),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                hintText: '검색',
                hintStyle: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  color: Colors.blue,
                  child: const Text("국가명"),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  color: Colors.red,
                  child: const Text("통화"),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  color: Colors.amber,
                  child: const Text("환산율"),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.rates.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //국가명
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              viewModel
                                  .findImageUrl(viewModel.rates[index]),
                              width: 30,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                viewModel.findCountryName(
                                    viewModel.rates[index]),
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //통화코드
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        color: Colors.red,
                        child: Text(viewModel.rates[index]),
                      ),
                    ),
                    //미화 환산율
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        color: Colors.amber,
                        child: Text(viewModel
                            .conversionRates[viewModel.rates[index]]
                            .toString()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}