import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('lib/core/theme/generator/tokens.json');
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

  _generateColors(data);
  _generateSpacing(data);
  _generateRadius(data);
  _generateTypography(data);
  _generateDimensions(data);

  stdout.writeln('Theme tokens generated.');
}

void _generateColors(Map<String, dynamic> data) {
  final light = data['themes']['light']['colors'] as Map<String, dynamic>;
  final dark = data['themes']['dark']['colors'] as Map<String, dynamic>;

  final output = StringBuffer()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln()
    ..writeln('abstract class GeneratedColorTokensBase {')
    ..writeln('  const GeneratedColorTokensBase();')
    ..writeln(_generateColorGetters(light))
    ..writeln('}')
    ..writeln()
    ..writeln('class GeneratedLightColorTokens extends GeneratedColorTokensBase {')
    ..writeln('  const GeneratedLightColorTokens();')
    ..writeln(_generateColorOverrides(light))
    ..writeln('}')
    ..writeln()
    ..writeln('class GeneratedDarkColorTokens extends GeneratedColorTokensBase {')
    ..writeln('  const GeneratedDarkColorTokens();')
    ..writeln(_generateColorOverrides(dark))
    ..writeln('}');

  _write('generated_color_tokens.dart', output.toString());
}

String _generateColorGetters(Map<String, dynamic> colors) {
  final buffer = StringBuffer();
  for (final key in colors.keys) {
    buffer.writeln('  Color get $key;');
  }
  return buffer.toString();
}

String _generateColorOverrides(Map<String, dynamic> colors) {
  final buffer = StringBuffer();
  colors.forEach((key, value) {
    final hex = (value as String).substring(1);
    buffer.writeln('  @override');
    buffer.writeln('  Color get $key => const Color(0xFF$hex);');
  });
  return buffer.toString();
}

void _generateSpacing(Map<String, dynamic> data) {
  final spacing = data['spacing'] as Map<String, dynamic>;

  final output = StringBuffer()
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln("import '../tokens/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedSpacingTokens {')
    ..writeln('  const GeneratedSpacingTokens();')
    ..writeln(_generateResponsiveMethods(spacing, unit: '.r'))
    ..writeln('}');

  _write('generated_spacing_tokens.dart', output.toString());
}

void _generateRadius(Map<String, dynamic> data) {
  final radius = data['radius'] as Map<String, dynamic>;

  final output = StringBuffer()
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln("import '../tokens/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedRadiusTokens {')
    ..writeln('  const GeneratedRadiusTokens();')
    ..writeln(_generateResponsiveMethods(radius, unit: '.r'))
    ..writeln('}');

  _write('generated_radius_tokens.dart', output.toString());
}

void _generateTypography(Map<String, dynamic> data) {
  final typography = data['typography'] as Map<String, dynamic>;

  final output = StringBuffer()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import '../theme_tokens_extension.dart';")
    ..writeln("import '../tokens/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedTypographyTokens {')
    ..writeln('  const GeneratedTypographyTokens();')
    ..writeln(_generateTypographyMethods(typography))
    ..writeln('}');

  _write('generated_typography_tokens.dart', output.toString());
}

String _generateTypographyMethods(Map<String, dynamic> typography) {
  final buffer = StringBuffer();
  typography.forEach((name, value) {
    final v = value as Map<String, dynamic>;
    final size = v['size'] as Map<String, dynamic>;
    final weight = v['weight'];
    final color = v['color'];

    buffer.writeln('  TextStyle $name(BuildContext context) {');
    buffer.writeln('    final appTheme = Theme.of(context).extension<AppThemeTokensExtension>()!;');
    buffer.writeln(
      '    final size = ResponsiveValue<double>(mobile: ${size['mobile']}, tablet: ${size['tablet']}, desktop: ${size['desktop']}).resolve(context);',
    );
    buffer.writeln('    return TextStyle(');
    buffer.writeln('      fontSize: size.sp,');
    buffer.writeln('      fontWeight: FontWeight.w$weight,');
    buffer.writeln('      color: appTheme.colors.$color,');
    buffer.writeln('    );');
    buffer.writeln('  }');
  });
  return buffer.toString();
}

void _generateDimensions(Map<String, dynamic> data) {
  final dimensions = data['dimensions'] as Map<String, dynamic>;

  final output = StringBuffer()
    ..writeln("import 'package:flutter_screenutil/flutter_screenutil.dart';")
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln("import '../tokens/responsive_value.dart';")
    ..writeln()
    ..writeln('class GeneratedDimensionTokens {')
    ..writeln('  const GeneratedDimensionTokens();')
    ..writeln(_generateDimensionMethods(dimensions))
    ..writeln('}');

  _write('generated_dimension_tokens.dart', output.toString());
}

String _generateResponsiveMethods(Map<String, dynamic> values, {required String unit}) {
  final buffer = StringBuffer();
  values.forEach((name, value) {
    final v = value as Map<String, dynamic>;
    buffer.writeln('  double $name(BuildContext context) {');
    buffer.writeln(
      '    return ResponsiveValue<double>(mobile: ${v['mobile']}, tablet: ${v['tablet']}, desktop: ${v['desktop']}).resolve(context)$unit;',
    );
    buffer.writeln('  }');
  });
  return buffer.toString();
}

String _generateDimensionMethods(Map<String, dynamic> values) {
  final buffer = StringBuffer();
  values.forEach((name, value) {
    final v = value as Map<String, dynamic>;
    final unit = switch (v['type']) {
      'width' => '.w',
      'height' => '.h',
      _ => '.r',
    };
    buffer.writeln('  double $name(BuildContext context) {');
    buffer.writeln(
      '    return ResponsiveValue<double>(mobile: ${v['mobile']}, tablet: ${v['tablet']}, desktop: ${v['desktop']}).resolve(context)$unit;',
    );
    buffer.writeln('  }');
  });
  return buffer.toString();
}

void _write(String name, String content) {
  final directory = Directory('lib/core/theme/tokens/generated');
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  final file = File('${directory.path}/$name');
  file.writeAsStringSync(content);
}
