import 'package:flutter/material.dart';
import 'package:mango_shop/utils/colors.dart';
import 'package:mango_shop/utils/text_styles.dart';

class Mgsuggestion extends StatefulWidget {
  Mgsuggestion({Key? key}) : super(key: key);

  @override
  _MgsuggestionState createState() => _MgsuggestionState();
}

class _MgsuggestionState extends State<Mgsuggestion> {
  // 所有可选的推荐商品
  final List<Map<String, dynamic>> _allSuggestedProducts = [
    {
      'name': '苹果',
      'price': 8.9,
      'originalPrice': 12.9,
      'image': 'lib/assets/苹果.png',
      'sales': 3456,
      'rating': 4.8,
      'tags': ['水果', '热销']
    },
    {
      'name': '香蕉',
      'price': 5.9,
      'originalPrice': 8.9,
      'image': 'lib/assets/香蕉.png',
      'sales': 2109,
      'rating': 4.6,
      'tags': ['水果', '新鲜']
    },
    {
      'name': '橙子',
      'price': 9.9,
      'originalPrice': 15.9,
      'image': 'lib/assets/橙子.png',
      'sales': 892,
      'rating': 4.9,
      'tags': ['水果', '精选']
    },
    {
      'name': '草莓',
      'price': 12.9,
      'originalPrice': 18.9,
      'image': 'lib/assets/草莓.png',
      'sales': 5678,
      'rating': 4.7,
      'tags': ['水果', '新鲜']
    },
    {
      'name': '海南芒果',
      'price': 19.9,
      'originalPrice': 29.9,
      'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
      'sales': 4321,
      'rating': 4.5,
      'tags': ['水果', '国产']
    },
    {
      'name': '广西芒果',
      'price': 15.9,
      'originalPrice': 25.9,
      'image': 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
      'sales': 789,
      'rating': 4.4,
      'tags': ['水果', '国产']
    },
  ];
  
  // 当前显示的推荐商品
  late List<Map<String, dynamic>> _suggestedProducts;

  @override
  void initState() {
    super.initState();
    // 初始化时随机选择4个商品
    _refreshSuggestions();
  }
  
  // 刷新推荐商品
  void _refreshSuggestions() {
    setState(() {
      // 随机打乱商品列表
      final shuffled = [..._allSuggestedProducts]..shuffle();
      // 取前4个商品
      _suggestedProducts = shuffled.take(4).toList();
    });
  }

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
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('为你推荐', style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('换一批推荐商品');
                  // 显示换一批提示
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('正在为你推荐新商品...')),
                  );
                  // 刷新推荐商品
                  _refreshSuggestions();
                  // 显示换一批成功提示
                  Future.delayed(Duration(milliseconds: 500), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('推荐商品已更新')),
                    );
                  });
                },
                child: Row(
                  children: [
                    Text('换一批', style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    )),
                    SizedBox(width: 4),
                    Icon(Icons.refresh, size: 14, color: AppColors.textSecondary),
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
            itemCount: _suggestedProducts.length,
            itemBuilder: (context, index) {
              final product = _suggestedProducts[index];
              return GestureDetector(
                onTap: () {
                  // 商品点击事件
                  print('推荐商品 ${product['name']} 被点击');
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
                                        color: Colors.orange.withOpacity(0.9),
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