import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class NotificationSubscriptionContainer extends StatefulWidget {
  const NotificationSubscriptionContainer({Key key}) : super(key: key);

  @override
  State<NotificationSubscriptionContainer> createState() =>
      _NotificationSubscriptionContainerState();
}

class _NotificationSubscriptionContainerState
    extends State<NotificationSubscriptionContainer> {
  TextEditingController textController;

  bool enableEditing = false;

  bool switchListTileValue = true;
  bool isAsyncCall = false;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications and Subscription',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFB6B6B6),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: buildSwitchListTile(),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 12,
          thickness: 10,
          color: Color(0xFFDEDEDE),
        )
      ],
    );
  }

  dynamic buildSwitchListTile() {
    return isAsyncCall
        ? JumpingDotsProgressIndicator(
            fontSize: 30,
            milliseconds: 0,
          )
        : SwitchListTile(
            value: switchListTileValue,
            onChanged: (newValue) async {
              setState(() {
                isAsyncCall = true;
              });
              if (newValue) {
                await FirebaseMessaging.instance
                    .subscribeToTopic('newsletters');
              } else {
                await FirebaseMessaging.instance
                    .unsubscribeFromTopic('newsletters');
              }
              setState(() {
                isAsyncCall = false;
                switchListTileValue = newValue;
              });
            },
            title: Text(
              'Subscribe to newsletters and get latest sales',
              style: FlutterFlowTheme.title3.override(
                fontFamily: 'Poppins',
                color: Color(0xFF303030),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            tileColor: Colors.white,
            activeColor: Color(0xFF50B28D),
            controlAffinity: ListTileControlAffinity.trailing,
          );
  }
}
