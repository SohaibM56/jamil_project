import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

Future<void> showEditCardDialog({
  required BuildContext context,
  String initialName = '',
  String initialTitle = '',
  String initialPhone = '',
  required Future<void> Function({
    required String name,
    required String title,
    required String phone,
  })
  onUpdate,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (context) => _EditCardDialog(
      initialName: initialName,
      initialTitle: initialTitle,
      initialPhone: initialPhone,
      onUpdate: onUpdate,
    ),
  );
}

class _EditCardDialog extends StatefulWidget {
  const _EditCardDialog({
    required this.initialName,
    required this.initialTitle,
    required this.initialPhone,
    required this.onUpdate,
  });

  final String initialName;
  final String initialTitle;
  final String initialPhone;
  final Future<void> Function({
    required String name,
    required String title,
    required String phone,
  })
  onUpdate;

  @override
  State<_EditCardDialog> createState() => _EditCardDialogState();
}

class _EditCardDialogState extends State<_EditCardDialog> {
  late final nameController = TextEditingController(text: widget.initialName);
  late final titleController = TextEditingController(text: widget.initialTitle);
  late final phoneController = TextEditingController(text: widget.initialPhone);
  bool _isSubmitting = false;

  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(60.w, 10.h, 60.w, 28.h),
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
                60.h.height,
                _EditCardField(controller: nameController, hintText: 'Name'),
                35.h.height,
                _EditCardField(controller: titleController, hintText: 'Title'),
                35.h.height,
                _EditCardField(
                  controller: phoneController,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s()]')),
                  ],
                ),
                50.h.height,
                Row(
                  children: [
                    _isSubmitting
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              color: AppColors.primaryTeal,
                              strokeWidth: 2,
                            ),
                          )
                        : _TextAction(
                            label: 'Update',
                            color: AppColors.primaryTeal,
                            onTap: () => _submit(context),
                          ),
                    const Spacer(),
                    _TextAction(
                      label: 'Cancel',
                      color: const Color(0xFFFF5157),
                      onTap: _isSubmitting
                          ? () {}
                          : () => Navigator.of(context).pop(),
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

  Future<void> _submit(BuildContext context) async {
    setState(() => _isSubmitting = true);
    await widget.onUpdate(
      name: nameController.text.trim(),
      title: titleController.text.trim(),
      phone: phoneController.text.trim(),
    );
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}

class _EditCardField extends StatelessWidget {
  const _EditCardField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primaryTeal,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: AppTextStyles.customText30(
          fontFamily: AppTextStyles.clashDisplay,
          height: 1,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.customText24(
            fontFamily: AppTextStyles.clashDisplay,
            height: 1,
            color: Colors.black.withValues(alpha: 0.5),
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Color(0xFFF1F1F1).withValues(alpha: 0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.fromLTRB(18.w, 13.h, 18.w, 13.h),
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
            style: AppTextStyles.customText34(
              fontFamily: AppTextStyles.clashDisplay,
              height: 1,
              color: color,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.2,
            ),
          ),
        ),
      ),
    );
  }
}
