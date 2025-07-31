import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/ad/ad_widget.dart';
import 'list06_user_search_copy2_widget.dart' show List06UserSearchCopy2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class List06UserSearchCopy2Model
    extends FlutterFlowModel<List06UserSearchCopy2Widget> {
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
