import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final FocusNode _titleFocus = FocusNode();

  final FocusNode _amountFocus = FocusNode();

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void createNewTransaction(){
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if(title.isEmpty || amount <=0 ){
      return;
    }
    widget.addTx(title,amount );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              // onChanged:(value) => _tittleInput = value,
           /*   onSubmitted: (term) {
                _fieldFocusChange(context, _titleFocus, _amountFocus);
              },*/
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.text,
            ),
            TextField(
                controller: amountController,
                textInputAction: TextInputAction.done,
                // onChanged:(value) => _amountInput = value,
                onSubmitted: (_)  => createNewTransaction(),
                  //method when keyboard is pressed ok
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                )),
            FlatButton(
              child: Text('Add transaction'),textColor: Colors.deepOrange,
              onPressed: ()  => createNewTransaction(),
            )
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}