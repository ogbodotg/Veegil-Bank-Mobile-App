import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:veebank/models/transactions/transaction_model.dart';
import 'package:veebank/services/api_services/api_services.dart';
import 'package:veebank/utilities/services.dart';
import 'package:veebank/widget/transaction_items.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);
  static const String id = "transactions-page";

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  Services _services = Services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _services.appBar(
        title: 'My Transactions',
        logout: Icons.logout_outlined,
        context: context,
      ),
      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: loadTransactions()),
    );
  }

  Widget loadTransactions() {
    return FutureBuilder(
        future: APIService.getTransactions(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<TransactionModel>?> model,
        ) {
          if (model.hasData) {
            return transactionsList(model.data);
          }
          if (!model.hasData) {
            return const Center(child: Text('No transaction'));
          }
          if (model.hasError) {
            return const Center(
              child: Text('Error loading transactions'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget transactionsList(transactions) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionItems(model: transactions[index]);
            },
          )
        ],
      ),
    );
  }
}
