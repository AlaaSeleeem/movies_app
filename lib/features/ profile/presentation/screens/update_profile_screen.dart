import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/data_source/profile_remote_data_source.dart';
import '../../data/repositories_impl/profile_repository_impl.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../bloc/update_profile_bloc.dart';
import '../bloc/update_profile_event.dart';
import '../bloc/update_profile_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "/update_profile";

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int _selectedAvatar = 0;
  bool _showAvatarGrid = false;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataSource = ProfileRemoteDataSourceImpl();
    final repository = ProfileRepositoryImpl(dataSource);

    return BlocProvider(
      create: (_) => UpdateProfileBloc(
        updateProfileUseCase: UpdateProfileUseCase(repository),
        deleteAccountUseCase: DeleteAccountUseCase(repository),
        repository: repository,
      )..add(LoadProfileEvent()),
      child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            _nameController.text = state.user.name;
            _phoneController.text = state.user.phone;
            setState(() => _selectedAvatar = state.user.avatarIndex);
          } else if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is DeleteAccountSuccess) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is UpdateProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<UpdateProfileBloc>();
          final isUpdating = state is UpdateProfileLoading;
          final isDeleting = state is DeleteAccountLoading;

          return GestureDetector(
            onTap: () => setState(() => _showAvatarGrid = false),
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back,
                      color: AppColors.yellow, size: 22.sp),
                ),
                title: const Text('Pick Avatar'),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // ── Avatar ──────────────────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(
                                () => _showAvatarGrid = !_showAvatarGrid),
                        child: SizedBox(
                          width: 150.w,
                          height: 150.w,
                          child: ClipOval(
                            child: Image.asset(
                              AppAssets.avatars[_selectedAvatar],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // ── Name Field ───────────────────────────
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: 'John Safwat',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Image.asset(AppAssets.user,
                              width: 30.w, height: 30.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // ── Phone Field ──────────────────────────
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: '01200000000',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Image.asset(AppAssets.phoneIcon,
                              width: 30.w, height: 30.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Reset Password ───────────────────────
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // ── Avatar Grid ──────────────────────────
                    if (_showAvatarGrid) _buildAvatarGrid(),

                    SizedBox(height: 200.h),

                    // ── Delete Account Button ────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: isDeleting
                            ? null
                            : () => bloc.add(DeleteAccountEvent()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          disabledBackgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: isDeleting
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : Text(
                          'Delete Account',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // ── Update Data Button ───────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: isUpdating
                            ? null
                            : () => bloc.add(
                          UpdateProfileSubmitted(
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            avatarIndex: _selectedAvatar,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: AppColors.yellow,
                        ),
                        child: isUpdating
                            ? const CircularProgressIndicator(
                            color: Colors.black)
                            : Text(
                          'Update Data',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Avatar Grid ───────────────────────────────────────────
  Widget _buildAvatarGrid() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 389.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 108 / 105,
          ),
          itemCount: AppAssets.avatars.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedAvatar == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedAvatar = index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: isSelected
                      ? AppColors.yellowBorder
                      : Colors.transparent,
                  border: Border.all(color: AppColors.yellow, width: 1),
                ),
                padding: EdgeInsets.all(9.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    AppAssets.avatars[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}