import 'package:flutter/material.dart';

/// Entry point cho phép chạy riêng file layout_basics_demo.dart độc lập
void main() {
  runApp(const LayoutBasicsApp());
}

/// Ứng dụng bọc cho màn hình Exercise 3
class LayoutBasicsApp extends StatelessWidget {
  const LayoutBasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Exercise 3: Layout Basics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      home: const LayoutBasicsDemo(),
    );
  }
}

/// Dữ liệu mẫu cho Movie Item
class MovieItem {
  final String title;
  final String genre;
  final double rating;
  final String duration;
  final String year;
  final IconData posterIcon;
  final Color badgeColor;

  const MovieItem({
    required this.title,
    required this.genre,
    required this.rating,
    required this.duration,
    required this.year,
    required this.posterIcon,
    required this.badgeColor,
  });
}

/// Danh sách phim mẫu phục vụ cho ListView.builder
const List<MovieItem> sampleMovies = [
  MovieItem(
    title: 'Interstellar',
    genre: 'Khoa học viễn tưởng • Phiêu lưu',
    rating: 8.7,
    duration: '2h 49m',
    year: '2014',
    posterIcon: Icons.rocket_launch_rounded,
    badgeColor: Colors.deepPurple,
  ),
  MovieItem(
    title: 'Inception',
    genre: 'Hành động • Viễn tưởng • Giật gân',
    rating: 8.8,
    duration: '2h 28m',
    year: '2010',
    posterIcon: Icons.psychology_rounded,
    badgeColor: Colors.blueGrey,
  ),
  MovieItem(
    title: 'The Dark Knight',
    genre: 'Hành động • Tội phạm • Kịch tính',
    rating: 9.0,
    duration: '2h 32m',
    year: '2008',
    posterIcon: Icons.shield_rounded,
    badgeColor: Colors.amber,
  ),
  MovieItem(
    title: 'Spider-Man: Across the Spider-Verse',
    genre: 'Hoạt hình • Hành động • Phiêu lưu',
    rating: 8.6,
    duration: '2h 20m',
    year: '2023',
    posterIcon: Icons.animation_rounded,
    badgeColor: Colors.redAccent,
  ),
  MovieItem(
    title: 'Oppenheimer',
    genre: 'Tiểu sử • Lịch sử • Kịch tính',
    rating: 8.9,
    duration: '3h 00m',
    year: '2023',
    posterIcon: Icons.local_fire_department_rounded,
    badgeColor: Colors.orange,
  ),
  MovieItem(
    title: 'Avatar: The Way of Water',
    genre: 'Khoa học viễn tưởng • Kỳ ảo',
    rating: 7.6,
    duration: '3h 12m',
    year: '2022',
    posterIcon: Icons.water_drop_rounded,
    badgeColor: Colors.cyan,
  ),
];

/// Màn hình chính Exercise 3 – Layout Composition
/// Yêu cầu:
/// 1. Dùng Column tạo các phân vùng dọc (Vertical sections)
/// 2. Áp dụng khoảng cách chuẩn (8, 12, 16, 24 px) bằng Padding và SizedBox
/// 3. Dùng Row cho bố cục hàng ngang (Thanh tìm kiếm, danh mục phân loại)
/// 4. Dùng ListView.builder hiển thị danh sách phim mượt mà và tối ưu bộ nhớ
class LayoutBasicsDemo extends StatefulWidget {
  const LayoutBasicsDemo({super.key});

  @override
  State<LayoutBasicsDemo> createState() => _LayoutBasicsDemoState();
}

class _LayoutBasicsDemoState extends State<LayoutBasicsDemo> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'Tất cả',
    'Hành động',
    'Khoa học viễn tưởng',
    'Hoạt hình',
    'Kịch tính',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3: Layout Composition'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
            tooltip: 'Thông báo',
          ),
        ],
      ),
      // Bố cục chính sử dụng Column để chia các phân vùng theo chiều dọc
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ================================================================
          // SECTION 1: SEARCH & GREETING (ROW + PADDING)
          // Spacing: 16px padding
          // ================================================================
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 8.0), // 8px spacing
                        Text(
                          'Tìm kiếm tên phim, đạo diễn...',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12.0), // 12px spacing
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.tune,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    onPressed: () {},
                    tooltip: 'Bộ lọc nâng cao',
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // SECTION 2: FEATURED BANNER CARD (CONTAINER + GRADIENT + ROW)
          // Spacing: 16px padding, 12px internal spacing
          // ================================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.tertiary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            '🔥 PHIM HOT TUẦN NÀY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Interstellar: Hố Đen Vũ Trụ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Khám phá không gian liên sao và thuyết tương đối.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================================================================
          // SECTION 3: CATEGORIES CHIPS (HORIZONTAL SCROLL / ROW)
          // Spacing: 8px and 12px
          // ================================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thể loại phim',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return ChoiceChip(
                  label: Text(_categories[index]),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  selectedColor: theme.colorScheme.primaryContainer,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12.0), // 12px spacing

          // ================================================================
          // SECTION 4: LISTVIEW.BUILDER (MOVIE ITEMS)
          // Sử dụng Expanded để ListView chiếm toàn bộ không gian còn lại
          // ================================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'Danh sách phim tuyển chọn (${sampleMovies.length})',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: sampleMovies.length,
              itemBuilder: (context, index) {
                final movie = sampleMovies[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0), // 12px consistent spacing
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.0),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Bạn đã chọn xem chi tiết phim: ${movie.title}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0), // 12px inner padding
                        child: Row(
                          children: [
                            // Poster icon avatar
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: movie.badgeColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Icon(
                                movie.posterIcon,
                                color: movie.badgeColor,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 12.0), // 12px spacing

                            // Thông tin phim
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    movie.genre,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        movie.rating.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        '•  ${movie.year}  •  ${movie.duration}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: theme.colorScheme.outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8.0),
                            IconButton(
                              icon: const Icon(Icons.bookmark_border_rounded),
                              color: theme.colorScheme.primary,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Đã lưu ${movie.title} vào danh sách xem sau!'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              tooltip: 'Lưu phim',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
