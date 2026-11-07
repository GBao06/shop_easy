import 'dart:async';
import 'package:flutter/material.dart';

class _Slide {
  final String title;
  final String subtitle;
  final List<Color> colors;
  const _Slide(this.title, this.subtitle, this.colors);
}

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});
  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final _controller = PageController();
  Timer? _timer;
  int _page = 0;

  static const _slides = [
    _Slide('Flash Sale Hàng Ngày', 'Giảm giá đến 50%',
        [Color(0xFF203D67), Color(0xFF3A7CA5)]),
    _Slide('Giày chính hãng', 'Ưu đãi đến 30%',
        [Color(0xFFE65100), Color(0xFFFFA726)]),
    _Slide('Miễn phí vận chuyển', 'Cho đơn từ 500.000 đ',
        [Color(0xFF2E7D32), Color(0xFF66BB6A)]),
  ];

  @override
  void initState() {
    super.initState();
    // Tạo timer để tự động chuyển slide mỗi 4 giây
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      // Nếu PageView chưa được tạo, không làm gì
      if (!_controller.hasClients) return;
      // Chuyển sang slide tiếp theo, nếu là slide cuối thì quay lại slide đầu
      _controller.animateToPage(
        (_page + 1) % _slides.length,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }
  // Hủy timer và controller khi widget bị hủy
  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          // PageView: hiển thị các slide quảng cáo
          child: PageView.builder(
            controller: _controller,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, i) {
              final s = _slides[i];
              // Hiển thị từng slide với tiêu đề, phụ đề và màu nền gradient
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                //
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: s.colors),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(s.subtitle,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 15)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Dấu chấm chỉ thị slide hiện tại
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _page == i ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _page == i
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}