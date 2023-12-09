import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/Farmer/FarmerModule.dart';
import 'package:helping_hands/Farmer/Productmodule.dart';
import 'package:helping_hands/constants/constansts/pallate.dart';
import 'package:helping_hands/users/authContoller.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_exception.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final FarmerModule farmerModule;
  final ProductModule productModule;
  PaymentScreen(
      {required this.farmerModule, required this.productModule, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PaymentScreen();
  }
}

class _PaymentScreen extends ConsumerState<PaymentScreen> {
  void sendOrder({
    required ProductModule productModule,
    required String FarmerName,
    required String FarmerId,
    required String FarmerLati,
    required String FarmerLogi,
  }) async {
    ref.watch(AuthContoller.notifier).sendOrderDetails(
          context: context,
          productModule: productModule,
          FarmerName: FarmerName,
          FarmerId: FarmerId,
          FarmerLati: FarmerLati,
          FarmerLogi: FarmerLogi,
        );
  }

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "lokhanderohit2020@oksbi",
      receiverName: widget.farmerModule.name,
      transactionRefId: 'Helping Hands',
      transactionNote: 'Get ease to success',
      amount: 1,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        showSnackBar("Transaction Successful", context);
        sendOrder(
          productModule: widget.productModule,
          FarmerName: widget.farmerModule.name,
          FarmerId: widget.farmerModule.FarmerUid,
          FarmerLati: widget.farmerModule.Farmerlati,
          FarmerLogi: widget.farmerModule.FarmerLogi,
        );

        // Replace with your screen widget

        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        showSnackBar('Transaction Submitted', context);
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        sendOrder(
          productModule: widget.productModule,
          FarmerName: widget.farmerModule.name,
          FarmerId: widget.farmerModule.FarmerUid,
          FarmerLati: widget.farmerModule.Farmerlati,
          FarmerLogi: widget.farmerModule.FarmerLogi,
        );

        showSnackBar('Transaction Failed', context);
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder:
                  (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        style: header,
                      ), // Print's text message on screen
                    );
                  }

                  // If we have data then definitely we will have UpiResponse.
                  // It cannot be null
                  UpiResponse _upiResponse = snapshot.data!;

                  // Data in UpiResponse can be null. Check before printing
                  String txnId = _upiResponse.transactionId ?? 'N/A';
                  String resCode = _upiResponse.responseCode ?? 'N/A';
                  String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                  String status = _upiResponse.status ?? 'N/A';
                  String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                  _checkTxnStatus(status);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        displayTransactionData('Transaction Id', txnId),
                        displayTransactionData('Response Code', resCode),
                        displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        displayTransactionData('Approval No', approvalRef),
                      ],
                    ),
                  );
                } else
                  return Center(
                    child: Text(''),
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}
