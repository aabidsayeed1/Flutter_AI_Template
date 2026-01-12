import 'dart:io' show stdout;

// Returns whether the current stdout supports ANSI escapes (only available on
// non-web platforms).
bool get supportsAnsi => stdout.supportsAnsiEscapes;
