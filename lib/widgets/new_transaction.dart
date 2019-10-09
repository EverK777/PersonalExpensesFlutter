import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final FocusNode _titleFocus = FocusNode();

  final FocusNode _amountFocus = FocusNode();

  DateTime _selectedDate;

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _createNewTransaction() {
    if (_amountController.text.isEmpty) {
      return;
    }
      final title = _titleController.text;
      final amount = double.parse(_amountController.text);
      if (title.isEmpty || amount <= 0 || _selectedDate == null){
        return;
    }
    widget.addTx(title, amount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              // onChanged:(value) => _tittleInput = value,
              /*   onSubmitted: (term) {
                _fieldFocusChange(context, _titleFocus, _amountFocus);
              },*/
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.text,
            ),
            TextField(
                controller: _amountController,
                textInputAction: TextInputAction.done,
                // onChanged:(value) => _amountInput = value,
                onSubmitted: (_) => _createNewTransaction(),
                //method when keyboard is pressed ok
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                )),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(_selectedDate == null
                      ? 'No date choosen!'
                      :'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => _presentDatePicker(),
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add transaction'),
              color: Colors.deepOrange,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () => _createNewTransaction(),
            )
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
