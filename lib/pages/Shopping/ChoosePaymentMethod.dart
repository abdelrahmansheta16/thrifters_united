import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/pages/Shopping/PlaceOrder.dart';

class ChoosePaymentMethod extends StatefulWidget {
  final String userID;
  const ChoosePaymentMethod({Key key, this.userID}) : super(key: key);

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  static List<String> PaymentMethod = ['CreditCard', 'Cash'];
  String _method = PaymentMethod.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Choose Payment Method',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: PaymentMethod.length,
        itemBuilder: (BuildContext context, int index) {
          String paymentMethod = PaymentMethod[index];
          return ListTile(
            title: Text(paymentMethod),
            leading: Radio<String>(
              value: paymentMethod,
              groupValue: _method,
              onChanged: (String value) {
                setState(() {
                  _method = value;
                });
              },
            ),
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: <Widget>[
      //       ListTile(
      //         title: const Text('Credit Card'),
      //         leading: Radio<PaymentMethod>(
      //           value: PaymentMethod.CreditCard,
      //           groupValue: _method,
      //           onChanged: (PaymentMethod value) {
      //             setState(() {
      //               _method = value;
      //             });
      //           },
      //         ),
      //       ),
      //       ListTile(
      //         title: const Text('Cash'),
      //         leading: Radio<PaymentMethod>(
      //           value: PaymentMethod.Cash,
      //           groupValue: _method,
      //           onChanged: (PaymentMethod value) {
      //             setState(() {
      //               _method = value;
      //             });
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        elevation: 3,
        child: TextButton(
          onPressed: () {
            Provider.of<OrderAPI>(context, listen: false)
                .addPaymentMethod(_method);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => PlaceOrder(
                        userID: widget.userID,
                      )),
            );
          },
          child: Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
