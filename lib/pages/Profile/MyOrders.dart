import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/customUi/GuestUser.dart';
import 'package:thrifters_united/customUi/AccountInfoContainer.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import '../../FirebaseAPI/AuthenticationAPI.dart';
import '../../customUi/OrderDetails.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'MyOrder',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      body: Consumer<AuthenticationAPI>(
        builder: (context, model, child) {
          if (model.user == null) {
            return GuestUser();
          }
          return StreamBuilder<QuerySnapshot<Order>>(
            stream: OrderAPI.loadOrders(userID: model.user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return NoOrders();
              }
              List<Order> orders =
                  snapshot.data.docs.map((DocumentSnapshot document) {
                Order order;
                order = document.data();
                order.orderID = document.id;
                return order;
              }).toList();
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    Order currentOrder = orders[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OrderDetails(
                                    order: currentOrder,
                                  )),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: Text(
                                  '${currentOrder.orderedOn.day / currentOrder.orderedOn.month / currentOrder.orderedOn.year}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF6B6B6B),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Order#: ',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                  Text(
                                    currentOrder.orderID,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Totals: ',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                  Text(
                                    currentOrder.price.toStringAsFixed(2),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF03CE9F),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_sharp),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                currentOrder.status,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: getColor(currentOrder.status),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(
                                        currentOrder.products.length, (index) {
                                      Product currentProduct =
                                          currentOrder.products[index];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: Image.network(
                                          currentProduct.images[0],
                                          width: 70,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // string: 'Order #' + (index + 1).toString(),;
                  });
            },
          );
        },
      ),
    );
  }

  Color getColor(String status) {
    Color color;
    switch (status) {
      case "BeingProcessed":
        color = Colors.black;
        break;
      case "OnItsWay":
        color = Colors.orange;
        break;
      case "Delivered":
        color = Colors.green;
        break;
      default:
        color = Colors.red;
    }
    return color;
  }
}

class NoOrders extends StatelessWidget {
  const NoOrders({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Icon(
                  Icons.add_shopping_cart,
                  color: Color(0xFF6B6B6B),
                  size: 150,
                ),
              ),
              Text(
                'No Orders Yet !',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Looks like you haven\'t made your first order yet',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF6B6B6B),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              FFButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Continue Shopping',
                options: FFButtonOptions(
                  width: 200,
                  height: 40,
                  color: Colors.black,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
