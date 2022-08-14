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
        title: const Center(child: Text('Exchange Rate')),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
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
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    hintText: '🔍 Search',
                    hintStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blue, width: 2.0),
                          bottom: BorderSide(color: Colors.blue, width: 2.0),
                          right:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                      ),
                      child: const Center(
                          child: Text('Country Name',
                              style: TextStyle(fontSize: 15))),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blue, width: 2.0),
                          bottom: BorderSide(color: Colors.blue, width: 2.0),
                          right:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                      ),
                      child: const Text('Currency',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blue, width: 2.0),
                          bottom: BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      child: const Text('Rate',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
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
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                Image.network(
                                    viewModel
                                        .findImageUrl(viewModel.rates[index]),
                                    width: 30,
                                    height: 20,
                                    fit: BoxFit.cover),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    viewModel.findCountryName(
                                        viewModel.rates[index]),
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                            child: Text(viewModel.rates[index]),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.amberAccent,
                            child: Text(viewModel
                                .conversionRates[viewModel.rates[index]]
                                .toStringAsFixed(1)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 136,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.pinkAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}