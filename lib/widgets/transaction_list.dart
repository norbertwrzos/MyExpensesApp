// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text("No transactions added yet!",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: 180,
                          child: Image.asset(
                            "assets/images/waiting.png",
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      color: Theme.of(context).colorScheme.surface,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text(
                                "\$${transactions[index].amount.toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                        ),
                        title: Text(transactions[index].title,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Text(
                          DateFormat("dd.MM.yyyy")
                              .format(transactions[index].date),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: Colors.grey.shade700),
                        ),
                      ));
                },
                itemCount: transactions.length,
              ));
  }
}
