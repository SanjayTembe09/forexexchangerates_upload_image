import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/exchangerate.dart';
import 'package:myapp/auth/auth_form.dart' ;


class RateList extends StatefulWidget {
  const RateList({super.key});

  @override
  State<RateList> createState() => _RateListState();
}

class _RateListState extends State<RateList> {
  late Future<ExchangeRate> exchangeRateFuture;

  @override
  void initState() {
    super.initState();
    exchangeRateFuture = fetchExchangeRate();
  }

  Future<ExchangeRate> fetchExchangeRate() async {
    const apiKey = '85edb0317a72e6cada0c78df'; // Replace with your API key
    final response = await http.get(
        Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/THB'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final exchangeRateData =
          jsonResponse['conversion_rates'] as Map<String, dynamic>;

      // Invert rates to get THB as base
      final invertedRates = exchangeRateData.map((key, value) {
        return MapEntry(key, 1 / value);
      });

      return ExchangeRate(
        base: 'THB',
        conversionRates: invertedRates,
      );
    } else {
      throw Exception('Failed to load exchange rates: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () {
              // TODO: Implement upload logic
              print('Upload button pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to app_form.dart
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthForm()),
                  );
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload Rate Image'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<ExchangeRate>(
              future: exchangeRateFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: 
 CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final 
 exchangeRate = snapshot.data!;
                  final rates = exchangeRate.conversionRates.entries.toList();
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text('Currency')),
                      DataColumn(label: Text('Exchange Rate')),
                    ],
                    rows: rates.map((rateEntry) {
                      final currency = rateEntry.key;
                      final rateValue = rateEntry.value;
                      return DataRow(
                        cells: [
                          DataCell(SelectableText(currency)),
                          DataCell(SelectableText(
                              '${rateValue.toStringAsFixed(2)} THB')),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}