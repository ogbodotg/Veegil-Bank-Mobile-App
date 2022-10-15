import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:veebank/models/transactions/transaction_model.dart';
import 'package:veebank/utilities/services.dart';

class TransactionItems extends StatelessWidget {
  final TransactionModel? model;
  const TransactionItems({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Services _services = Services();

    // convert MongoDB timestamp
    DateTime dateTime = _services.getFormattedDateFromFormattedString(
        value: model!.transactionTime,
        currentFormat: "yyyy-MM-ddTHH:mm:ssZ",
        desiredFormat: "MM/dd/yyyy hh:mm a");

    return Container(
      child: ListTile(
        leading: Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text(_services.formatPrice(
              amount: model!.transactionAmount, context: context)),
        ),
        title: Container(
          width: MediaQuery.of(context).size.width / 4.5,
          child: Text('${model!.phoneNumber}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(overflow: TextOverflow.ellipsis)),
        ),
        subtitle: Text('${model!.transactionType}-',
            style: TextStyle(
                color: model!.transactionType == 'Transfer'
                    ? Colors.green
                    : Colors.red)),
        trailing: Column(
          children: [
            Text(
              dateTime.toString(),
              maxLines: 1,
              style: TextStyle(overflow: TextOverflow.ellipsis),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
