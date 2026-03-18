import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mango_shop/utils/colors.dart';

class Mgslider extends StatefulWidget {
  Mgslider({Key? key}) : super(key: key);

  @override
  _MgsliderState createState() => _MgsliderState();
}

class _MgsliderState extends State<Mgslider> {
  int _currentIndex = 0;
  late Timer _timer;
  late PageController _pageController;
  final List<String> _images = [
    'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
    'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
    'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
  ];

  @override
  void initState() {
    super.initState();
    // 初始化PageController
    _pageController = PageController(initialPage: 0);
    // 初始化定时器，每3秒切换一次图片
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
        // 控制PageView滚动到对应的页面
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    // 清理定时器和PageController
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    
    return Container(
      height: isLargeScreen ? 280 : 220,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // 轮播图点击事件
                  print('轮播图第${index + 1}张被点击');
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _currentIndex == entry.key ? 24 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentIndex == entry.key ? AppColors.primary : AppColors.white.withOpacity(0.8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}