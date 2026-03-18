import 'package:flutter/material.dart';
import 'package:mango_shop/utils/colors.dart';
import 'package:mango_shop/utils/text_styles.dart';

class Mghot extends StatefulWidget {
  Mghot({Key? key}) : super(key: key);

  @override
  _MghotState createState() => _MghotState();
}

class _MghotState extends State<Mghot> {
  final List<Map<String, dynamic>> _hotProducts = [
    {
      'name': '海南芒果',
      'price': 19.9,
      'originalPrice': 29.9,
      'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
      'sales': 1234,
      'tags': ['热销', '新鲜']
    },
    {
      'name': '泰国芒果',
      'price': 29.9,
      'originalPrice': 39.9,
      'image': 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
      'sales': 892,
      'tags': ['进口', '精选']
    },
    {
      'name': '广西芒果',
      'price': 15.9,
      'originalPrice': 25.9,
      'image': 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
      'sales': 2103,
      'tags': ['国产', '实惠']
    },
    {
      'name': '云南芒果',
      'price': 17.9,
      'originalPrice': 27.9,
      'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
      'sales': 987,
      'tags': ['国产', '优质']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('热门商品', style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('查看更多热门商品');
                  // 显示查看更多提示
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('正在加载更多热门商品...')),
                  );
                  // 模拟加载更多商品
                  Future.delayed(Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('已加载全部热门商品')),
                    );
                  });
                },
                child: Row(
                  children: [
                    Text('查看更多', style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    )),
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _hotProducts.length,
              padding: EdgeInsets.only(right: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // 商品点击事件
                    print('热门商品 ${_hotProducts[index]['name']} 被点击');
                    // 显示商品详情页跳转提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('查看商品详情：${_hotProducts[index]['name']}')),
                    );
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 200),
                      scale: 1.0,
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.gray300.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                image: DecorationImage(
                                  image: AssetImage(_hotProducts[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // 标签
                                  if (_hotProducts[index]['tags'] != null && (_hotProducts[index]['tags'] as List).isNotEmpty)
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          (_hotProducts[index]['tags'] as List)[0],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _hotProducts[index]['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '¥${_hotProducts[index]['price']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '¥${_hotProducts[index]['originalPrice']}',
                                        style: TextStyle(
                                          color: AppColors.textHint,
                                          fontSize: 10,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '已售${_hotProducts[index]['sales']}件',
                                    style: TextStyle(
                                      color: AppColors.textHint,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
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