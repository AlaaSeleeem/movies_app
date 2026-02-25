import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/// =======================
/// Primary Button
/// =======================
class PrimaryButton extends StatelessWidget {
final String text;
final VoidCallback onPressed;

const PrimaryButton({
super.key,
required this.text,
required this.onPressed,
});

@override
Widget build(BuildContext context) {
return SizedBox(
height: 56.h,
width: double.infinity,
child: ElevatedButton(
onPressed: onPressed,
child: Text(
text,
style: TextStyle(
color: AppColors.black,
fontSize: 18.sp,
fontWeight: FontWeight.w700,
),
),
),
);
}
}

/// =======================
/// Secondary Button
/// =======================
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side:  BorderSide(color: AppColors.yellow, width: 2.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

/// =======================
/// Reusable Bottom Card
/// =======================
class OnboardingBottomCard extends StatelessWidget {
  final String title;
  final String? description;
  final String primaryText;
  final VoidCallback onPrimary;
  final VoidCallback? onBack;
  final double heightFactor;
  final double? titleSize;
  final double?descriptionSize;
  final int? maxDescriptionLines;

  const OnboardingBottomCard({
    super.key,
    required this.title,
    this.description,
    required this.primaryText,
    required this.onPrimary,
    this.onBack,
    this.heightFactor = 0.34,
    this.titleSize,
    this.descriptionSize,
    this.maxDescriptionLines,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * heightFactor,
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.88),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height:12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: AppColors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (description != null) ...[
              SizedBox(height: 12.h),
              Text(
                description!,
                textAlign: TextAlign.center,
                maxLines:maxDescriptionLines,
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.85),
                  fontSize: 17.sp,
                  height: 1.6.h,
                ),
              ),
            ],
            const SizedBox(height: 24),
            PrimaryButton(text: primaryText, onPressed: onPrimary),
            if (onBack != null) ...[
              SizedBox(height: 16.h),
              SecondaryButton(text: 'Back', onPressed: onBack!),
            ],
          ],
        ),
      ),
    );
  }
}

/// =======================
/// Screen 1 (Different Layout)
/// =======================
class OnboardingIntroScreen extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingIntroScreen({super.key, required this.onNext});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/onboarding1.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Find Your Next\nFavorite Movie Here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: size.width * 0.075,
                    fontWeight: FontWeight.w700,
                    height: 1.2.h,
                  ),
                ),
                 SizedBox(height: 16.h),
                Text(
                  'Get access to a huge library of movies\n'
                      'to suit all tastes. You will surely like it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: size.width * 0.04,
                    height: 1.4.h,
                  ),
                ),
                SizedBox(height: 32.h),
                PrimaryButton(text: 'Explore Now', onPressed: onNext),
                 SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// =======================
/// Generic Screen 2–6
/// =======================
class OnboardingImageScreen extends StatelessWidget {
  final String image;
  final double overlayOpacity;
  final Widget bottomCard;

  const OnboardingImageScreen({
    super.key,
    required this.image,
    required this.bottomCard,
    this.overlayOpacity = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.black.withOpacity(overlayOpacity),
          ),
        ),
        bottomCard,
      ],
    );
  }
}