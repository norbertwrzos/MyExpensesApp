// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void sumbitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                labelText: "Title",
                focusColor: Theme.of(context).primaryColor
              ),
              controller: titleController,
              onSubmitted: (_) => sumbitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount", focusColor: Theme.of(context).primaryColor),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => sumbitData(),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)),
              onPressed: () {
                if (titleController.text.isEmpty ||
                    double.parse(amountController.text) <= 0) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceTint,
                            title: Text(
                              "Invalid title or amount! Please try again.",
                            ));
                      });
                } else {
                  if (titleController.text.isEmpty ||
                      double.parse(amountController.text) <= 0) {
                    return;
                  }
                }
              },
              child: Text("New Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
