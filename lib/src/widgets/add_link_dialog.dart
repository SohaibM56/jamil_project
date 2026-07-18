import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/config/padding_extensions.dart';
import 'package:jamil_project/src/utils/social_link_validator.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';
import 'package:jamil_project/src/widgets/dashboard_icons.dart';

Future<void> showAddLinkDialog({
  required BuildContext context,
  required SocialIconType iconType,
  String initialUrl = '',
  required Future<void> Function(String url) onAddLink,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (context) => _AddLinkDialog(
      iconType: iconType,
      initialUrl: initialUrl,
      onAddLink: onAddLink,
    ),
  );
}

class _AddLinkDialog extends StatefulWidget {
  const _AddLinkDialog({
    required this.iconType,
    required this.initialUrl,
    required this.onAddLink,
  });

  final SocialIconType iconType;
  final String initialUrl;
  final Future<void> Function(String url) onAddLink;

  @override
  State<_AddLinkDialog> createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<_AddLinkDialog> {
  late final urlController = TextEditingController(text: widget.initialUrl);
  bool _isSubmitting = false;
  String? _errorText;

  bool get _isEditing => widget.initialUrl.isNotEmpty;

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(48.w, 10.h, 48.w, 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(38.r)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF737373),
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                50.h.height,
                Row(
                  children: [
                    SocialIcon(type: widget.iconType, size: 40.w),
                    16.w.width,
                    Container(
                      width: 2.w,
                      height: 20.h,
                      color: const Color(0xFFD8D8D8),
                    ),
                    16.w.width,
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: TextField(
                          controller: urlController,
                          cursorColor: AppColors.primaryTeal,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          style: AppTextStyles.customText26(
                            fontFamily: AppTextStyles.clashDisplay,
                            color: Colors.black,
                            height: 1,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. ${widget.iconType.exampleDomain}/you',
                            hintStyle: TextStyle(
                              fontFamily: 'Satoshi',
                              fontSize: 20.sp,
                              color: const Color(0xFF747474),
                              height: 1,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF0F0F0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 5.h,
                            ),
                          ),
                          onSubmitted: (_) => _submit(context),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_errorText != null) ...[
                  8.h.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _errorText!,
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 16.sp,
                        color: const Color(0xFFFF5157),
                      ),
                    ),
                  ),
                ],
                28.h.height,
                Container(
                  width: 190.w,
                  height: 2.h,
                  color: const Color(0xFFD6D6D6),
                ),
                30.h.height,
                _isSubmitting
                    ? SizedBox(
                        height: 40.h,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryTeal,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : _DialogButton(
                        label: _isEditing ? 'Update link' : 'Add link',
                        color: const Color(0xFFC8FFF7),
                        onTap: () => _submit(context),
                      ).paddingHorizontal(20.w),
                16.h.height,
                _DialogButton(
                  label: 'Cancel',
                  color: const Color(0xFFDCD8D8),
                  onTap: _isSubmitting
                      ? () {}
                      : () => Navigator.of(context).pop(),
                ).paddingHorizontal(20.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final url = urlController.text.trim();

    if (!widget.iconType.isValidUrl(url)) {
      setState(() {
        _errorText = 'Enter a valid ${widget.iconType.exampleDomain} link.';
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isSubmitting = true;
    });

    await widget.onAddLink(widget.iconType.normalizeUrl(url));

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
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
      child: Container(
        width: double.infinity,
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.black, width: 1.2.w),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 26.sp,
            height: 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
