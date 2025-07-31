import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/appbaprofil/appbaprofil_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'abonelik_copy_widget.dart' show AbonelikCopyWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AbonelikCopyModel extends FlutterFlowModel<AbonelikCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbaprofil component.
  late AppbaprofilModel appbaprofilModel;

  @override
  void initState(BuildContext context) {
    appbaprofilModel = createModel(context, () => AppbaprofilModel());
  }

  @override
  void dispose() {
    appbaprofilModel.dispose();
  }
}
