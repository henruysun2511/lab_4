import 'package:flutter/material.dart';

/// Entry point cho phép chạy riêng file debug_fixes_demo.dart độc lập
void main() {
  runApp(const DebugFixesApp());
}

/// Ứng dụng bọc cho màn hình Exercise 5
class DebugFixesApp extends StatelessWidget {
  const DebugFixesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Exercise 5: Debug & Fix UI Errors',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
      ),
      home: const DebugFixesDemoScreen(),
    );
  }
}

/// Màn hình chính Exercise 5 – Tìm hiểu nguyên nhân và cách khắc phục 4 lỗi UI kinh điển:
/// Task 1: Fix ListView inside Column using Expanded
/// Task 2: Fix overflow in small screens using SingleChildScrollView
/// Task 3: Fix state update issue by adding setState()
/// Task 4: Fix DatePicker build context errors by calling from valid widget tree
class DebugFixesDemoScreen extends StatefulWidget {
  const DebugFixesDemoScreen({super.key});

  @override
  State<DebugFixesDemoScreen> createState() => _DebugFixesDemoScreenState();
}

class _DebugFixesDemoScreenState extends State<DebugFixesDemoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State cho Task 3 (setState Demo)
  int _counterWithoutSetState = 0;
  int _counterWithSetState = 0;

  // State cho Task 4 (DatePicker Demo)
  DateTime? _task4Date;

  // State cho Task 1 (Toggle giữa Expanded và ShrinkWrap)
  bool _useExpandedForListView = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: Debug & Fix UI Errors'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.view_agenda), text: 'Task 1: ListView in Column'),
            Tab(icon: Icon(Icons.screen_rotation_alt), text: 'Task 2: Screen Overflow'),
            Tab(icon: Icon(Icons.sync), text: 'Task 3: setState() Bug'),
            Tab(icon: Icon(Icons.account_tree), text: 'Task 4: DatePicker Context'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTask1View(theme),
          _buildTask2View(theme),
          _buildTask3View(theme),
          _buildTask4View(theme),
        ],
      ),
    );
  }

  // ==========================================================================
  // TASK 1: FIX LISTVIEW INSIDE COLUMN USING EXPANDED
  // ==========================================================================
  Widget _buildTask1View(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Giải thích lỗi
          Card(
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.4),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❌ Lỗi thường gặp: "Vertical viewport was given unbounded height"',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nguyên nhân: Column cung cấp chiều cao vô hạn (unbounded) cho con. ListView lại muốn nở ra hết cỡ theo nội dung, dẫn tới xung đột kích thước không xác định.',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '✅ Khắc phục: Bọc ListView bằng Expanded (để chiếm phần chiều cao còn lại của Column) HOẶC đặt shrinkWrap: true.',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Nút chuyển đổi phương pháp fix
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phương pháp áp dụng: ${_useExpandedForListView ? "Expanded (Khuyên Dùng)" : "shrinkWrap: true"}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Switch(
                value: _useExpandedForListView,
                onChanged: (val) {
                  setState(() {
                    _useExpandedForListView = val;
                  });
                },
              ),
            ],
          ),
          const Divider(),

          const Text(
            'Minh họa danh sách nằm trong Column sau khi đã FIX thành công:',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Đây là code đã được FIX:
          // Nếu dùng Expanded:
          if (_useExpandedForListView)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text('${index + 1}'),
                      ),
                      title: Text('Phần tử danh sách $index (Đã bọc trong Expanded)'),
                      subtitle: const Text('Cuộn mượt mà không bao giờ bị lỗi unbounded height'),
                    );
                  },
                ),
              ),
            )
          else
            // Phương pháp 2: shrinkWrap
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.teal),
                    title: Text('Phần tử $index (Dùng shrinkWrap: true)'),
                    subtitle: const Text('Thu gọn theo đúng chiều cao nội dung'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================================
  // TASK 2: FIX OVERFLOW IN SMALL SCREENS USING SINGLECHILDSCROLLVIEW
  // ==========================================================================
  Widget _buildTask2View(ThemeData theme) {
    return SingleChildScrollView(
      // ✅ ĐÂY CHÍNH LÀ FIX: Bọc SingleChildScrollView để tránh lỗi tràn màn hình
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.amber.shade100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❌ Lỗi: "A RenderFlex overflowed by ... pixels" (Sọc vàng đen)',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown.shade900),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Nguyên nhân: Màn hình điện thoại nhỏ hoặc người dùng mở bàn phím ảo làm diện tích hiển thị bị thu hẹp, khiến các widget trong Column vượt quá chiều cao màn hình.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '✅ Khắc phục: Bọc Column bằng SingleChildScrollView để cho phép toàn bộ trang cuộn được khi nội dung dài.',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nội dung dài mô phỏng màn hình nhỏ (Hãy thử cuộn dọc màn hình):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Tạo chuỗi nhiều thẻ để chứng minh không còn lỗi overflow
          for (int i = 1; i <= 6; i++)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      child: Text('$i'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Khối nội dung thử nghiệm #$i',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Nhờ có SingleChildScrollView, màn hình này cuộn thoải mái trên mọi kích thước thiết bị mà không bao giờ bị lỗi tràn pixel.',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================================
  // TASK 3: FIX STATE UPDATE ISSUE BY ADDING SETSTATE()
  // ==========================================================================
  Widget _buildTask3View(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.4),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❌ Lỗi: Biến thay đổi nhưng giao diện (UI) không cập nhật',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nguyên nhân: Khi gán _counter++ trực tiếp trong hàm mà không gọi setState(), Flutter không biết state đã đổi nên không kích hoạt hàm build() để vẽ lại UI.',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '✅ Khắc phục: Bao bọc câu lệnh thay đổi dữ liệu bên trong setState(() { _counter++; });',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // So sánh trực quan 2 trường hợp
          Row(
            children: [
              // Case 1: Lỗi không dùng setState
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          '❌ Không setState',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$_counterWithoutSetState',
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '(UI không đổi khi bấm)',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                          onPressed: () {
                            // ❌ BUG: Tăng biến nhưng không gọi setState
                            _counterWithoutSetState++;
                            // ignore: avoid_print
                            print('Giá trị trong RAM: $_counterWithoutSetState nhưng UI chưa render lại!');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Biến đã tăng lên $_counterWithoutSetState trong RAM nhưng UI KHÔNG đổi vì thiếu setState()!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text('Bấm thử (Bug)'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Case 2: Đã fix với setState
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          '✅ Có setState',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$_counterWithSetState',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '(UI cập nhật tức thì)',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            // ✅ FIX: Bọc thay đổi biến trong setState
                            setState(() {
                              _counterWithSetState++;
                            });
                          },
                          child: const Text('Bấm thử (Fixed)'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // TASK 4: FIX DATEPICKER BUILDCONTEXT ERRORS
  // ==========================================================================
  Widget _buildTask4View(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.4),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❌ Lỗi: "No Navigator / Overlay widget found with the given context"',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nguyên nhân: Gọi showDatePicker() truyền vào context nằm ngoài hoặc ngang cấp với MaterialApp / Navigator (ví dụ context lấy trực tiếp từ MyApp build() trước khi có Navigator).',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '✅ Khắc phục: Đảm bảo gọi showDatePicker với BuildContext của widget con nằm bên trong MaterialApp/Navigator, hoặc sử dụng widget Builder((context) => ...) để lấy context hợp lệ.',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thử nghiệm gọi DatePicker với Context hợp lệ:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ngày đã chọn: ${_task4Date == null ? "Chưa chọn ngày nào" : "${_task4Date!.day}/${_task4Date!.month}/${_task4Date!.year}"}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sử dụng Builder để chứng minh việc tạo một context con hoàn toàn hợp lệ
                  Builder(
                    builder: (BuildContext validContext) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('Mở DatePicker bằng Valid Context (Builder)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        onPressed: () async {
                          // Sử dụng validContext được cung cấp bởi Builder widget
                          final picked = await showDatePicker(
                            context: validContext,
                            initialDate: _task4Date ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            setState(() {
                              _task4Date = picked;
                            });
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
