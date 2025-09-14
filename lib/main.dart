// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:async';
//
// void main() {
//   runApp(BhaktiSandeshApp());
// }
//
// class BhaktiSandeshApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bhakti Sandesh',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         primaryColor: Color(0xFFFF6B35),
//         fontFamily: 'Noto Sans',
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         appBarTheme: AppBarTheme(
//           elevation: 0,
//           backgroundColor: Color(0xFFFF6B35),
//           foregroundColor: Colors.white,
//           titleTextStyle: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFFFF6B35),
//             foregroundColor: Colors.white,
//             elevation: 2,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ),
//       home: SplashScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//
//     _controller.forward();
//
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(
//         context,
//       ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
//           ),
//         ),
//         child: Center(
//           child: FadeTransition(
//             opacity: _animation,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.auto_stories,
//                     size: 60,
//                     color: Color(0xFFFF6B35),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 Text(
//                   'भक्ति संदेश',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   'Bhakti Sandesh',
//                   style: TextStyle(fontSize: 18, color: Colors.white70),
//                 ),
//                 SizedBox(height: 40),
//                 Center(child: AnimatedLoadingWidget())
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class WordPressService {
//   static const String baseUrl = 'https://bhaktisandesh.com/wp-json/wp/v2';
//   static const int postsPerPage = 10;
//
//   static Future<List<Category>> getCategories() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/categories?per_page=100'),
//         headers: {'Accept': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         return data.map((item) => Category.fromJson(item)).toList();
//       } else {
//         throw Exception('Failed to load categories');
//       }
//     } catch (e) {
//       throw Exception('Network error: $e');
//     }
//   }
//
//   static Future<List<Post>> getPosts({int page = 1, int? categoryId}) async {
//     try {
//       String url = '$baseUrl/posts?per_page=$postsPerPage&page=$page&_embed';
//       if (categoryId != null) {
//         url += '&categories=$categoryId';
//       }
//
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Accept': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         return data.map((item) => Post.fromJson(item)).toList();
//       } else {
//         throw Exception('Failed to load posts');
//       }
//     } catch (e) {
//       throw Exception('Network error: $e');
//     }
//   }
//
//   static Future<List<Post>> searchPosts(String query) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/posts?search=$query&per_page=50&_embed'),
//         headers: {'Accept': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         return data.map((item) => Post.fromJson(item)).toList();
//       } else {
//         throw Exception('Failed to search posts');
//       }
//     } catch (e) {
//       throw Exception('Network error: $e');
//     }
//   }
// }
//
// class Category {
//   final int id;
//   final String name;
//   final String slug;
//   final int count;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.count,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//       count: json['count'],
//     );
//   }
// }
//
// class Post {
//   final int id;
//   final String title;
//   final String content;
//   final String excerpt;
//   final String date;
//   final String? featuredImageUrl;
//   final List<String> categories;
//
//   Post({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.excerpt,
//     required this.date,
//     this.featuredImageUrl,
//     required this.categories,
//   });
//
//   factory Post.fromJson(Map<String, dynamic> json) {
//     String? imageUrl;
//     if (json['_embedded'] != null &&
//         json['_embedded']['wp:featuredmedia'] != null &&
//         json['_embedded']['wp:featuredmedia'].isNotEmpty) {
//       imageUrl = json['_embedded']['wp:featuredmedia'][0]['source_url'];
//     }
//
//     List<String> categoryNames = [];
//     if (json['_embedded'] != null &&
//         json['_embedded']['wp:term'] != null &&
//         json['_embedded']['wp:term'].isNotEmpty) {
//       categoryNames = json['_embedded']['wp:term'][0]
//           .map<String>((cat) => cat['name'] as String)
//           .toList();
//     }
//
//     return Post(
//       id: json['id'],
//       title: _stripHtmlTags(json['title']['rendered']),
//       content: json['content']['rendered'],
//       excerpt: _stripHtmlTags(json['excerpt']['rendered']),
//       date: json['date'],
//       featuredImageUrl: imageUrl,
//       categories: categoryNames,
//     );
//   }
//
//   static String _stripHtmlTags(String htmlString) {
//     RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
//     return htmlString.replaceAll(exp, '').trim();
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<Category> categories = [];
//   List<Post> recentPosts = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     try {
//       final categoriesData = await WordPressService.getCategories();
//       final postsData = await WordPressService.getPosts();
//       setState(() {
//         categories = categoriesData.where((cat) => cat.count > 0).toList();
//         recentPosts = postsData;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load data: ${e.toString()}')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(Icons.auto_stories, color: Colors.white),
//             SizedBox(width: 8),
//             Text('भक्ति संदेश'),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: PostSearchDelegate());
//             },
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Categories'),
//             Tab(text: 'Recent Posts'),
//           ],
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//         ),
//       ),
//       body: isLoading
//           ? Center(child: AnimatedLoadingWidget())
//           : TabBarView(
//               controller: _tabController,
//               children: [_buildCategoriesTab(), _buildRecentPostsTab()],
//             ),
//     );
//   }
//
//   Widget _buildCategoriesTab() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.orange.shade50, Colors.white],
//         ),
//       ),
//       child: categories.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.category, size: 64, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text('No categories found'),
//                 ],
//               ),
//             )
//           : GridView.builder(
//               padding: EdgeInsets.all(16),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 1.2,
//               ),
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 final category = categories[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CategoryPostsScreen(category: category),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 8,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Color(0xFFFF6B35).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Icon(
//                             _getCategoryIcon(category.name),
//                             size: 30,
//                             color: Color(0xFFFF6B35),
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           category.name,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey[800],
//                           ),
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '${category.count} posts',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
//
//   Widget _buildRecentPostsTab() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.orange.shade50, Colors.white],
//         ),
//       ),
//       child: recentPosts.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.article, size: 64, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text('No posts found'),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: recentPosts.length,
//               itemBuilder: (context, index) {
//                 final post = recentPosts[index];
//                 return PostCard(post: post);
//               },
//             ),
//     );
//   }
//
//   IconData _getCategoryIcon(String categoryName) {
//     final name = categoryName.toLowerCase();
//     if (name.contains('mantra') || name.contains('मंत्र')) {
//       return Icons.brightness_7;
//     } else if (name.contains('chalisa') || name.contains('चालीसा')) {
//       return Icons.auto_stories;
//     } else if (name.contains('aarti') || name.contains('आरती')) {
//       return Icons.local_fire_department;
//     } else if (name.contains('bhajan') || name.contains('भजन')) {
//       return Icons.music_note;
//     } else if (name.contains('stotra') || name.contains('स्तोत्र')) {
//       return Icons.menu_book;
//     } else {
//       return Icons.category;
//     }
//   }
// }
//
// class PostCard extends StatelessWidget {
//   final Post post;
//
//   const PostCard({Key? key, required this.post}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EnhancedPostDetailScreen(post: post),
//             ),
//           );
//         },
//         borderRadius: BorderRadius.circular(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (post.featuredImageUrl != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 child: Image.network(
//                   post.featuredImageUrl!,
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: 200,
//                       color: Colors.grey[300],
//                       child: Icon(Icons.image_not_supported, size: 50),
//                     );
//                   },
//                 ),
//               ),
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (post.categories.isNotEmpty)
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFF6B35).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         post.categories.first,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFFFF6B35),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 8),
//                   Text(
//                     post.title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 8),
//                   if (post.excerpt.isNotEmpty)
//                     Text(
//                       post.excerpt,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                         height: 1.4,
//                       ),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.access_time,
//                         size: 16,
//                         color: Colors.grey[500],
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         _formatDate(post.date),
//                         style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                       ),
//                       Spacer(),
//                       Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: Colors.grey[400],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _formatDate(String dateString) {
//     try {
//       DateTime date = DateTime.parse(dateString);
//       return '${date.day}/${date.month}/${date.year}';
//     } catch (e) {
//       return 'Unknown date';
//     }
//   }
// }
//
// class CategoryPostsScreen extends StatefulWidget {
//   final Category category;
//
//   const CategoryPostsScreen({Key? key, required this.category})
//     : super(key: key);
//
//   @override
//   _CategoryPostsScreenState createState() => _CategoryPostsScreenState();
// }
//
// class _CategoryPostsScreenState extends State<CategoryPostsScreen> {
//   List<Post> posts = [];
//   bool isLoading = true;
//   bool hasMorePosts = true;
//   int currentPage = 1;
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPosts();
//     _scrollController.addListener(_onScroll);
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       if (hasMorePosts && !isLoading) {
//         _loadMorePosts();
//       }
//     }
//   }
//
//   Future<void> _loadPosts() async {
//     try {
//       final newPosts = await WordPressService.getPosts(
//         page: 1,
//         categoryId: widget.category.id,
//       );
//       setState(() {
//         posts = newPosts;
//         isLoading = false;
//         currentPage = 1;
//         hasMorePosts = newPosts.length == WordPressService.postsPerPage;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load posts: ${e.toString()}')),
//       );
//     }
//   }
//
//   Future<void> _loadMorePosts() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       final newPosts = await WordPressService.getPosts(
//         page: currentPage + 1,
//         categoryId: widget.category.id,
//       );
//       setState(() {
//         posts.addAll(newPosts);
//         currentPage++;
//         hasMorePosts = newPosts.length == WordPressService.postsPerPage;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.category.name), elevation: 0),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.orange.shade50, Colors.white],
//           ),
//         ),
//         child: posts.isEmpty && !isLoading
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.article, size: 64, color: Colors.grey),
//                     SizedBox(height: 16),
//                     Text('No posts found in this category'),
//                   ],
//                 ),
//               )
//             : ListView.builder(
//                 controller: _scrollController,
//                 padding: EdgeInsets.all(16),
//                 itemCount: posts.length + (hasMorePosts ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index < posts.length) {
//                     return PostCard(post: posts[index]);
//                   } else {
//                     return Column(
//                       children: [
//                         SizedBox(height: MediaQuery.of(context).size.height * .3,),
//                         Padding(
//                           padding: EdgeInsets.all(16),
//                           child: AnimatedLoadingWidget(),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//       ),
//     );
//   }
// }
//
//
//
// class EnhancedPostDetailScreen extends StatefulWidget {
//   final Post post;
//
//   const EnhancedPostDetailScreen({Key? key, required this.post}) : super(key: key);
//
//   @override
//   _EnhancedPostDetailScreenState createState() => _EnhancedPostDetailScreenState();
// }
//
// class _EnhancedPostDetailScreenState extends State<EnhancedPostDetailScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   bool _isBookmarked = false;
//   double _fontSize = 16.0;
//   bool _isDarkMode = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           _buildSliverAppBar(),
//           SliverToBoxAdapter(
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: Column(
//                   children: [
//                     _buildPostHeader(),
//                     _buildControlPanel(),
//                     _buildContentSection(),
//                     _buildActionButtons(),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSliverAppBar() {
//     return SliverAppBar(
//       expandedHeight: widget.post.featuredImageUrl != null ? 300.0 : 120.0,
//       floating: false,
//       pinned: true,
//       backgroundColor: _isDarkMode ? Colors.grey[900] : Color(0xFFFF6B35),
//       flexibleSpace: FlexibleSpaceBar(
//         title: Container(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.7),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             widget.post.title,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         background: widget.post.featuredImageUrl != null
//             ? Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               widget.post.featuredImageUrl!,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
//                     ),
//                   ),
//                   child: Icon(Icons.auto_stories, size: 80, color: Colors.white),
//                 );
//               },
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Colors.black.withOpacity(0.7),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )
//             : Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
//             ),
//           ),
//           child: Icon(Icons.auto_stories, size: 80, color: Colors.white),
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
//           onPressed: () {
//             setState(() {
//               _isBookmarked = !_isBookmarked;
//             });
//             _showSnackBar(_isBookmarked ? 'Bookmarked!' : 'Bookmark removed');
//           },
//         ),
//         PopupMenuButton<String>(
//           onSelected: (value) {
//             switch (value) {
//               case 'share':
//                 _sharePost();
//                 break;
//               case 'copy':
//                 _copyToClipboard();
//                 break;
//               case 'dark_mode':
//                 setState(() {
//                   _isDarkMode = !_isDarkMode;
//                 });
//                 break;
//             }
//           },
//           itemBuilder: (BuildContext context) => [
//             PopupMenuItem(
//               value: 'share',
//               child: Row(
//                 children: [
//                   Icon(Icons.share, size: 20),
//                   SizedBox(width: 8),
//                   Text('Share'),
//                 ],
//               ),
//             ),
//             PopupMenuItem(
//               value: 'copy',
//               child: Row(
//                 children: [
//                   Icon(Icons.copy, size: 20),
//                   SizedBox(width: 8),
//                   Text('Copy Text'),
//                 ],
//               ),
//             ),
//             PopupMenuItem(
//               value: 'dark_mode',
//               child: Row(
//                 children: [
//                   Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 20),
//                   SizedBox(width: 8),
//                   Text(_isDarkMode ? 'Light Mode' : 'Dark Mode'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPostHeader() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.post.categories.isNotEmpty)
//             Container(
//               margin: EdgeInsets.only(bottom: 12),
//               child: Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: widget.post.categories.map((category) {
//                   return Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.orange.withOpacity(0.3),
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       category,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           Text(
//             widget.post.title,
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: _isDarkMode ? Colors.white : Colors.grey[800],
//               height: 1.3,
//             ),
//           ),
//           SizedBox(height: 16),
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: _isDarkMode ? Colors.grey[800] : Colors.orange.shade50,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: _isDarkMode ? Colors.grey[700]! : Colors.orange.shade100,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.access_time,
//                   size: 16,
//                   color: _isDarkMode ? Colors.grey[400] : Colors.orange[600],
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   _formatDate(widget.post.date),
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
//                   ),
//                 ),
//                 Spacer(),
//                 Icon(
//                   Icons.remove_red_eye,
//                   size: 16,
//                   color: _isDarkMode ? Colors.grey[400] : Colors.orange[600],
//                 ),
//                 SizedBox(width: 4),
//                 Text(
//                   'Reading time: ${_calculateReadingTime(widget.post.content)} min',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlPanel() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _isDarkMode ? Colors.grey[800] : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildControlButton(
//             icon: Icons.text_decrease,
//             label: 'A-',
//             onPressed: () => setState(() {
//               if (_fontSize > 12) _fontSize -= 2;
//             }),
//           ),
//           _buildControlButton(
//             icon: Icons.text_increase,
//             label: 'A+',
//             onPressed: () => setState(() {
//               if (_fontSize < 24) _fontSize += 2;
//             }),
//           ),
//           _buildControlButton(
//             icon: _isDarkMode ? Icons.light_mode : Icons.dark_mode,
//             label: _isDarkMode ? 'Light' : 'Dark',
//             onPressed: () => setState(() {
//               _isDarkMode = !_isDarkMode;
//             }),
//           ),
//           _buildControlButton(
//             icon: Icons.content_copy,
//             label: 'Copy',
//             onPressed: _copyToClipboard,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Color(0xFFFF6B35).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               size: 20,
//               color: Color(0xFFFF6B35),
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContentSection() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: _isDarkMode ? Colors.grey[800] : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: SingleChildScrollView(
//         child: Html(
//           data: widget.post.content,
//           style: {
//             'body': Style(
//               fontSize: FontSize(_fontSize),
//               color: _isDarkMode ? Colors.grey[200] : Colors.grey[800],
//               lineHeight: LineHeight(1.8),
//               textAlign: TextAlign.justify,
//             ),
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return Container(
//       margin: EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton.icon(
//               onPressed: _sharePost,
//               icon: Icon(Icons.share),
//               label: Text('Share'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: OutlinedButton.icon(
//               onPressed: () {
//                 setState(() {
//                   _isBookmarked = !_isBookmarked;
//                 });
//                 _showSnackBar(_isBookmarked ? 'Bookmarked!' : 'Bookmark removed');
//               },
//               icon: Icon(
//                 _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                 color: Color(0xFFFF6B35),
//               ),
//               label: Text(
//                 _isBookmarked ? 'Bookmarked' : 'Bookmark',
//                 style: TextStyle(color: Color(0xFFFF6B35)),
//               ),
//               style: OutlinedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 side: BorderSide(color: Color(0xFFFF6B35)),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatDate(String dateString) {
//     try {
//       DateTime date = DateTime.parse(dateString);
//       List<String> months = [
//         'January', 'February', 'March', 'April', 'May', 'June',
//         'July', 'August', 'September', 'October', 'November', 'December'
//       ];
//       return '${date.day} ${months[date.month - 1]}, ${date.year}';
//     } catch (e) {
//       return 'Unknown date';
//     }
//   }
//
//   int _calculateReadingTime(String content) {
//     final wordCount = content.split(' ').length;
//     return (wordCount / 200).ceil();
//   }
//
//   void _sharePost() {
//     _showSnackBar('Share functionality - Coming soon!');
//   }
//
//   void _copyToClipboard() {
//     Clipboard.setData(ClipboardData(text: '${widget.post.title}\n\n${widget.post.content}'));
//     _showSnackBar('Content copied to clipboard!');
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Color(0xFFFF6B35),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }
// }
//
//
// class PostSearchDelegate extends SearchDelegate<String> {
//   List<Post> searchResults = [];
//   bool isSearching = false;
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           searchResults.clear();
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     if (query.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.search, size: 64, color: Colors.grey),
//             SizedBox(height: 16),
//             Text('Enter search terms to find posts'),
//           ],
//         ),
//       );
//     }
//
//     return FutureBuilder<List<Post>>(
//       future: WordPressService.searchPosts(query),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: AnimatedLoadingWidget());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.search_off, size: 64, color: Colors.grey),
//                 SizedBox(height: 16),
//                 Text('No posts found for "$query"'),
//               ],
//             ),
//           );
//         } else {
//           return ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return PostCard(post: snapshot.data![index]);
//             },
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.isEmpty) {
//       return Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.orange.shade50, Colors.white],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.search, size: 64, color: Colors.grey),
//               SizedBox(height: 16),
//               Text(
//                 'Search for mantras, chalisas, and more...',
//                 style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 24),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Popular searches:',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: [
//                         _buildSearchChip('Hanuman Chalisa', context),
//                         _buildSearchChip('Gayatri Mantra', context),
//                         _buildSearchChip('Vishnu Sahasranama', context),
//                         _buildSearchChip('Durga Aarti', context),
//                         _buildSearchChip('Shiva Mantra', context),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     // Show search results as suggestions
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.orange.shade50, Colors.white],
//         ),
//       ),
//       child: FutureBuilder<List<Post>>(
//         future: WordPressService.searchPosts(query),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Color(0xFFFF6B35),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Searching...',
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//                   SizedBox(height: 16),
//                   Text(
//                     'Search error occurred',
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Please try again',
//                     style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
//                   SizedBox(height: 16),
//                   Text(
//                     'No results found for "$query"',
//                     style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Try different keywords',
//                     style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: snapshot.data!.length > 10
//                   ? 10
//                   : snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final post = snapshot.data![index];
//                 return Card(
//                   margin: EdgeInsets.only(bottom: 12),
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(12),
//                     leading: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFFFF6B35).withOpacity(0.8),
//                             Color(0xFFFF8C42).withOpacity(0.8),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: Icon(
//                         Icons.auto_stories,
//                         color: Colors.white,
//                         size: 24,
//                       ),
//                     ),
//                     title: Text(
//                       post.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 4),
//                         if (post.excerpt.isNotEmpty)
//                           Text(
//                             post.excerpt,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         SizedBox(height: 4),
//                         if (post.categories.isNotEmpty)
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 6,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Color(0xFFFF6B35).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Text(
//                               post.categories.first,
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Color(0xFFFF6B35),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     trailing: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 16,
//                       color: Colors.grey[400],
//                     ),
//                     onTap: () {
//                       close(context, post.title);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EnhancedPostDetailScreen(post: post),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildSearchChip(String text, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         query = text;
//         showResults(context);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Color(0xFFFF6B35).withOpacity(0.3)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 12,
//             color: Color(0xFFFF6B35),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
// class AnimatedLoadingWidget extends StatefulWidget {
//   const AnimatedLoadingWidget({super.key});
//
//   @override
//   State<AnimatedLoadingWidget> createState() => _AnimatedLoadingWidgetState();
// }
//
// class _AnimatedLoadingWidgetState extends State<AnimatedLoadingWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.rotate(
//             angle: _rotationAnimation.value,
//             child: Transform.scale(
//               scale: _scaleAnimation.value,
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.orange.withOpacity(0.4),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.auto_stories,
//                   size: 60,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const platform = MethodChannel('com.pkbhai.bhaktisandesh/admob');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final String admobAppId = await _initializeRemoteConfig();
  try {
    await platform.invokeMethod('setAdMobAppId', {'appId': admobAppId});
    await MobileAds.instance.initialize();
  } catch (e) {
    print('Error initializing AdMob: $e');
  }
  runApp(const BhaktiSandeshApp());
}

Future<String> _initializeRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  try {
    await remoteConfig.setDefaults({
      'admob_app_id': 'ca-app-pub-3940256099942544~3347511713', // Fallback test App ID
      'banner_ad_unit_id': 'ca-app-pub-3940256099942544/6300978111', // Fallback test ad unit ID
    });
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.fetchAndActivate();
    String admobAppId = remoteConfig.getString('admob_app_id');
    return admobAppId.isNotEmpty
        ? admobAppId
        : 'ca-app-pub-3940256099942544~3347511713';
  } catch (e) {
    print('Error fetching Remote Config: $e');
    return 'ca-app-pub-3940256099942544~3347511713';
  }
}

class BhaktiSandeshApp extends StatelessWidget {
  const BhaktiSandeshApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhakti Sandesh',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF6B35),
        fontFamily: 'Noto Sans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFFF6B35),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_stories,
                    size: 60,
                    color: Color(0xFFFF6B35),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'भक्ति संदेश',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Bhakti Sandesh',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                const Center(child: AnimatedLoadingWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WordPressService {
  static const String baseUrl = 'https://bhaktisandesh.com/wp-json/wp/v2';
  static const int postsPerPage = 10;

  static Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories?per_page=100'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Category.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Post>> getPosts({int page = 1, int? categoryId}) async {
    try {
      String url = '$baseUrl/posts?per_page=$postsPerPage&page=$page&_embed';
      if (categoryId != null) {
        url += '&categories=$categoryId';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Post>> searchPosts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?search=$query&per_page=50&_embed'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search posts');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final int count;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.count,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      count: json['count'],
    );
  }
}

class Post {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String date;
  final String? featuredImageUrl;
  final List<String> categories;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.date,
    this.featuredImageUrl,
    required this.categories,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json['_embedded'] != null &&
        json['_embedded']['wp:featuredmedia'] != null &&
        json['_embedded']['wp:featuredmedia'].isNotEmpty) {
      imageUrl = json['_embedded']['wp:featuredmedia'][0]['source_url'];
    }

    List<String> categoryNames = [];
    if (json['_embedded'] != null &&
        json['_embedded']['wp:term'] != null &&
        json['_embedded']['wp:term'].isNotEmpty) {
      categoryNames = json['_embedded']['wp:term'][0]
          .map<String>((cat) => cat['name'] as String)
          .toList();
    }

    return Post(
      id: json['id'],
      title: _stripHtmlTags(json['title']['rendered']),
      content: json['content']['rendered'],
      excerpt: _stripHtmlTags(json['excerpt']['rendered']),
      date: json['date'],
      featuredImageUrl: imageUrl,
      categories: categoryNames,
    );
  }

  static String _stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').trim();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Category> categories = [];
  List<Post> recentPosts = [];
  bool isLoading = true;
  BannerAd? _bannerAd;
  String? _bannerAdUnitId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
    _loadAdUnitId();
  }

  Future<void> _loadAdUnitId() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      String adUnitId = remoteConfig.getString('banner_ad_unit_id');
      if (adUnitId.isEmpty) {
        adUnitId = 'ca-app-pub-3940256099942544/6300978111';
      }
      setState(() {
        _bannerAdUnitId = adUnitId;
        _bannerAd = BannerAd(
          adUnitId: _bannerAdUnitId!,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (_) => setState(() {}),
            onAdFailedToLoad: (ad, error) {
              print('Ad failed to load: $error');
              ad.dispose();
            },
          ),
        )..load();
      });
    } catch (e) {
      print('Error loading ad unit ID: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      final categoriesData = await WordPressService.getCategories();
      final postsData = await WordPressService.getPosts();
      setState(() {
        categories = categoriesData.where((cat) => cat.count > 0).toList();
        recentPosts = postsData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_stories, color: Colors.white),
            SizedBox(width: 8),
            Text('भक्ति संदेश'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PostSearchDelegate());
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Categories'),
            Tab(text: 'Recent Posts'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: Column(
        children: [
          if (_bannerAd != null)
            Container(
              alignment: Alignment.center,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          Expanded(
            child: isLoading
                ? const Center(child: AnimatedLoadingWidget())
                : TabBarView(
              controller: _tabController,
              children: [_buildCategoriesTab(), _buildRecentPostsTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange, Colors.white],
        ),
      ),
      child: categories.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.category, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No categories found'),
          ],
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPostsScreen(category: category),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      _getCategoryIcon(category.name),
                      size: 30,
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${category.count} posts',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentPostsTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange, Colors.white],
        ),
      ),
      child: recentPosts.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.article, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No posts found'),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recentPosts.length,
        itemBuilder: (context, index) {
          final post = recentPosts[index];
          return PostCard(post: post);
        },
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    final name = categoryName.toLowerCase();
    if (name.contains('mantra') || name.contains('मंत्र')) {
      return Icons.brightness_7;
    } else if (name.contains('chalisa') || name.contains('चालीसा')) {
      return Icons.auto_stories;
    } else if (name.contains('aarti') || name.contains('आरती')) {
      return Icons.local_fire_department;
    } else if (name.contains('bhajan') || name.contains('भजन')) {
      return Icons.music_note;
    } else if (name.contains('stotra') || name.contains('स्तोत्र')) {
      return Icons.menu_book;
    } else {
      return Icons.category;
    }
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnhancedPostDetailScreen(post: post),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.featuredImageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  post.featuredImageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.categories.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        post.categories.first,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF6B35),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (post.excerpt.isNotEmpty)
                    Text(
                      post.excerpt,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(post.date),
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Unknown date';
    }
  }
}

class CategoryPostsScreen extends StatefulWidget {
  final Category category;

  const CategoryPostsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryPostsScreenState createState() => _CategoryPostsScreenState();
}

class _CategoryPostsScreenState extends State<CategoryPostsScreen> {
  List<Post> posts = [];
  bool isLoading = true;
  bool hasMorePosts = true;
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (hasMorePosts && !isLoading) {
        _loadMorePosts();
      }
    }
  }

  Future<void> _loadPosts() async {
    try {
      final newPosts = await WordPressService.getPosts(
        page: 1,
        categoryId: widget.category.id,
      );
      setState(() {
        posts = newPosts;
        isLoading = false;
        currentPage = 1;
        hasMorePosts = newPosts.length == WordPressService.postsPerPage;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load posts: ${e.toString()}')),
      );
    }
  }

  Future<void> _loadMorePosts() async {
    try {
      setState(() {
        isLoading = true;
      });
      final newPosts = await WordPressService.getPosts(
        page: currentPage + 1,
        categoryId: widget.category.id,
      );
      setState(() {
        posts.addAll(newPosts);
        currentPage++;
        hasMorePosts = newPosts.length == WordPressService.postsPerPage;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name), elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange, Colors.white],
          ),
        ),
        child: posts.isEmpty && !isLoading
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.article, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No posts found in this category'),
            ],
          ),
        )
            : ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: posts.length + (hasMorePosts ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return PostCard(post: posts[index]);
            } else {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: AnimatedLoadingWidget(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class EnhancedPostDetailScreen extends StatefulWidget {
  final Post post;

  const EnhancedPostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EnhancedPostDetailScreenState createState() => _EnhancedPostDetailScreenState();
}

class _EnhancedPostDetailScreenState extends State<EnhancedPostDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isBookmarked = false;
  double _fontSize = 16.0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    _buildPostHeader(),
                    _buildControlPanel(),
                    _buildContentSection(),
                    _buildActionButtons(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: widget.post.featuredImageUrl != null ? 300.0 : 120.0,
      floating: false,
      pinned: true,
      backgroundColor: _isDarkMode ? Colors.grey[900] : const Color(0xFFFF6B35),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.post.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: widget.post.featuredImageUrl != null
            ? Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.post.featuredImageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                    ),
                  ),
                  child: const Icon(Icons.auto_stories, size: 80, color: Colors.white),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        )
            : Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
            ),
          ),
          child: const Icon(Icons.auto_stories, size: 80, color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
          onPressed: () {
            setState(() {
              _isBookmarked = !_isBookmarked;
            });
            _showSnackBar(_isBookmarked ? 'Bookmarked!' : 'Bookmark removed');
          },
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'share':
                _sharePost();
                break;
              case 'copy':
                _copyToClipboard();
                break;
              case 'dark_mode':
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 20),
                  SizedBox(width: 8),
                  Text('Share'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'copy',
              child: Row(
                children: [
                  Icon(Icons.copy, size: 20),
                  SizedBox(width: 8),
                  Text('Copy Text'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'dark_mode',
              child: Row(
                children: [
                  Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 20),
                  const SizedBox(width: 8),
                  Text(_isDarkMode ? 'Light Mode' : 'Dark Mode'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPostHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.post.categories.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.post.categories.map((category) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          Text(
            widget.post.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.grey[800],
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isDarkMode ? Colors.grey[800] : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isDarkMode ? Colors.grey[700]! : Colors.orange.shade100,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: _isDarkMode ? Colors.grey[400] : Colors.orange[600],
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(widget.post.date),
                  style: TextStyle(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.remove_red_eye,
                  size: 16,
                  color: _isDarkMode ? Colors.grey[400] : Colors.orange[600],
                ),
                const SizedBox(width: 4),
                Text(
                  'Reading time: ${_calculateReadingTime(widget.post.content)} min',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildControlButton(
            icon: Icons.text_decrease,
            label: 'A-',
            onPressed: () => setState(() {
              if (_fontSize > 12) _fontSize -= 2;
            }),
          ),
          _buildControlButton(
            icon: Icons.text_increase,
            label: 'A+',
            onPressed: () => setState(() {
              if (_fontSize < 24) _fontSize += 2;
            }),
          ),
          _buildControlButton(
            icon: _isDarkMode ? Icons.light_mode : Icons.dark_mode,
            label: _isDarkMode ? 'Light' : 'Dark',
            onPressed: () => setState(() {
              _isDarkMode = !_isDarkMode;
            }),
          ),
          _buildControlButton(
            icon: Icons.content_copy,
            label: 'Copy',
            onPressed: _copyToClipboard,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFFFF6B35),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Html(
          data: widget.post.content,
          style: {
            'body': Style(
              fontSize: FontSize(_fontSize),
              color: _isDarkMode ? Colors.grey[200] : Colors.grey[800],
              lineHeight: const LineHeight(1.8),
              textAlign: TextAlign.justify,
            ),
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _sharePost,
              icon: const Icon(Icons.share),
              label: const Text('Share'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _isBookmarked = !_isBookmarked;
                });
                _showSnackBar(_isBookmarked ? 'Bookmarked!' : 'Bookmark removed');
              },
              icon: Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: const Color(0xFFFF6B35),
              ),
              label: Text(
                _isBookmarked ? 'Bookmarked' : 'Bookmark',
                style: const TextStyle(color: Color(0xFFFF6B35)),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Color(0xFFFF6B35)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      const List<String> months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      return '${date.day} ${months[date.month - 1]}, ${date.year}';
    } catch (e) {
      return 'Unknown date';
    }
  }

  int _calculateReadingTime(String content) {
    final wordCount = content.split(' ').length;
    return (wordCount / 200).ceil();
  }

  void _sharePost() {
    _showSnackBar('Share functionality - Coming soon!');
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: '${widget.post.title}\n\n${widget.post.content}'));
    _showSnackBar('Content copied to clipboard!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF6B35),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class PostSearchDelegate extends SearchDelegate<String> {
  List<Post> searchResults = [];
  bool isSearching = false;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchResults.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Enter search terms to find posts'),
          ],
        ),
      );
    }

    return FutureBuilder<List<Post>>(
      future: WordPressService.searchPosts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: AnimatedLoadingWidget());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No posts found for "$query"'),
              ],
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return PostCard(post: snapshot.data![index]);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Search for mantras, chalisas, and more...',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Popular searches:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildSearchChip('Hanuman Chalisa', context),
                        _buildSearchChip('Gayatri Mantra', context),
                        _buildSearchChip('Vishnu Sahasranama', context),
                        _buildSearchChip('Durga Aarti', context),
                        _buildSearchChip('Shiva Mantra', context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange.shade50, Colors.white],
        ),
      ),
      child: FutureBuilder<List<Post>>(
        future: WordPressService.searchPosts(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6B35)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Searching...',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Search error occurred',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please try again',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No results found for "$query"',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try different keywords',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length > 10 ? 10 : snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF6B35),
                            Color(0xFFFF8C42),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.auto_stories,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey[800],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        if (post.excerpt.isNotEmpty)
                          Text(
                            post.excerpt,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        const SizedBox(height: 4),
                        if (post.categories.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              post.categories.first,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFFFF6B35),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    onTap: () {
                      close(context, post.title);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnhancedPostDetailScreen(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchChip(String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        query = text;
        showResults(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFF6B35).withOpacity(0.3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFF6B35),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class AnimatedLoadingWidget extends StatefulWidget {
  const AnimatedLoadingWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedLoadingWidget> createState() => _AnimatedLoadingWidgetState();
}

class _AnimatedLoadingWidgetState extends State<AnimatedLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_stories,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}