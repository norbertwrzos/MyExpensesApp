import 'dart:math';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 15,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionsValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    (data["day"] as String),
                    (data["amount"] as double),
                    maxSpending == 0.0
                        ? 0.0
                        : (data["amount"] as double) / maxSpending,
                  ),
                );
              }).toList(),
            ),
          ),
          Column(
            children: [
              Text("This week you've already spent:",
                  style: Theme.of(context).textTheme.headline6),
              Text("\$${maxSpending.toStringAsFixed(0)}",
                  style: Theme.of(context).textTheme.headline6)
            ],
          )
        ],
      ),
    );
  }
}
