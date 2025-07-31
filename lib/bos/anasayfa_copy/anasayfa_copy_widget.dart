import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/ad/ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'anasayfa_copy_model.dart';
export 'anasayfa_copy_model.dart';

class AnasayfaCopyWidget extends StatefulWidget {
  const AnasayfaCopyWidget({super.key});

  static String routeName = 'anasayfaCopy';
  static String routePath = '/anasayfaCopy';

  @override
  State<AnasayfaCopyWidget> createState() => _AnasayfaCopyWidgetState();
}

class _AnasayfaCopyWidgetState extends State<AnasayfaCopyWidget> {
  late AnasayfaCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnasayfaCopyModel());
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
        drawer: Drawer(
          elevation: 16.0,
        ),
        body: SafeArea(
          top: true,
          child: wrapWithModel(
            model: _model.adModel,
            updateCallback: () => safeSetState(() {}),
            child: AdWidget(),
          ),
        ),
      ),
    );
  }
}
