import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_template_2025/core/base/export.dart';

/// Supported image resolutions.
enum AppImageResolution { low, medium, high }

/// Supported image shapes.
enum AppImageShape { circle, rounded, square, custom }

/// Universal image widget for network, asset, SVG, and file images.
/// Handles shimmer, error fallback, hero, resolution, and shape.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.src,
    this.resolution = AppImageResolution.medium,
    this.shape = AppImageShape.square,
    this.radius,
    this.width,
    this.height,
    this.fit,
    this.heroTag,
    this.placeholder,
    this.errorWidget,
    this.backgroundColor,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.cacheKey,
    this.httpHeaders,
    this.filterQuality = FilterQuality.low,
    this.color,
    this.colorBlendMode,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
  });

  /// Image source: URL, asset path, file path, or SVG.
  final String src;

  /// Image resolution (for network/asset URLs that support it).
  final AppImageResolution resolution;

  /// Shape of the image.
  final AppImageShape shape;

  /// Custom border radius (only for AppImageShape.custom).
  final double? radius;

  /// Width of the image.
  final double? width;

  /// Height of the image.
  final double? height;

  /// BoxFit for the image.
  final BoxFit? fit;

  /// Optional hero tag for Hero animation.
  final String? heroTag;

  /// Placeholder widget (optional, defaults to shimmer).
  final Widget? placeholder;

  /// Error widget (optional, defaults to broken image icon).
  final Widget? errorWidget;

  /// Background color (for SVG/transparent images).
  final Color? backgroundColor;

  /// Advanced: Resize in memory (RAM) for display.
  final int? memCacheWidth;
  final int? memCacheHeight;

  /// Advanced: Resize and store in disk cache.
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  /// Advanced: Custom cache key for the image.
  final String? cacheKey;

  /// Advanced: HTTP headers for the image request.
  final Map<String, String>? httpHeaders;

  /// Advanced: Image filter quality.
  final FilterQuality filterQuality;

  /// Advanced: Color blend for the image.
  final Color? color;
  final BlendMode? colorBlendMode;

  /// Advanced: Alignment, repeat, matchTextDirection.
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  @override
  Widget build(BuildContext context) {
    final Widget image = _buildImage(context);
    if (heroTag != null) {
      return Hero(tag: heroTag!, child: image);
    }
    return image;
  }

  Widget _buildImage(BuildContext context) {
    final String path = _resolvePath(src, resolution);
    final String ext = path.split('?').first.split('.').last.toLowerCase();
    final bool isNetwork = path.startsWith('http');
    final bool isSvg = ext == 'svg';
    final bool isAsset = !isNetwork && !path.startsWith('/') && !isSvg;
    final bool isFile = !isNetwork && path.startsWith('/');

    Widget img;
    if (isSvg) {
      if (isNetwork) {
        img = SvgPicture.network(
          path,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          placeholderBuilder: (_) => _shimmer(context),
        );
      } else {
        img = SvgPicture.asset(
          path,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
        );
      }
    } else if (isNetwork) {
      img = CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (_, _) => placeholder ?? _shimmer(context),
        errorWidget: (_, _, _) => errorWidget ?? _errorIcon(context),
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 100),
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        maxWidthDiskCache: maxWidthDiskCache,
        maxHeightDiskCache: maxHeightDiskCache,
        cacheKey: cacheKey,
        httpHeaders: httpHeaders,
        filterQuality: filterQuality,
        color: color,
        colorBlendMode: colorBlendMode,
        alignment: alignment,
        repeat: repeat,
        matchTextDirection: matchTextDirection,
      );
    } else if (isAsset) {
      img = Image.asset(
        path,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (_, _, _) => errorWidget ?? _errorIcon(context),
      );
    } else if (isFile) {
      img = Image.file(
        File(path),
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (_, _, _) => errorWidget ?? _errorIcon(context),
      );
    } else {
      img = errorWidget ?? _errorIcon(context);
    }
    return _wrapShape(context, img);
  }

  /// Resolves the image path for the requested resolution.
  String _resolvePath(String src, AppImageResolution res) {
    // Example: append @2x, @3x for assets, or modify URL for CDN
    if (src.startsWith('http')) {
      // Example: replace {res} in URL with actual value
      if (src.contains('{res}')) {
        switch (res) {
          case AppImageResolution.low:
            return src.replaceAll('{res}', 'low');
          case AppImageResolution.medium:
            return src.replaceAll('{res}', 'medium');
          case AppImageResolution.high:
            return src.replaceAll('{res}', 'high');
        }
      }
      return src;
    } else if (src.contains('@')) {
      // Asset: foo@2x.png, foo@3x.png
      switch (res) {
        case AppImageResolution.low:
          return src.replaceAll(RegExp(r'@\dx'), '@1x');
        case AppImageResolution.medium:
          return src.replaceAll(RegExp(r'@\dx'), '@2x');
        case AppImageResolution.high:
          return src.replaceAll(RegExp(r'@\dx'), '@3x');
      }
    }
    return src;
  }

  Widget _wrapShape(BuildContext context, Widget child) {
    final double r = switch (shape) {
      AppImageShape.circle => (width ?? height ?? 40) / 2,
      AppImageShape.rounded => 12.r,
      AppImageShape.square => 0,
      AppImageShape.custom => radius ?? 0,
    };
    final Widget img = ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: child,
    );
    if (shape == AppImageShape.circle) {
      return AspectRatio(aspectRatio: 1, child: img);
    }
    return img;
  }

  Widget _shimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.color.scaffoldBackground,
      highlightColor: context.color.disabled,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.color.scaffoldBackground,
          borderRadius: BorderRadius.circular(
            shape == AppImageShape.circle
                ? (width ?? height ?? 40) / 2
                : shape == AppImageShape.rounded
                ? 12.r
                : shape == AppImageShape.custom
                ? radius ?? 0
                : 0,
          ),
        ),
      ),
    );
  }

  Widget _errorIcon(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.color.scaffoldBackground,
        borderRadius: BorderRadius.circular(
          shape == AppImageShape.circle
              ? (width ?? height ?? 40) / 2
              : shape == AppImageShape.rounded
              ? 12.r
              : shape == AppImageShape.custom
              ? radius ?? 0
              : 0,
        ),
      ),
      child: Icon(
        Icons.broken_image_rounded,
        color: context.color.error,
        size: (width ?? height ?? 40) * 0.6,
      ),
    );
  }
}
