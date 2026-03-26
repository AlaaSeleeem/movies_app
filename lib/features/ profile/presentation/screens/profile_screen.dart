import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_assets.dart';
import 'package:movies_app/features/%20profile/presentation/screens/update_profile_screen.dart';
import 'package:movies_app/features/movies/presentation/screens/movie_detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: uid != null
              ? FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots()
              : null,
          builder: (context, userSnapshot) {
            final userData = userSnapshot.data?.data() as Map<String, dynamic>?;
            final userName = userData?['name'] ?? 'John Safwat';
            final avatarIndex = userData?['avatarIndex'] ?? 0;

            return Column(
              children: [
                // ── Header ─────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Avatar ───────────────────────────────
                      ClipOval(
                        child: Image.asset(
                          AppAssets.avatars[avatarIndex],
                          width: 118.w,
                          height: 118.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.w),

                      // ── Stats ─────────────────────────────────
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Wish List Count
                                StreamBuilder<QuerySnapshot>(
                                  stream: uid != null
                                      ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .collection('watchlist')
                                      .snapshots()
                                      : null,
                                  builder: (context, snapshot) {
                                    final count =
                                        snapshot.data?.docs.length ?? 0;
                                    return _buildStat(
                                        count.toString(), 'Wish List');
                                  },
                                ),
                                // History Count
                                StreamBuilder<QuerySnapshot>(
                                  stream: uid != null
                                      ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .collection('history')
                                      .snapshots()
                                      : null,
                                  builder: (context, snapshot) {
                                    final count =
                                        snapshot.data?.docs.length ?? 0;
                                    return _buildStat(
                                        count.toString(), 'History');
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              userName,
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Buttons ────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      // Edit Profile
                      Expanded(
                        child: SizedBox(
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              UpdateProfileScreen.routeName,
                            ),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),

                      // Exit
                      SizedBox(
                        width: 135.w,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: () => _logout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Exit',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.logout,
                                  color: AppColors.white, size: 18.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Tabs ───────────────────────────────────────
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.yellow,
                  labelColor: AppColors.yellow,
                  unselectedLabelColor: AppColors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.list_alt, size: 24.sp),
                      text: 'Watch List',
                    ),
                    Tab(
                      icon: Icon(Icons.folder, size: 24.sp),
                      text: 'History',
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // ── Tab Content ────────────────────────────────
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // ── Watch List ─────────────────────────
                      uid == null
                          ? _buildEmpty()
                          : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('watchlist')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return _buildEmpty();
                          }
                          return _buildMovieGrid(snapshot.data!.docs);
                        },
                      ),

                      // ── History ────────────────────────────
                      uid == null
                          ? _buildEmpty()
                          : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('history')
                            .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return _buildEmpty();
                          }
                          return _buildMovieGrid(snapshot.data!.docs);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'Roboto',
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'Roboto',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Image.asset(
        AppAssets.emptySearchResult,
        width: 124.w,
        height: 124.w,
      ),
    );
  }

  Widget _buildMovieGrid(List<QueryDocumentSnapshot> docs) {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 122 / 179,
      ),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            MovieDetailsScreen.routeName,
            arguments: data['id'] as int,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  data['image'] ?? '',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.grey),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 6.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xB5121312),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${data['rating'] ?? ''}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(Icons.star,
                          color: AppColors.yellow, size: 12.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}