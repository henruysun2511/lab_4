import 'package:flutter/material.dart';

import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_basics_demo.dart';
import 'scaffold_theme_demo.dart';
import 'debug_fixes_demo.dart';

void main() {
  runApp(const Lab4MainApp());
}

/// Ứng dụng trung tâm Lab 4 – Flutter UI Fundamentals
/// Cung cấp Hub điều hướng tới toàn bộ 5 bài tập trong bài thực hành
class Lab4MainApp extends StatefulWidget {
  const Lab4MainApp({super.key});

  @override
  State<Lab4MainApp> createState() => _Lab4MainAppState();
}

class _Lab4MainAppState extends State<Lab4MainApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: Lab4HomeScreen(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

/// Màn hình điều khiển trung tâm (Dashboard Hub)
class Lab4HomeScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const Lab4HomeScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final exercises = [
      _ExerciseInfo(
        number: '1',
        title: 'Core Widgets',
        subtitle: 'Text, Image, Icon, Card, ListTile',
        icon: Icons.widgets_outlined,
        color: Colors.deepPurple,
        routeBuilder: (ctx) => const CoreWidgetsDemoScreen(),
      ),
      _ExerciseInfo(
        number: '2',
        title: 'Input Widgets',
        subtitle: 'Slider, Switch, RadioListTile, DatePicker',
        icon: Icons.toggle_on_outlined,
        color: Colors.teal,
        routeBuilder: (ctx) => const InputControlsDemo(),
      ),
      _ExerciseInfo(
        number: '3',
        title: 'Layout Composition',
        subtitle: 'Column, Row, Padding, ListView.builder',
        icon: Icons.dashboard_outlined,
        color: Colors.indigo,
        routeBuilder: (ctx) => const LayoutBasicsDemo(),
      ),
      _ExerciseInfo(
        number: '4',
        title: 'Scaffold & Theme',
        subtitle: 'Scaffold, AppBar, FAB, ThemeData, Dark Mode',
        icon: Icons.palette_outlined,
        color: Colors.blueAccent,
        routeBuilder: (ctx) => ScaffoldThemeDemoScreen(
          isDarkMode: isDark,
          onToggleTheme: onToggleTheme,
        ),
      ),
      _ExerciseInfo(
        number: '5',
        title: 'Debug & Fix UI Errors',
        subtitle: 'Expanded, SingleChildScrollView, setState, Context',
        icon: Icons.bug_report_outlined,
        color: Colors.deepOrange,
        routeBuilder: (ctx) => const DebugFixesDemoScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab 4: Flutter UI Fundamentals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: theme.colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            tooltip: isDark ? 'Chuyển sang Chế Độ Sáng' : 'Chuyển sang Chế Độ Tối',
            onPressed: onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Thông tin Lab',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Row(
                    children: [
                      Icon(Icons.school, color: Colors.deepPurple),
                      SizedBox(width: 8),
                      Text('Lab 4 - UI Fundamentals'),
                    ],
                  ),
                  content: const Text(
                    'Bài thực hành tổng hợp kiến thức về:\n\n'
                    '• Exercise 1: Các Core Widget hiển thị\n'
                    '• Exercise 2: Các Widget nhập liệu và tương tác\n'
                    '• Exercise 3: Bố cục giao diện Column, Row, ListView\n'
                    '• Exercise 4: Cấu trúc Scaffold và Theming (Dark Mode)\n'
                    '• Exercise 5: Chẩn đoán và sửa 4 lỗi UI kinh điển',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Đóng'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Header Card
            Card(
              elevation: 4,
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.flutter_dash,
                          size: 36,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Module 4 – Flutter UI Fundamentals',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                                ),
                              ),
                              Text(
                                'Báo Cáo Thực Hành 5 Bài Tập',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Chào mừng bạn đến với bài thực hành Lab 4. Hãy chọn từng bài tập bên dưới để trải nghiệm UI sống động và xem code giải thích chi tiết.',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Danh Sách 5 Bài Tập Thực Hành:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Danh sách các bài tập
            for (final ex in exercises)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Card(
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: ex.routeBuilder),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: ex.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                ex.icon,
                                color: ex.color,
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: ex.color,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Bài ${ex.number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      ex.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  ex.subtitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: theme.colorScheme.outline,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseInfo {
  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final WidgetBuilder routeBuilder;

  const _ExerciseInfo({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.routeBuilder,
  });
}
