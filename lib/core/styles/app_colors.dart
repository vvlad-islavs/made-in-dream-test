import 'package:flutter/material.dart';

abstract final class AppColors {
  static const transparent = Color(0x00000000);

  static final colorSemantic = _SemanticColors();

  static const gray = MaterialColor(0xff656565, <int, Color>{
    50: Color(0xfffafafa),
    100: Color(0xffe7e7e7),
    200: Color(0xffc8c8c8),
    300: Color(0xffa4a4a4),
    400: Color(0xff828282),
    500: Color(0xff656565),
    600: Color(0xff515151),
    700: Color(0xff3d3d3d),
    800: Color(0xff2e2e2e),
    900: Color(0xff212121),
    950: Color(0xff151515),
  });

  static const red = MaterialColor(0xffdb2c2c, <int, Color>{
    50: Color(0xfffff0f0),
    100: Color(0xffffd1d1),
    200: Color(0xffffa8a8),
    300: Color(0xfff97979),
    400: Color(0xfff04a4a),
    500: Color(0xffdb2c2c),
    600: Color(0xffba2626),
    700: Color(0xff981f1f),
    800: Color(0xff751818),
    900: Color(0xff551212),
    950: Color(0xff3a0c0c),
  });

  static const yellow = MaterialColor(0xffeab308, <int, Color>{
    50: Color(0xfffff9e5),
    100: Color(0xfffff1c2),
    200: Color(0xffffe277),
    300: Color(0xffffd24b),
    400: Color(0xffffc22a),
    500: Color(0xffeab308),
    600: Color(0xffc99907),
    700: Color(0xffa17e05),
    800: Color(0xff7c6104),
    900: Color(0xff574403),
    950: Color(0xff3b2e02),
  });

  static const green = MaterialColor(0xff31b85c, <int, Color>{
    50: Color(0xffedfff3),
    100: Color(0xffcbf7db),
    200: Color(0xffa0efc0),
    300: Color(0xff75e4a1),
    400: Color(0xff48d982),
    500: Color(0xff31b85c),
    600: Color(0xff29974d),
    700: Color(0xff227c3f),
    800: Color(0xff1a6131),
    900: Color(0xff134824),
    950: Color(0xff0d3118),
  });

  static const royalBlue = MaterialColor(0xff465fe0, <int, Color>{
    50: Color(0xffeef3ff),
    100: Color(0xffd7e2ff),
    200: Color(0xffb6c8ff),
    300: Color(0xff8eabff),
    400: Color(0xff678dfa),
    500: Color(0xff465fe0),
    600: Color(0xff3a51be),
    700: Color(0xff30449a),
    800: Color(0xff253675),
    900: Color(0xff1b2955),
    950: Color(0xff131c3c),
  });

  static const orange = MaterialColor(0xfff97316, <int, Color>{
    50: Color(0xfffff5ed),
    100: Color(0xffffe1c9),
    200: Color(0xffffc08f),
    300: Color(0xffffa057),
    400: Color(0xffff832e),
    500: Color(0xfff97316),
    600: Color(0xffd16212),
    700: Color(0xffa94f0e),
    800: Color(0xff813c0b),
    900: Color(0xff5c2b08),
    950: Color(0xff3d1c06),
  });

  static const purple = MaterialColor(0xff8b5cf6, <int, Color>{
    50: Color(0xfff4f1ff),
    100: Color(0xffe6e1fe),
    200: Color(0xffd0c0fe),
    300: Color(0xffb999fd),
    400: Color(0xffa07afd),
    500: Color(0xff8b5cf6),
    600: Color(0xff7c3aed),
    700: Color(0xff6d28d9),
    800: Color(0xff5b21b6),
    900: Color(0xff4c1d95),
    950: Color(0xff3b1675),
  });

  static const zink = MaterialColor(0xff2e2e33, <int, Color>{
    50: Color(0xffdadadf),
    100: Color(0xffbabac2),
    200: Color(0xff878792),
    300: Color(0xff61616b),
    400: Color(0xff393940),
    500: Color(0xff2e2e33),
    600: Color(0xff27272b),
    700: Color(0xff1f1f23),
    800: Color(0xff19191b),
    900: Color(0xff131314),
    950: Color(0xff0c0c0d),
  });

  // СТАРЫЕ И УСТАРЕВШИЕ ЦВЕТА

  static const redAlias = MaterialColor(0xffFF435A, <int, Color>{
    25: Color(0xffFFF6F7),
    50: Color(0xffFFECEE),
    100: Color(0xffFFD9DE),
    200: Color(0xffFFB4BD),
    300: Color(0xffFF8E9C),
    400: Color(0xffFF697B),
    500: Color(0xffFF435A),
    600: Color(0xffCC3648),
    700: Color(0xff992836),
    800: Color(0xff661B24),
    900: Color(0xff330D12),
  });

  static const yellowAlias = MaterialColor(0xffFFE433, <int, Color>{
    25: Color(0xffFFFEF5),
    50: Color(0xffFFFCEB),
    100: Color(0xffFFFAD6),
    200: Color(0xffFFF4AD),
    300: Color(0xffFFEF85),
    400: Color(0xffFFE95C),
    500: Color(0xffFFE433),
    600: Color(0xffCCB629),
    700: Color(0xff99891F),
    800: Color(0xff665B14),
    900: Color(0xff332E0A),
  });

  static const greenAlias = MaterialColor(0xff41F6AA, <int, Color>{
    25: Color(0xffF5FFFB),
    50: Color(0xffECFEF6),
    100: Color(0xffD9FDEE),
    200: Color(0xffB3FBDD),
    300: Color(0xff8DFACC),
    400: Color(0xff67F8BB),
    500: Color(0xff41F6AA),
    600: Color(0xff34C588),
    700: Color(0xff279466),
    800: Color(0xff1A6244),
    900: Color(0xff0D3122),
  });

  static const blueAlias = MaterialColor(0xff4375FF, <int, Color>{
    25: Color(0xffF6F8FF),
    50: Color(0xffECF1FF),
    100: Color(0xffD9E3FF),
    200: Color(0xffB4C8FF),
    300: Color(0xff8EACFF),
    400: Color(0xff6991FF),
    500: Color(0xff4375FF),
    600: Color(0xff365ECC),
    700: Color(0xff284699),
    800: Color(0xff1B2F66),
    900: Color(0xff0D1733),
  });

  static const orangeAlias = MaterialColor(0xffFF5F2D, <int, Color>{
    25: Color(0xffFFF7F4),
    50: Color(0xffFFEFEA),
    100: Color(0xffFFDFD5),
    200: Color(0xffFFBFAB),
    300: Color(0xffFF9F81),
    400: Color(0xffFF7F57),
    500: Color(0xffFF5F2D),
    600: Color(0xffCC4C24),
    700: Color(0xff99391B),
    800: Color(0xff662612),
    900: Color(0xff331309),
  });

  static const purpleAlias = MaterialColor(0xff714CDE, <int, Color>{
    25: Color(0xffF8F5FD),
    50: Color(0xffF1ECFC),
    100: Color(0xffE3D9F8),
    200: Color(0xffC6B3F2),
    300: Color(0xffAA8EEB),
    400: Color(0xff8D68E5),
    500: Color(0xff714CDE),
    600: Color(0xff5A3DB2),
    700: Color(0xff442885),
    800: Color(0xff2D1A59),
    900: Color(0xff170D2C),
  });

  static const grayAlias = MaterialColor(0xff222426, <int, Color>{
    25: Color(0xffD0D2D9),
    50: Color(0xffBCBFC4),
    100: Color(0xffA8AAAF),
    200: Color(0xff6b6f78),
    300: Color(0xff505259),
    400: Color(0xff2D2F33),
    500: Color(0xff222426),
    600: Color(0xff1E2022),
    700: Color(0xff1A1B1D),
    800: Color(0xff161719),
    900: Color(0xff121314),
  });

  static const white = Color(0xffF8F8F8);
  static const buttonPrimaryFilledPressedBg = Color(0xff5A35B2);
  static const buttonPrimaryFilledBg = Color(0xff7142DE);
  static const buttonPrimaryTextText = Color(0xffAA8EEB);
  static const buttonPrimaryTextIcon = Color(0xffAA8EEB);
  static const buttonPrimaryText = Color(0xffF8F5FD);
  static const buttonPrimaryIcon = Color(0xffF8F5FD);
  static const backgroundCore = Color(0xFF0C0C0D);
  static const backgroundBase = Color(0xFF121314);
  static const backgroundSurface = Color(0xFF161719);
  static const cardBackground = Color(0xFF1A1B1D);
  static const cardHighlightBackground = Color(0xFF2D2F33);
  static const cardCaptionText = Color(0xFF6B6F78);
  static const cardSupportingText = Color(0xFFBCBFC4);
  static const cardBodyText = Color(0xFFFEFEFE);
  static const dialogCloseButtonColor = Color(0xffFF697B);
  static const sliderActiveColor = Color(0xffAA8EEB);
  static const sliderInactiveColor = Color(0xff1E2022);
  static const sliderSecondaryActiveColor = Color(0xff1E2022);
  static const buttonNeutralText = Color(0xffD0D2D9);
  static const buttonNeutralIcon = Color(0xffD0D2D9);
  static const buttonNeutralDisabledText = Color(0xff505259);
  static const buttonNeutralDisabledIcon = Color(0xff505259);
  static const buttonNeutralDisabledFilledBg = Color(0xff2d2f33);
  static const buttonNeutralDisabledBorderBg = Color(0xff1e2022);
  static const buttonNeutralEnabledBorderBg = Color(0xff2D2F33);
  static const buttonNeutralEnabledFilledBg = Color(0xff222426);
  static const buttonNeutralPressedBg = Color(0xff1E2022);
  static const fabBackgroundColor = Color(0xff1A1B1D);
  static const cachingSpaceColor = Color(0xffB5B5B5);
  static const sliderColor = Color(0xff7C4CED);
  static const baseShimmerColor = Color(0xff1E2022);
  static const highlightShimmerColor = Color(0xff26272A);

  static const textSecondary = Color(0xff808BFF);
  static const baseSecondary = Color(0xff2D2F33);
  static const baseQuaternary = Color(0xff222426);
  static const surfaceTertiaryColor = Color(0xff1A1A1A);
  static const woodSmoke600 = Color(0xff545564);
  static const woodSmoke800 = Color(0xff2E2F38);
  static const woodSmoke900 = Color(0xff22232A);
  static const woodSmoke1000 = Color(0xff19191C);
  static const lime40 = Color(0xff8BCF42);
  static const backgroundPrimary = Color(0xff5865F2);
  static const aimColor = Color(0xff1E1E22);

  @Deprecated('Use purpleAlias instead')
  static const purple100 = Color(0xffbca1f8);
  @Deprecated('Use purpleAlias instead')
  static const purple300 = Color(0xff9b71f4);
  @Deprecated('Use purpleAlias instead')
  static const purple400 = Color(0xffAB47BC);
  @Deprecated('Use purpleAlias instead')
  static const purple500 = Color(0xff7942f0);
  @Deprecated('Use purpleAlias instead')
  static const purple600 = Color(0xff8E24AA);
  @Deprecated('Use purpleAlias instead')
  static const purple700 = Color(0xff6d3bd8);
  @Deprecated('Use orangeAlias instead')
  static const orange500 = Color(0xffF86938);
  @Deprecated('Use redAlias instead')
  static const red300 = Color(0xffFB697B);
  @Deprecated('Use redAlias instead')
  static const red500 = Color(0xffFA586C);
  @Deprecated('Use greenAlias instead')
  static const green600 = Color(0xff43A047);
  @Deprecated('Use greenAlias instead')
  static const green700 = Color(0xff3EB89B);
  @Deprecated('Use yellowAlias instead')
  static const yellow300 = Color(0xffEFD26B);
  @Deprecated('Use yellowAlias instead')
  static const yellow500 = Color(0xffEBC746);

  @Deprecated('Use grayAlias instead')
  static const gray25 = Color(0xffD0D2D9);
  @Deprecated('Use grayAlias instead')
  static const gray50 = Color(0xffEBEBEC);
  @Deprecated('Use grayAlias instead')
  static const gray100 = Color(0xffAEAFB2);
  @Deprecated('Use grayAlias instead')
  static const gray300 = Color(0xff717279);
  @Deprecated('Use grayAlias instead')
  static const gray400 = Color(0xff2d2f33);
  @Deprecated('Use grayAlias instead')
  static const gray500 = Color(0xff34363F);
  @Deprecated('Use grayAlias instead')
  static const gray700 = Color(0xff2A2B32);
  @Deprecated('Use grayAlias instead')
  static const gray800 = Color(0xff1F2026);
  @Deprecated('Use grayAlias instead')
  static const gray900 = Color(0xff1A1B20);
  @Deprecated('Use grayAlias instead')
  static const black100 = Color(0xff161719);
  @Deprecated('Use grayAlias instead')
  static const black200 = Color(0xff121314);
}

// ---------------- SEMATIC ----------------

class _SemanticColors {
  _SemanticColors();

  final content = _ContentColors();
  final icon = _IconColors();
  final text = _TextColors();
  final border = _BorderColors();
  final surface = _SurfaceColors();
  final background = _BackgroundColors();
}

// ---------------- CONTENT ----------------

class _ContentColors {
  final negative = _ContentNegativeColors();
  final neutral = _ContentNeutralColors();
  final brand = _ContentBrandColors();
  final warning = _ContentWarningColors();
  final success = _ContentSuccessColors();
  final caution = _ContentCautionColors();
}

class _ContentNegativeColors {
  final Color core = AppColors.red[500]!;
  final Color accent = AppColors.red[600]!;
  final Color strong = AppColors.red[700]!;
  final Color overlay20 = const Color.fromRGBO(225, 49, 49, 0.20);
  final Color overlay16 = const Color.fromRGBO(225, 49, 49, 0.16);
  final Color overlay12 = const Color.fromRGBO(225, 49, 49, 0.12);
  final Color overlay05 = const Color.fromRGBO(225, 49, 49, 0.05);
}

class _ContentNeutralColors {
  final Color accent = AppColors.zink[500]!;
  final Color core = AppColors.zink[400]!;
  final Color strong = AppColors.zink[600]!;
  final Color mute = AppColors.zink[700]!;
  final Color inversed = AppColors.white;
  final Color overlay20 = const Color.fromRGBO(135, 135, 147, 0.20);
  final Color overlay16 = const Color.fromRGBO(135, 135, 147, 0.16);
  final Color overlay12 = const Color(0xff878793).withValues(alpha: 0.12);
  final Color overlay5 = const Color.fromRGBO(135, 135, 147, 0.05);
}

class _ContentBrandColors {
  final Color core = AppColors.royalBlue[500]!;
  final Color accent = AppColors.royalBlue[600]!;
  final Color strong = AppColors.royalBlue[700]!;
  final Color inverse = AppColors.royalBlue[50]!;
  final Color overlay20 = const Color.fromRGBO(70, 95, 224, 0.20);
  final Color overlay16 = const Color.fromRGBO(70, 95, 224, 0.16);
  final Color overlay12 = const Color.fromRGBO(70, 95, 224, 0.12);
  final Color overlay8 = const Color.fromRGBO(103, 103, 153, 0.08);
}

class _ContentWarningColors {
  final Color core = AppColors.orange[500]!;
  final Color accent = AppColors.orange[600]!;
  final Color overlay12 = const Color.fromRGBO(249, 115, 22, 0.12);
  final Color overlay16 = const Color.fromRGBO(249, 115, 22, 0.16);
  final Color overlay20 = const Color.fromRGBO(249, 115, 22, 0.20);
  final Color overlay05 = const Color.fromRGBO(249, 115, 22, 0.05);
}

class _ContentSuccessColors {
  final Color core = AppColors.green[500]!;
  final Color accent = AppColors.green[600]!;
  final Color overlay12 = const Color.fromRGBO(72, 217, 130, 0.12);
  final Color overlay16 = const Color.fromRGBO(72, 217, 130, 0.16);
  final Color overlay20 = const Color.fromRGBO(72, 217, 130, 0.20);
}

class _ContentCautionColors {
  final Color core = AppColors.yellow[400]!;
  final Color accent = AppColors.yellow[500]!;
  final Color strong = AppColors.yellow[600]!;
  final Color overlay20 = const Color.fromRGBO(234, 179, 8, 0.20);
  final Color overlay16 = const Color.fromRGBO(234, 179, 8, 0.16);
  final Color overlay12 = const Color.fromRGBO(234, 179, 8, 0.12);
  final Color overlay05 = const Color.fromRGBO(234, 179, 8, 0.05);
}

// ---------------- ICON ----------------

class _IconColors {
  final negative = _IconNegativeColors();
  final neutral = _IconNeutralColors();
  final success = _IconSuccessColors();
  final brand = _IconBrandColors();
  final warning = _IconWarningColors();
}

class _IconNegativeColors {
  final Color accent = AppColors.red[400]!;
  final Color core = AppColors.red[500]!;
  final Color subtle = AppColors.red[600]!;
  final Color strong = AppColors.red[300]!;
}

class _IconNeutralColors {
  final Color strong = AppColors.white;
  final Color accent = AppColors.zink[50]!;
  final Color core = AppColors.zink[100]!;
  final Color subtle = AppColors.zink[200]!;
  final Color faint = AppColors.zink[400]!;
  final Color muted = AppColors.zink[300]!;
}

class _IconSuccessColors {
  final Color subtle = AppColors.green[600]!;
  final Color core = AppColors.green[500]!;
  final Color accent = AppColors.green[400]!;
  final Color strong = AppColors.green[300]!;
}

class _IconBrandColors {
  final Color accent = AppColors.royalBlue[400]!;
  final Color core = AppColors.royalBlue[500]!;
  final Color subtle = AppColors.royalBlue[600]!;
  final Color strong = AppColors.royalBlue[300]!;
}

class _IconWarningColors {
  final Color strong = AppColors.orange[300]!;
  final Color accent = AppColors.orange[400]!;
  final Color core = AppColors.orange[500]!;
  final Color subtle = AppColors.orange[600]!;
}

// ---------------- TEXT ----------------

class _TextColors {
  final negative = _TextNegativeColors();
  final neutral = _TextNeutralColors();
  final brand = _TextBrandColors();
  final success = _TextSuccessColors();
  final warning = _TextWarningColors();
}

class _TextNegativeColors {
  final Color accent = AppColors.red[400]!;
  final Color core = AppColors.red[500]!;
  final Color subtle = AppColors.red[600]!;
  final Color strong = AppColors.red[300]!;
}

class _TextNeutralColors {
  final Color accent = AppColors.zink[50]!;
  final Color core = AppColors.zink[100]!;
  final Color subtle = AppColors.zink[200]!;
  final Color mute = AppColors.zink[300]!;
  final Color strong = AppColors.white;
}

class _TextBrandColors {
  final Color accent = AppColors.royalBlue[400]!;
  final Color core = AppColors.royalBlue[500]!;
  final Color subtle = AppColors.royalBlue[600]!;
  final Color strong = AppColors.royalBlue[300]!;
}

class _TextSuccessColors {
  final Color accent = AppColors.green[400]!;
  final Color core = AppColors.green[500]!;
  final Color subtle = AppColors.green[600]!;
  final Color strong = AppColors.green[300]!;
}

class _TextWarningColors {
  final Color accent = AppColors.orange[400]!;
  final Color core = AppColors.orange[500]!;
  final Color subtle = AppColors.orange[600]!;
  final Color strong = AppColors.orange[300]!;
}

// ---------------- BORDER ----------------

class _BorderColors {
  final negative = _BorderNegativeColors();
  final neutral = _BorderNeutralColors();
  final brand = _BorderBrandColors();
  final warning = _BorderWarningColors();
  final success = _BorderSuccessColors();
}

class _BorderNegativeColors {
  final Color accent = AppColors.red[400]!;
  final Color subtle = AppColors.red[600]!;
  final Color core = AppColors.red[500]!;
  final Color strong = AppColors.red[300]!;
}

class _BorderNeutralColors {
  final Color accent = AppColors.zink[200]!;
  final Color subtle = AppColors.zink[400]!;
  final Color core = AppColors.zink[300]!;
  final Color mute = AppColors.zink[500]!;
  final Color strong = AppColors.zink[100]!;
  final Color faint = AppColors.zink[700]!;
}

class _BorderBrandColors {
  final Color accent = AppColors.royalBlue[400]!;
  final Color core = AppColors.royalBlue[500]!;
  final Color subtle = AppColors.royalBlue[600]!;
  final Color strong = AppColors.royalBlue[300]!;
}

class _BorderWarningColors {
  final Color accent = AppColors.orange[400]!;
  final Color core = AppColors.orange[500]!;
  final Color subtle = AppColors.orange[600]!;
  final Color strong = AppColors.orange[300]!;
}

class _BorderSuccessColors {
  final Color accent = AppColors.green[400]!;
  final Color core = AppColors.green[500]!;
  final Color subtle = AppColors.green[600]!;
  final Color strong = AppColors.green[300]!;
}

// ---------------- SURFACE & BACKGROUND ----------------

class _SurfaceColors {
  final Color primary = AppColors.zink[900]!;
  final Color secondary = AppColors.zink[800]!;
}

class _BackgroundColors {
  final Color core = AppColors.zink[950]!;
}

typedef _FieldExtractor = Map<String, dynamic> Function(Object);

final Map<Type, _FieldExtractor> _extractorRegistry = {
  // ---------------- CONTENT ----------------
  _ContentColors: (o) => {
    'negative': (o as _ContentColors).negative,
    'neutral': o.neutral,
    'brand': o.brand,
    'warning': o.warning,
    'success': o.success,
    'caution': o.caution,
  },
  _ContentNegativeColors: (o) => {
    'core': (o as _ContentNegativeColors).core,
    'accent': o.accent,
    'strong': o.strong,
    'overlay20': o.overlay20,
    'overlay16': o.overlay16,
    'overlay12': o.overlay12,
    'overlay05': o.overlay05,
  },
  _ContentNeutralColors: (o) => {
    'core': (o as _ContentNeutralColors).core,
    'accent': o.accent,
    'strong': o.strong,
    'mute': o.mute,
    'inversed': o.inversed,
    'overlay20': o.overlay20,
    'overlay16': o.overlay16,
    'overlay12': o.overlay12,
  },
  _ContentBrandColors: (o) => {
    'core': (o as _ContentBrandColors).core,
    'accent': o.accent,
    'strong': o.strong,
    'inverse': o.inverse,
    'overlay20': o.overlay20,
    'overlay16': o.overlay16,
    'overlay12': o.overlay12,
    'overlay8': o.overlay8,
  },
  _ContentWarningColors: (o) => {
    'core': (o as _ContentWarningColors).core,
    'accent': o.accent,
    'overlay12': o.overlay12,
    'overlay16': o.overlay16,
    'overlay20': o.overlay20,
    'overlay05': o.overlay05,
  },
  _ContentSuccessColors: (o) => {
    'core': (o as _ContentSuccessColors).core,
    'accent': o.accent,
    'overlay12': o.overlay12,
    'overlay16': o.overlay16,
    'overlay20': o.overlay20,
  },
  _ContentCautionColors: (o) => {
    'core': (o as _ContentCautionColors).core,
    'accent': o.accent,
    'strong': o.strong,
    'overlay20': o.overlay20,
    'overlay16': o.overlay16,
    'overlay12': o.overlay12,
    'overlay05': o.overlay05,
  },

  // ---------------- ICON ----------------
  _IconColors: (o) => {
    'negative': (o as _IconColors).negative,
    'neutral': o.neutral,
    'brand': o.brand,
    'success': o.success,
    'warning': o.warning,
  },
  _IconNegativeColors: (o) => {
    'accent': (o as _IconNegativeColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _IconNeutralColors: (o) => {
    'strong': (o as _IconNeutralColors).strong,
    'accent': o.accent,
    'muted': o.muted,
    'core': o.core,
    'subtle': o.subtle,
    'faint': o.faint,
  },
  _IconBrandColors: (o) => {
    'accent': (o as _IconBrandColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _IconSuccessColors: (o) => {
    'subtle': (o as _IconSuccessColors).subtle,
    'core': o.core,
    'accent': o.accent,
    'strong': o.strong,
  },
  _IconWarningColors: (o) => {
    'strong': (o as _IconWarningColors).strong,
    'accent': o.accent,
    'core': o.core,
    'subtle': o.subtle,
  },

  // ---------------- TEXT ----------------
  _TextColors: (o) => {
    'negative': (o as _TextColors).negative,
    'neutral': o.neutral,
    'brand': o.brand,
    'success': o.success,
    'warning': o.warning,
  },
  _TextNegativeColors: (o) => {
    'accent': (o as _TextNegativeColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _TextNeutralColors: (o) => {
    'accent': (o as _TextNeutralColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'mute': o.mute,
    'strong': o.strong,
  },
  _TextBrandColors: (o) => {
    'accent': (o as _TextBrandColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _TextSuccessColors: (o) => {
    'accent': (o as _TextSuccessColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _TextWarningColors: (o) => {
    'accent': (o as _TextWarningColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },

  // ---------------- BORDER ----------------
  _BorderColors: (o) => {
    'negative': (o as _BorderColors).negative,
    'neutral': o.neutral,
    'brand': o.brand,
    'success': o.success,
    'warning': o.warning,
  },
  _BorderNegativeColors: (o) => {
    'accent': (o as _BorderNegativeColors).accent,
    'subtle': o.subtle,
    'core': o.core,
    'strong': o.strong,
  },
  _BorderNeutralColors: (o) => {
    'accent': (o as _BorderNeutralColors).accent,
    'subtle': o.subtle,
    'core': o.core,
    'mute': o.mute,
    'strong': o.strong,
    'faint': o.faint,
  },
  _BorderBrandColors: (o) => {
    'accent': (o as _BorderBrandColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _BorderSuccessColors: (o) => {
    'accent': (o as _BorderSuccessColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },
  _BorderWarningColors: (o) => {
    'accent': (o as _BorderWarningColors).accent,
    'core': o.core,
    'subtle': o.subtle,
    'strong': o.strong,
  },

  // ---------------- SURFACE / BACKGROUND ----------------
  _SurfaceColors: (o) => {'primary': (o as _SurfaceColors).primary, 'secondary': o.secondary},
  _BackgroundColors: (o) => {'core': (o as _BackgroundColors).core},
};

/// Извлекает рекурсивно все типы из объекта
List<(String, Color)> extractColors(Object obj, {required String namePrefix}) {
  final colors = <(String, Color)>[];

  final extractor = _extractorRegistry[obj.runtimeType];
  if (extractor == null) return colors;

  final map = extractor(obj);

  for (final entry in map.entries) {
    final value = entry.value;
    if (value is Color) {
      colors.add(('$namePrefix.${entry.key}', value));
    } else {
      colors.addAll(extractColors(value, namePrefix: '$namePrefix.${entry.key}'));
    }
  }

  return colors;
}
