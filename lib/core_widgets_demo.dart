import 'package:flutter/material.dart';

/// Entry point cho phép chạy riêng file core_widgets_demo.dart độc lập
/// (Thích hợp chạy thử trong VS Code, Android Studio hoặc DartPad)
void main() {
  runApp(const CoreWidgetsApp());
}

/// Ứng dụng bọc cho màn hình Exercise 1
class CoreWidgetsApp extends StatelessWidget {
  const CoreWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Exercise 1: Core Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: const CoreWidgetsDemoScreen(),
    );
  }
}

/// Màn hình chính Exercise 1 – Trình diễn các Core Widgets cơ bản:
/// 1. Headline Text
/// 2. Material Icon
/// 3. Image.network()
/// 4. Card chứa ListTile
class CoreWidgetsDemoScreen extends StatelessWidget {
  const CoreWidgetsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Core Widgets'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ================================================================
            // 1. HEADLINE TEXT
            // Sử dụng Text widget kết hợp TextStyle và Theme TextTheme
            // ================================================================
            Text(
              'Flutter UI Fundamentals',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Trình diễn các widget hiển thị cơ bản nhất trong Flutter SDK.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24.0),

            // ================================================================
            // 2. ICON DÙNG MATERIAL ICONS
            // Sử dụng Icon widget với kích thước, màu sắc và bọc trong container tròn
            // ================================================================
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.flutter_dash,
                  size: 64.0,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: Text(
                'Material Icon: Icons.flutter_dash',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // ================================================================
            // 3. IMAGE.NETWORK()
            // Tải ảnh từ Internet kèm loadingBuilder và errorBuilder xử lý lỗi mạng
            // ================================================================
            Text(
              'Network Image Widget:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                'https://picsum.photos/seed/flutterlab/800/400',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                // Hiển thị vòng xoay tiến trình khi đang nạp ảnh
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  final totalBytes = loadingProgress.expectedTotalBytes;
                  final loadedBytes = loadingProgress.cumulativeBytesLoaded;
                  return Container(
                    height: 200,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: totalBytes != null ? loadedBytes / totalBytes : null,
                      ),
                    ),
                  );
                },
                // Dự phòng trường hợp mất mạng hoặc URL không tồn tại
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image_rounded,
                            size: 48,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Không tải được hình ảnh qua mạng',
                            style: TextStyle(
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24.0),

            // ================================================================
            // 4. CARD CHỨA LISTTILE
            // Kết hợp Card Material 3 với ListTile tiêu chuẩn
            // ================================================================
            Text(
              'Card & ListTile Widget:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  child: const Icon(Icons.person),
                ),
                title: const Text(
                  'Nguyễn Văn A',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Sinh viên Khoa CNTT - Lớp Flutter K24'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã nhấn nút chi tiết trên ListTile!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã chạm vào ListTile trong Card!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16.0),

            // Card thứ 2 để làm nổi bật tính ứng dụng thực tế
            Card(
              elevation: 2.0,
              color: theme.colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.verified,
                  color: theme.colorScheme.onSecondaryContainer,
                  size: 32,
                ),
                title: Text(
                  'Hoàn thành Exercise 1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
                subtitle: Text(
                  'Text, Icon, Image.network, Card & ListTile đều đã hiển thị đầy đủ.',
                  style: TextStyle(
                    color: theme.colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
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
