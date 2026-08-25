import 'generated/generated_color_tokens.dart';

abstract class ColorTokensBase extends GeneratedThemeColorTokens {
  const ColorTokensBase();
}

class LightColorTokens extends GeneratedLightColorTokens implements ColorTokensBase {
  const LightColorTokens();
}

class DarkColorTokens extends GeneratedDarkColorTokens implements ColorTokensBase {
  const DarkColorTokens();
}

class AuroraColorTokens extends GeneratedAuroraColorTokens implements ColorTokensBase {
  const AuroraColorTokens();
}
