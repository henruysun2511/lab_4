import 'package:flutter/material.dart';

/// Entry point cho phép chạy riêng file scaffold_theme_demo.dart độc lập
void main() {
  runApp(const ScaffoldThemeApp());
}

/// Ứng dụng Exercise 4 quản lý ThemeMode (Light / Dark)
class ScaffoldThemeApp extends StatefulWidget {
  const ScaffoldThemeApp({super.key});

  @override
  State<ScaffoldThemeApp> createState() => _ScaffoldThemeAppState();
}

class _ScaffoldThemeAppState extends State<ScaffoldThemeApp> {
  // Biến quản lý trạng thái giao diện: Sáng (Light) hoặc Tối (Dark)
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Định nghĩa ThemeData riêng cho Light Mode
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
      ),
    );

    // Định nghĩa ThemeData riêng cho Dark Mode
    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
      ),
    );

    return MaterialApp(
      title: 'Lab 4 - Exercise 4: Scaffold & Theme',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode, // Áp dụng themeMode động
      home: ScaffoldThemeDemoScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

/// Màn hình chính Exercise 4 – Xây dựng khung ứng dụng hoàn chỉnh với:
/// 1. Scaffold (khung layout chuẩn Material Design)
/// 2. AppBar với tiêu đề và action toggle Dark Mode
/// 3. Body hiển thị nội dung, thẻ thống kê, switch theme
/// 4. FloatingActionButton (FAB) tăng biến đếm tương tác
/// 5. Drawer và BottomNavigationBar để tạo ứng dụng thực tế
class ScaffoldThemeDemoScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const ScaffoldThemeDemoScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<ScaffoldThemeDemoScreen> createState() => _ScaffoldThemeDemoScreenState();
}

class _ScaffoldThemeDemoScreenState extends State<ScaffoldThemeDemoScreen> {
  int _counter = 0;
  int _currentNavIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('FloatingActionButton clicked! Counter: $_counter'),
        duration: const Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    return Scaffold(
      // ================================================================
      // 1. APPBAR
      // ================================================================
      appBar: AppBar(
        title: const Text('Exercise 4: Scaffold & Theme'),
        backgroundColor: theme.colorScheme.inversePrimary,
        actions: [
          // Nút chuyển đổi Dark Mode trên thanh AppBar
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.amber : theme.colorScheme.onSurface,
            ),
            tooltip: isDark ? 'Chuyển sang Giao diện Sáng' : 'Chuyển sang Giao diện Tối',
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Lab 4 - Exercise 4',
                applicationVersion: '1.0.0',
                children: const [
                  Text('Minh họa cấu trúc Scaffold, AppBar, FAB, ThemeData & Dark Mode.'),
                ],
              );
            },
          ),
        ],
      ),

      // ================================================================
      // DRAWER (Ngăn kéo menu trượt)
      // ================================================================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Học viên Flutter'),
              accountEmail: const Text('student@flutter.edu.vn'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.onPrimary,
                child: Icon(Icons.person, size: 40, color: theme.colorScheme.primary),
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(isDark ? 'Chế độ: Đang Tối' : 'Chế độ: Đang Sáng'),
              trailing: Switch(
                value: isDark,
                onChanged: (val) {
                  widget.onToggleTheme();
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // ================================================================
      // 2. BODY
      // ================================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner thông báo trạng thái Theme
            Card(
              color: isDark
                  ? theme.colorScheme.surfaceContainerHigh
                  : theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                      size: 40,
                      color: isDark ? Colors.amber : theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isDark ? 'Chế Độ Tối (Dark Mode)' : 'Chế Độ Sáng (Light Mode)',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isDark
                                ? 'Đang áp dụng Dark ThemeData với bảng màu dịu mắt ban đêm.'
                                : 'Đang áp dụng Light ThemeData với độ sáng rõ nét ban ngày.',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? theme.colorScheme.onSurfaceVariant
                                  : theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Nút Toggle trực tiếp
            ElevatedButton.icon(
              onPressed: widget.onToggleTheme,
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              label: Text(
                isDark ? 'Chuyển sang Chế Độ Sáng' : 'Chuyển sang Chế Độ Tối',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Thẻ thống kê tương tác với FAB
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Tương tác FloatingActionButton',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_counter',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Bấm nút FAB tròn có biểu tượng (+) ở góc dưới để tăng số lần tương tác.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Thông tin chi tiết về các thành phần Scaffold
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.architecture, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Cấu Trúc Màn Hình Scaffold',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    _buildFeatureItem('AppBar:', 'Thanh tiêu đề chứa tiêu đề, Drawer icon và Theme action.'),
                    _buildFeatureItem('Body:', 'Vùng hiển thị nội dung chính cuộn được bằng SingleChildScrollView.'),
                    _buildFeatureItem('FloatingActionButton:', 'Nút nổi cố định góc dưới bên phải kích hoạt hành động chính.'),
                    _buildFeatureItem('ThemeData:', 'Hệ thống màu sắc, kiểu chữ thống nhất cho toàn bộ màn hình.'),
                    _buildFeatureItem('BottomNavigationBar:', 'Thanh điều hướng chuyển đổi tab ở chân màn hình.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ================================================================
      // 3. FLOATING ACTION BUTTON (FAB)
      // ================================================================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        icon: const Icon(Icons.add),
        label: const Text('Thêm lượt'),
        tooltip: 'Tăng biến đếm',
      ),

      // ================================================================
      // 4. BOTTOM NAVIGATION BAR
      // ================================================================
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentNavIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: '$title ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: desc),
          ],
        ),
      ),
    );
  }
}
