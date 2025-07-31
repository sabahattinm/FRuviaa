import '/backend/api_requests/api_manager.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

Future de(BuildContext context) async {
  context.pushNamed(
    Profile05Widget.routeName,
    extra: <String, dynamic>{
      kTransitionInfoKey: TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 300),
      ),
    },
  );
}

Future vf(BuildContext context) async {
  Navigator.pop(context);

  context.pushNamed(HomePageWidget.routeName);
}

Future deneme(BuildContext context) async {}

Future analiz(BuildContext context) async {}
