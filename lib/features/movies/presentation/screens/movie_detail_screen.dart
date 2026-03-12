import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFF121312);
const Color kCardColor = Color(0xFF282A28);
const Color kAccentYellow = Color(0xFFF6BD00);
const Color kAccentRed = Color(0xFFE82626);
const Color kGreyTextColor = Color(0xFFADADAD);

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});
  static const String routeName = '/movie-details';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: CustomScrollView(
          slivers: [

          SliverAppBar(
          pinned: true,
          backgroundColor: kBackgroundColor,
          elevation: 0,

          expandedHeight: screenHeight * 0.4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.white, size: 28),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/onboarding5.jpg',
                  fit: BoxFit.cover,

                  alignment: Alignment.topCenter,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, kBackgroundColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  left:(screenWidth/2)-37.5,
                  top:(screenHeight*0.4)*0.45,
                  child: Image.asset(
                    'assets/images/img.png',
                    width: 75,
                    height: 75,
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                    children: [
                    const SizedBox(height: 16),
                const Text(
                  'Doctor Strange in the Multiverse of Madness',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text('2022', style: TextStyle(color: kGreyTextColor, fontSize: 16)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentRed,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  ),
                    child: const Text('Watch', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
    /* children: [
                          _buildStatItem(icon: Icons.favorite, value: '15'),
                          const SizedBox(width: 25),
                          _buildStatItem(icon: Icons.access_time_filled, value: '90'),
                          const SizedBox(width: 25),_buildStatItem(icon: Icons.star, value: '7.6'),
                        ],*/

                  children: [

                    Expanded(child: _buildStatItem(icon: Icons.favorite, value: '15')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatItem(icon: Icons.access_time_filled, value: '90')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatItem(icon: Icons.star, value: '7.6')),
                  ],

                ),
                    ],
                ),
            ),
        ),


        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
          sliver: SliverList(
              delegate: SliverChildListDelegate(
              [
              _buildSectionTitle('Screen Shots'),
              const SizedBox(height: 16),
              _buildScreenshot('assets/images/img_1.png'),
              const SizedBox(height: 16),
              _buildScreenshot('assets/images/img_2.png'),
              const SizedBox(height: 16),
              _buildScreenshot('assets/images/img_4.png'),
              const SizedBox(height: 32),


              _buildSectionTitle('Similar'),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 190 / 280,
                children: [
                  _buildSimilarMovieCard('assets/images/img_5.png'),
                  _buildSimilarMovieCard('assets/images/img_6.png'),
                  _buildSimilarMovieCard('assets/images/img_7.png'),
                  _buildSimilarMovieCard('assets/images/img_8.png'),
                ],
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('Summary'),
              const SizedBox(height: 12),
              Text(
                'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346',
                style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 15, height: 1.6),
              ),
              const SizedBox(height: 32),_buildSectionTitle('Cast'),
              const SizedBox(height: 16),

              _buildCastCard('assets/images/img_9.png', 'Name:Hayley Atwell', 'Captain Carter'),
              const SizedBox(height: 12),
              _buildCastCard('assets/images/img_3.png', 'Name:Elizabeth Olsen', 'Wanda Maximoff/The Scarlet Wtch'),
              const SizedBox(height: 12),
              _buildCastCard('assets/images/img_10.png', 'Name:Rachel McAdams', 'Dr. Christine Palmer'),
              const SizedBox(height: 12),
              _buildCastCard('assets/images/img_11.png', 'Name:Charlize Theron', 'Clea'),
              const SizedBox(height: 32),



              _buildSectionTitle('Genres'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildGenreChip('Action')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildGenreChip('Sci-Fi')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildGenreChip('Adventure')),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                  children: [
              Expanded(child: _buildGenreChip('Fantasy')),const SizedBox(width: 12),
                    Expanded(child: _buildGenreChip('Horror')),
                    const SizedBox(width: 12),
                    const Spacer(),
                  ],
              ),
                const SizedBox(height: 50),
              ],
              ),
          ),
        ),
          ],
        ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold));

  Widget _buildScreenshot(String imagePath) => ClipRRect(borderRadius: BorderRadius.circular(16.0), child: Image.asset(imagePath, fit: BoxFit.cover));

  Widget _buildSimilarMovieCard(String imagePath) => ClipRRect(borderRadius: BorderRadius.circular(16.0), child: Image.asset(imagePath, fit: BoxFit.cover));

  Widget _buildCastCard(String imagePath, String name, String character) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Image.asset(imagePath, width: 65, height: 65, fit: BoxFit.cover)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text('Character: $character', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(12.0)),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15))),
    );
  }

  Widget _buildStatItem({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kAccentYellow, size: 20),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}