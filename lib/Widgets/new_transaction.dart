import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _itemController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateController;

  void _addTransaction() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredItem = _itemController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredItem.isEmpty || enteredAmount <= 0 || _dateController == null) {
      return;
    } else {
      widget.addTx(enteredItem, enteredAmount, _dateController);
    }
    Navigator.of(context).pop();
  }

  void _activateDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _dateController = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Title'),
          controller: _itemController,
          onSubmitted: (_) => _addTransaction(),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Amount'),
          controller: _amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _addTransaction(),
        ),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _dateController == null
                      ? 'No date selected.'
                      : 'Selected date: ${DateFormat.yMMMd().format(_dateController!)}',
                ),
              ),
              TextButton(
                onPressed: _activateDatePicker,
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: const Text('Choose Date'),
              )
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: _addTransaction,
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.labelLarge?.color),
            ),
            child: const Text('Add Transaction'),
          ),
        ),
      ],
    );
  }
}
