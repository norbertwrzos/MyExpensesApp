import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text("\$${spendingAmount.toStringAsFixed(0)}",
                    style: Theme.of(context).textTheme.headline6))),
        SizedBox(height: 4),
        Container(
          height: 80,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPercentageOfTotal,
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15))),
            )
          ]),
        ),
        SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}