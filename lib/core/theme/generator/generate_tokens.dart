import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('lib/core/theme/generator/tokens.json');
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

  _generateColors(data);
  _generateGradients(data);
  _generateShadows(data);
  _generateSpacing(data);
  _generateRadius(data);
  _generateTypography(data);
  _generateDimensions(data);
  _generateElevations(data);
  _ensureResponsiveFiles(data);

  stdout.writeln('Theme tokens generated.');
}

String _memberName(String key) {
  final id = RegExp(r'^[A-Za-z_][A-Za-z0-9_]*$');
  if (id.hasMatch(key)) {
    return key;
  }

  final cleaned = key.replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_');
  final parts = cleaned.split('_').where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) {
    return 'token';
  }

  var out = parts.first;
  for (final p in parts.skip(1)) {
    out += p[0].toUpperCase() + p.substring(1);
  }
  if (RegExp(r'^[0-9]').hasMatch(out)) {
    out = 'x$out';
  }
  return out;
}

String _classNameForTheme(String theme) {
  if (theme.isEmpty) {
    return 'GeneratedThemeColorTokens';
  }
  final t = theme[0].toUpperCase() + theme.substring(1);
  return 'Generated${t}ColorTokens';
}

String _gradientClassNameForTheme(String theme) {
  final t = theme[0].toUpperCase() + theme.substring(1);
  return 'Generated${t}GradientTokens';
}

String _shadowClassNameForTheme(String theme) {
  final t = theme[0].toUpperCase() + theme.substring(1);
  return 'Generated${t}ShadowTokens';
}

String _alignment(String name) {
  switch (name) {
    case 'topLeft':
      return 'Alignment.topLeft';
    case 'topCenter':
      return 'Alignment.topCenter';
    case 'topRight':
      return 'Alignment.topRight';
    case 'centerLeft':
      return 'Alignment.centerLeft';
    case 'center':
      return 'Alignment.center';
    case 'centerRight':
      return 'Alignment.centerRight';
    case 'bottomLeft':
      return 'Alignment.bottomLeft';
    case 'bottomCenter':
      return 'Alignment.bottomCenter';
    case 'bottomRight':
      return 'Alignment.bottomRight';
    default:
      return 'Alignment.center';
  }
}

String _gradientFactory(Map<String, dynamic> g) {
  final type = g['type'] as String;
  final colors = (g['colors'] as List).map((e) {
    return 'Theme.of(context).extension<AppThemeExtension>()!.colors.${_memberName(e as String)}';
  }).join(', ');

  if (type == 'linear') {
    return 'LinearGradient(begin: ${_alignment(g['begin'] as String)}, end: ${_alignment(g['end'] as String)}, colors: [$colors])';
  }

  if (type == 'radial') {
    return 'RadialGradient(center: ${_alignment(g['center'] as String)}, radius: ${(g['radius'] as num).toDouble()}, colors: [$colors])';
  }

  return 'SweepGradient(center: ${_alignment(g['center'] as String)}, colors: [$colors], startAngle: ${(g['startAngle'] as num).toDouble()}, endAngle: ${(g['endAngle'] as num).toDouble()})';
}

void _generateColors(Map<String, dynamic> data) {
  final themes = data['themes'] as Map<String, dynamic>;
  final lightColors = (themes['light'] as Map<String, dynamic>)['colors'] as Map<String, dynamic>;

  final out = StringBuffer()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln()
    ..writeln('abstract class GeneratedThemeColorTokens {')
    ..writeln('  const GeneratedThemeColorTokens();');

  for (final key in lightColors.keys) {
    out.writeln('  Color get ${_memberName(key)};');
  }
  out.writeln('}');
  out.writeln();

  for (final entry in themes.entries) {
    final themeName = entry.key;
    final colors = (entry.value as Map<String, dynamic>)['colors'] as Map<String, dynamic>;
    out.writeln('class ${_classNameForTheme(themeName)} extends GeneratedThemeColorTokens {');
    out.writeln('  const ${_classNameForTheme(themeName)}();');
    for (final key in lightColors.keys) {
      final hex = (colors[key] as String).replaceFirst('#', '');
      out.writeln('  @override');
      out.writeln('  Color get ${_memberName(key)} => const Color(0xff$hex);');
    }
    out.writeln('}');
    out.writeln();
  }

  _write('generated_color_tokens.dart', out.toString());
}

void _generateGradients(Map<String, dynamic> data) {
  final themes = data['themes'] as Map<String, dynamic>;
  final lightGradients = (themes['light'] as Map<String, dynamic>)['gradients'] as Map<String, dynamic>;

  final out = StringBuffer()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln()
    ..writeln("import '../../theme_tokens_extension.dart';")
    ..writeln()
    ..writeln('abstract class GeneratedThemeGradientTokens {')
    ..writeln('  const GeneratedThemeGradientTokens();');

  for (final key in lightGradients.keys) {
    out.writeln('  Gradient ${_memberName(key)}(BuildContext context);');
  }
  out.writeln('}');
  out.writeln();

  for (final entry in themes.entries) {
    final gradients = (entry.value as Map<String, dynamic>)['gradients'] as Map<String, dynamic>;
    final className = _gradientClassNameForTheme(entry.key);

    out.writeln('class $className extends GeneratedThemeGradientTokens {');
    out.writeln('  const $className();');
    for (final key in lightGradients.keys) {
      final method = _memberName(key);
      out.writeln('  @override');
      out.writeln('  Gradient $method(BuildContext context) {');
      out.writeln('    return ${_gradientFactory(gradients[key] as Map<String, dynamic>)};');
      out.writeln('  }');
    }
    out.writeln('}');
    out.writeln();
  }

  _write('generated_gradient_tokens.dart', out.toString());
}

void _generateShadows(Map<String, dynamic> data) {
  final themes = data['themes'] as Map<String, dynamic>;
  final lightShadows = (themes['light'] as Map<String, dynamic>)['shadows'] as Map<String, dynamic>;

  final out = StringBuffer()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln()
    ..writeln("import '../../theme_tokens_extension.dart';")
    ..writeln()
    ..writeln('abstract class GeneratedThemeShadowTokens {')
    ..writeln('  const GeneratedThemeShadowTokens();');

  for (final key in lightShadows.keys) {
    out.writeln('  List<BoxShadow> ${_memberName(key)}(BuildContext context);');
  }
  out.writeln('}');
  out.writeln();

  for (final entry in themes.entries) {
    final shadows = (entry.value as Map<String, dynamic>)['shadows'] as Map<String, dynamic>;
    final className = _shadowClassNameForTheme(entry.key);

    out.writeln('class $className extends GeneratedThemeShadowTokens {');
    out.writeln('  const $className();');
    for (final key in lightShadows.keys) {
      final method = _memberName(key);
      final cfg = shadows[key] as Map<String, dynamic>;
      final layers = (cfg['layers'] as List).map((layer) {
        final l = layer as Map<String, dynamic>;
        final colorRef = _memberName(l['color'] as String);
        return 'BoxShadow(color: Theme.of(context).extension<AppThemeExtension>()!.colors.$colorRef.withValues(alpha: ${(l['opacity'] as num).toDouble()}), offset: Offset(${(l['x'] as num).toDouble()}, ${(l['y'] as num).toDouble()}), blurRadius: ${(l['blur'] as num).toDouble()}, spreadRadius: ${(l['spread'] as num).toDouble()})';
      }).join(', ');

      out.writeln('  @override');
      out.writeln('  List<BoxShadow> $method(BuildContext context) {');
      out.writeln('    return [$layers];');
      out.writeln('  }');
    }
    out.writeln('}');
    out.writeln();
  }

  _write('generated_shadow_tokens.dart', out.toString());
}

void _generateSpacing(Map<String, dynamic> data) {
  final values = data['spacing'] as Map<String, dynamic>;
  _write('generated_spacing_tokens.dart', _generateResponsiveClass('GeneratedSpacingTokens', values, '.r'));
}

void _generateRadius(Map<String, dynamic> data) {
  final values = data['radius'] as Map<String, dynamic>;
  _write('generated_radius_tokens.dart', _generateResponsiveClass('GeneratedRadiusTokens', values, '.r'));
}

void _generateDimensions(Map<String, dynamic> data) {
  final values = data['dimensions'] as Map<String, dynamic>;

  final out = StringBuffer()
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln()
    ..writeln("import '../../responsive/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedDimensionTokens {')
    ..writeln('  const GeneratedDimensionTokens();');

  for (final e in values.entries) {
    final key = _memberName(e.key);
    final v = e.value as Map<String, dynamic>;
    final unit = switch (v['type']) {
      'width' => '.w',
      'height' => '.h',
      _ => '.r',
    };
    out.writeln('  double $key(BuildContext context) {');
    out.writeln('    return ResponsiveValue<double>(mobile: ${v['mobile']}, tablet: ${v['tablet']}, desktop: ${v['desktop']}).resolve(context)$unit;');
    out.writeln('  }');
    out.writeln();
  }

  out.writeln('}');
  _write('generated_dimension_tokens.dart', out.toString());
}

void _generateElevations(Map<String, dynamic> data) {
  final values = data['elevations'] as Map<String, dynamic>;
  final aliases = (data['elevationAliases'] as Map<String, dynamic>?) ?? <String, dynamic>{};

  final out = StringBuffer()
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln()
    ..writeln("import '../../responsive/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedElevationTokens {')
    ..writeln('  const GeneratedElevationTokens();');

  for (final e in values.entries) {
    final key = _memberName(e.key);
    final v = e.value as Map<String, dynamic>;
    out.writeln('  double $key(BuildContext context) {');
    out.writeln('    return ResponsiveValue<double>(mobile: ${v['mobile']}, tablet: ${v['tablet']}, desktop: ${v['desktop']}).resolve(context).r;');
    out.writeln('  }');
    out.writeln();
  }

  for (final e in aliases.entries) {
    final alias = _memberName(e.key);
    final target = _memberName(e.value as String);
    out.writeln('  double $alias(BuildContext context) {');
    out.writeln('    return $target(context);');
    out.writeln('  }');
    out.writeln();
  }

  out.writeln('}');
  _write('generated_elevation_tokens.dart', out.toString());
}

void _generateTypography(Map<String, dynamic> data) {
  final values = data['typography'] as Map<String, dynamic>;

  final out = StringBuffer()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln()
    ..writeln("import '../../theme_tokens_extension.dart';")
    ..writeln("import '../../responsive/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedTypographyTokens {')
    ..writeln('  const GeneratedTypographyTokens();');

  for (final e in values.entries) {
    final name = _memberName(e.key);
    final v = e.value as Map<String, dynamic>;
    final size = v['size'] as Map<String, dynamic>;
    final lineHeight = (v['lineHeight'] as Map<String, dynamic>?);
    final weight = v['weight'];
    final color = _memberName(v['color'] as String);
    final letter = v['letterSpacing'];

    out.writeln('  TextStyle $name(BuildContext context) {');
    out.writeln('    final fontSize = ResponsiveValue<double>(mobile: ${size['mobile']}, tablet: ${size['tablet']}, desktop: ${size['desktop']}).resolve(context).sp;');
    if (lineHeight != null) {
      out.writeln('    final lineHeight = ResponsiveValue<double>(mobile: ${lineHeight['mobile']}, tablet: ${lineHeight['tablet']}, desktop: ${lineHeight['desktop']}).resolve(context).sp;');
    }
    out.writeln('    return TextStyle(');
    out.writeln('      fontSize: fontSize,');
    out.writeln('      fontWeight: FontWeight.w$weight,');
    out.writeln('      color: Theme.of(context).extension<AppThemeExtension>()!.colors.$color,');
    if (lineHeight != null) {
      out.writeln('      height: lineHeight / fontSize,');
    }
    if (letter != null) {
      out.writeln('      letterSpacing: ${(letter as num).toDouble()}.sp,');
    }
    out.writeln('    );');
    out.writeln('  }');
    out.writeln();
  }

  out.writeln('}');
  _write('generated_typography_tokens.dart', out.toString());
}

String _generateResponsiveClass(
  String className,
  Map<String, dynamic> values,
  String unit,
) {
  final out = StringBuffer()
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln()
    ..writeln("import '../../responsive/responsive_value.dart';")
    ..writeln()
    ..writeln('class $className {')
    ..writeln('  const $className();');

  for (final e in values.entries) {
    final name = _memberName(e.key);
    final v = e.value as Map<String, dynamic>;
    out.writeln('  double $name(BuildContext context) {');
    out.writeln('    return ResponsiveValue<double>(mobile: ${v['mobile']}, tablet: ${v['tablet']}, desktop: ${v['desktop']}).resolve(context)$unit;');
    out.writeln('  }');
    out.writeln();
  }

  out.writeln('}');
  return out.toString();
}

void _write(String name, String content) {
  final directory = Directory('lib/core/theme/tokens/generated');
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  final file = File('${directory.path}/$name');
  file.writeAsStringSync(content);
}

void _ensureResponsiveFiles(Map<String, dynamic> data) {
  final designSizes = (data['designSizes'] as Map<String, dynamic>?) ??
      <String, dynamic>{
        'mobile': <String, dynamic>{'width': 390, 'height': 844},
        'tablet': <String, dynamic>{'width': 834, 'height': 1194},
        'desktop': <String, dynamic>{'width': 1440, 'height': 1024},
      };

  final mobile = designSizes['mobile'] as Map<String, dynamic>;
  final tablet = designSizes['tablet'] as Map<String, dynamic>;
  final desktop = designSizes['desktop'] as Map<String, dynamic>;

  final responsiveDir = Directory('lib/core/theme/responsive');
  if (!responsiveDir.existsSync()) {
    responsiveDir.createSync(recursive: true);
  }

  File('${responsiveDir.path}/design_sizes.dart').writeAsStringSync('''import 'package:flutter/widgets.dart';

class AppDesignSizes {
  static const Size mobile = Size(${mobile['width']}, ${mobile['height']});
  static const Size tablet = Size(${tablet['width']}, ${tablet['height']});
  static const Size desktop = Size(${desktop['width']}, ${desktop['height']});

  const AppDesignSizes._();
}
''');

  File('${responsiveDir.path}/responsive.dart').writeAsStringSync('''import 'package:flutter/widgets.dart';

class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= 1200;
}
''');

  File('${responsiveDir.path}/responsive_value.dart').writeAsStringSync('''import 'package:flutter/widgets.dart';

class ResponsiveValue<T> {
  final T mobile;
  final T tablet;
  final T desktop;

  const ResponsiveValue({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  T resolve(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 600) return mobile;
    if (width < 1200) return tablet;
    return desktop;
  }
}
''');
}
