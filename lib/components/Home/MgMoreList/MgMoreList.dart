import 'package:flutter/material.dart';
import 'package:mango_shop/utils/colors.dart';
import 'package:mango_shop/utils/text_styles.dart';

class MgmoreList extends StatefulWidget {
  MgmoreList({Key? key}) : super(key: key);

  @override
  _MgmoreListState createState() => _MgmoreListState();
}

class _MgmoreListState extends State<MgmoreList> {
  final List<Map<String, dynamic>> _moreProducts = [
    {
      'name': '白菜',
      'price': 2.9,
      'originalPrice': 4.9,
      'image': 'lib/assets/白菜.png',
      'sales': 3456,
      'rating': 4.7,
      'tags': ['蔬菜', '新鲜']
    },
    {
      'name': '萝卜',
      'price': 3.9,
      'originalPrice': 5.9,
      'image': 'lib/assets/胡萝卜.png',
      'sales': 2109,
      'rating': 4.8,
      'tags': ['蔬菜', '新鲜']
    },
    {
      'name': '西红柿',
      'price': 4.9,
      'originalPrice': 6.9,
      'image': 'lib/assets/西红柿.png',
      'sales': 892,
      'rating': 4.9,
      'tags': ['蔬菜', '新鲜']
    },
    {
      'name': '黄瓜',
      'price': 3.9,
      'originalPrice': 5.9,
      'image': 'lib/assets/黄瓜.png',
      'sales': 5678,
      'rating': 4.6,
      'tags': ['蔬菜', '新鲜']
    },
    {
      'name': '薯片',
      'price': 6.9,
      'originalPrice': 9.9,
      'image': 'lib/assets/薯片.png',
      'sales': 4321,
      'rating': 4.5,
      'tags': ['零食', '热销']
    },
    {
      'name': '饼干',
      'price': 8.9,
      'originalPrice': 12.9,
      'image': 'lib/assets/饼干.png',
      'sales': 1234,
      'rating': 4.4,
      'tags': ['零食', '热销']
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('更多商品', style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('查看全部商品');
                  // 显示查看全部提示
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('正在加载全部商品...')),
                  );
                  // 模拟加载全部商品
                  Future.delayed(Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('已加载全部商品')),
                    );
                  });
                },
                child: Row(
                  children: [
                    Text('查看全部', style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    )),
                    Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: _moreProducts.length,
            itemBuilder: (context, index) {
              final product = _moreProducts[index];
              return GestureDetector(
                onTap: () {
                  // 商品点击事件
                  print('更多商品 ${product['name']} 被点击');
                  // 显示商品详情页跳转提示
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('查看商品详情：${product['name']}')),
                  );
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 200),
                    scale: 1.0,
                    child: Container(
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
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              image: DecorationImage(
                                image: AssetImage(product['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // 标签
                                if (product['tags'] != null && (product['tags'] as List).isNotEmpty)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        (product['tags'] as List)[0],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                // 评分
                                if (product['rating'] != null)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 9,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            '${product['rating']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '¥${product['price']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '¥${product['originalPrice']}',
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
                                    '已售${product['sales']}件',
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
        ],
      ),
    );
  }
}