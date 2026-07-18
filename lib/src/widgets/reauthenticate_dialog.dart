import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

Future<String?> showReauthenticateDialog({
  required BuildContext context,
}) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (context) => const _ReauthenticateDialog(),
  );
}

class _ReauthenticateDialog extends StatefulWidget {
  const _ReauthenticateDialog();

  @override
  State<_ReauthenticateDialog> createState() => _ReauthenticateDialogState();
}

class _ReauthenticateDialogState extends State<_ReauthenticateDialog> {
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 28.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF707070),
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                40.h.height,
                Text(
                  'Enter Password',
                  style: AppTextStyles.customText24(
                    fontFamily: AppTextStyles.clashDisplay,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                10.h.height,
                Text(
                  'Please enter your password to confirm account deletion.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.customText16(
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                ),
                40.h.height,
                _PasswordField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                40.h.height,
                Row(
                  children: [
                    _TextAction(
                      label: 'Confirm',
                      color: AppColors.error,
                      onTap: () {
                        final password = passwordController.text.trim();
                        if (password.isNotEmpty) {
                          Navigator.of(context).pop(password);
                        }
                      },
                    ),
                    const Spacer(),
                    _TextAction(
                      label: 'Cancel',
                      color: const Color(0xFF707070),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.primaryTeal,
        style: AppTextStyles.customText18(
          fontFamily: AppTextStyles.clashDisplay,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: AppTextStyles.customText18(
            fontFamily: AppTextStyles.clashDisplay,
            color: Colors.black.withValues(alpha: 0.3),
          ),
          filled: true,
          fillColor: const Color(0xFFF1F1F1).withValues(alpha: 0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF707070),
              size: 20.sp,
            ),
            onPressed: onToggleVisibility,
          ),
        ),
      ),
    );
  }
}

class _TextAction extends StatelessWidget {
  const _TextAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: color, width: 1.8.w),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Text(
            label,
            style: AppTextStyles.customText24(
              fontFamily: AppTextStyles.clashDisplay,
              height: 1,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
