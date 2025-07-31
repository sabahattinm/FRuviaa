import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/pages/oneboarddilekran/oneboarddilekran_widget.dart';
import '/pages/oneboardabonelik/oneboardabonelik_widget.dart';
import '/pages/oneboardgaleri/oneboardgaleri_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Focus widget keys for this walkthrough
final iconDrzhfdxh = GlobalKey();
final icon9arvwbsd = GlobalKey();
final buttonU338uv1a = GlobalKey();

/// buton
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// ikinci adım: burada ilk buton tanıtılacak
      TargetFocus(
        keyTarget: iconDrzhfdxh,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomCenter,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, __) => OneboarddilekranWidget(),
          ),
        ],
      ),

      /// 3 adım: burada ikinci buton tanıtılacak
      TargetFocus(
        keyTarget: icon9arvwbsd,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomLeft,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => OneboardabonelikWidget(),
          ),
        ],
      ),

      /// step 1: gu
      TargetFocus(
        keyTarget: buttonU338uv1a,
        enableOverlayTab: true,
        alignSkip: Alignment.topCenter,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => OneboardgaleriWidget(),
          ),
        ],
      ),
    ];
