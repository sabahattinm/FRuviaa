import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/ad/ad_widget.dart';
import 'anasayfa_copy_copy_widget.dart' show AnasayfaCopyCopyWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnasayfaCopyCopyModel extends FlutterFlowModel<AnasayfaCopyCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AD component.
  late AdModel adModel;

  @override
  void initState(BuildContext context) {
    adModel = createModel(context, () => AdModel());
  }

  @override
  void dispose() {
    adModel.dispose();
  }
}
