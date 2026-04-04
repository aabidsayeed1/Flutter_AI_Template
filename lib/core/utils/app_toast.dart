import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _defaultDuration = Duration(seconds: 4);
const _defaultAnimationDuration = Duration(milliseconds: 300);

// ── BuildContext Extension ─────────────────────────────────────────────
//
// Usage:
//   context.showSuccess(title: 'Done', message: 'Saved');
//   context.showError(title: 'Oops', message: 'Something went wrong');
//   context.showWarning(title: 'Careful', message: 'Check your input');
//   context.showInfo(title: 'Tip', message: 'Swipe to refresh');

extension AppToast on BuildContext {
  // ── SUCCESS ──────────────────────────────────────────────────────────

  ToastificationItem showSuccess({
    required String title,
    String? message,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
  }) {
    return _showToast(
      this,
      type: ToastificationType.success,
      title: title,
      message: message,
      duration: duration,
      alignment: alignment,
      showProgressBar: showProgressBar,
    );
  }

  // ── ERROR ────────────────────────────────────────────────────────────

  ToastificationItem showError({
    required String title,
    String? message,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
  }) {
    return _showToast(
      this,
      type: ToastificationType.error,
      title: title,
      message: message,
      duration: duration ?? const Duration(seconds: 6),
      alignment: alignment,
      showProgressBar: showProgressBar,
    );
  }

  // ── WARNING ──────────────────────────────────────────────────────────

  ToastificationItem showWarning({
    required String title,
    String? message,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
  }) {
    return _showToast(
      this,
      type: ToastificationType.warning,
      title: title,
      message: message,
      duration: duration ?? const Duration(seconds: 5),
      alignment: alignment,
      showProgressBar: showProgressBar,
    );
  }

  // ── INFO ─────────────────────────────────────────────────────────────

  ToastificationItem showInfo({
    required String title,
    String? message,
    Duration? duration,
    Alignment? alignment,
    bool showProgressBar = true,
  }) {
    return _showToast(
      this,
      type: ToastificationType.info,
      title: title,
      message: message,
      duration: duration,
      alignment: alignment,
      showProgressBar: showProgressBar,
    );
  }

  // ── DISMISS ──────────────────────────────────────────────────────────

  void dismissAllToasts() {
    toastification.dismissAll();
  }
}

// ── CORE ─────────────────────────────────────────────────────────────

ToastificationItem _showToast(
  BuildContext context, {
  required ToastificationType type,
  required String title,
  String? message,
  Duration? duration,
  Alignment? alignment,
  bool showProgressBar = true,
}) {
  return toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flatColored,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    description: message != null ? Text(message) : null,
    alignment: alignment ?? Alignment.topCenter,
    autoCloseDuration: duration ?? _defaultDuration,
    animationDuration: _defaultAnimationDuration,
    showProgressBar: showProgressBar,
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.always),
    dragToClose: true,
    closeOnClick: false,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
  );
}
