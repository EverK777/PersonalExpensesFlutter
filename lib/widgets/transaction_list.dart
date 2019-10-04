import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;

  TransactionList({@required this.userTransactions});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 400,
        child: userTransactions.isEmpty ? Column(children: <Widget>[
          Text('No transactions added yet!', style: Theme.of(context).textTheme.title,),
          Container(
            height:150,
            margin:EdgeInsets.symmetric(
              vertical:30
            ) ,
            child:Image.asset('assets/images/waiting.png', fit: BoxFit.cover,) ,)
        ],)
      :  ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(userTransactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: userTransactions.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
