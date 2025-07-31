import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/ad/ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'list06_user_search_copy2_model.dart';
export 'list06_user_search_copy2_model.dart';

class List06UserSearchCopy2Widget extends StatefulWidget {
  const List06UserSearchCopy2Widget({super.key});

  static String routeName = 'List06UserSearchCopy2';
  static String routePath = '/list06UserSearchCopy2';

  @override
  State<List06UserSearchCopy2Widget> createState() =>
      _List06UserSearchCopy2WidgetState();
}

class _List06UserSearchCopy2WidgetState
    extends State<List06UserSearchCopy2Widget> {
  late List06UserSearchCopy2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => List06UserSearchCopy2Model());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: wrapWithModel(
          model: _model.adModel,
          updateCallback: () => safeSetState(() {}),
          child: AdWidget(),
        ),
      ),
    );
  }
}
