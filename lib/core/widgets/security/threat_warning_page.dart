import 'dart:io';

import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/services/security/threat_type.dart';

/// A full-screen warning page displayed when freeRASP detects a security threat.
///
/// - **Blocking threats** (root, hooks, app tampering, etc.) show no dismiss
///   option — the user is trapped until they resolve the issue or close the app.
/// - **Non-blocking threats** (passcode, VPN, dev mode, etc.) show a
///   "Continue Anyway" button that pops the page.
class ThreatWarningPage extends StatelessWidget {
  const ThreatWarningPage({required this.threat, super.key});

  final ThreatType threat;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !threat.isBlocking,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _buildIcon(context),
                Gap(24.h),
                _buildTitle(context),
                Gap(12.h),
                _buildMessage(context),
                const Spacer(),
                if (threat.isBlocking) _buildBlockingFooter(context),
                if (!threat.isBlocking) _buildDismissButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 96.w,
      height: 96.w,
      decoration: BoxDecoration(
        color: context.color.error.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(_getIconData(), size: 48.sp, color: context.color.error),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      threat.title,
      style: context.textStyle.headlineSmall.copyWith(
        fontWeight: FontWeight.w700,
        color: context.color.error,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      threat.message,
      style: context.textStyle.bodyLarge.copyWith(
        color: context.color.text.secondary.withValues(alpha: 0.7),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBlockingFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.block_rounded,
            size: 20.sp,
            color: context.color.text.tertiary.withValues(alpha: 0.4),
          ),
          Gap(8.h),
          Text(
            'This app cannot continue in this environment.\nPlease resolve the issue and restart.',
            style: context.textStyle.bodySmall.copyWith(
              color: context.color.text.tertiary.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
          Gap(16.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: context.color.error,
              ),
              onPressed: () => exit(0),
              child: Text(
                'Close App',
                style: context.textStyle.labelLarge.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: context.color.error,
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'I Understand',
                style: context.textStyle.labelLarge.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
            ),
          ),
          Gap(8.h),
          Text(
            'Proceeding may put your data at risk.',
            style: context.textStyle.bodySmall.copyWith(
              color: context.color.text.tertiary.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconData() {
    switch (threat) {
      case ThreatType.appIntegrity:
        return Icons.gpp_bad_rounded;
      case ThreatType.obfuscationIssues:
        return Icons.code_off_rounded;
      case ThreatType.debug:
        return Icons.bug_report_rounded;
      case ThreatType.deviceBinding:
        return Icons.devices_other_rounded;
      case ThreatType.deviceId:
        return Icons.perm_device_information_rounded;
      case ThreatType.hooks:
        return Icons.phishing_rounded;
      case ThreatType.passcode:
        return Icons.lock_open_rounded;
      case ThreatType.privilegedAccess:
        return Icons.admin_panel_settings_rounded;
      case ThreatType.secureHardwareNotAvailable:
        return Icons.memory_rounded;
      case ThreatType.simulator:
        return Icons.phone_android_rounded;
      case ThreatType.systemVPN:
        return Icons.vpn_key_rounded;
      case ThreatType.devMode:
        return Icons.developer_mode_rounded;
      case ThreatType.adbEnabled:
        return Icons.usb_rounded;
      case ThreatType.unofficialStore:
        return Icons.store_rounded;
      case ThreatType.screenshot:
        return Icons.screenshot_rounded;
      case ThreatType.screenRecording:
        return Icons.videocam_rounded;
      case ThreatType.malware:
        return Icons.coronavirus_rounded;
    }
  }
}
