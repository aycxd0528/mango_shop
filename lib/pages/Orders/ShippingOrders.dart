import 'package:flutter/material.dart';
import 'package:mango_shop/utils/colors.dart';
import 'package:mango_shop/utils/text_styles.dart';

// 订单商品模型
class OrderItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

// 订单模型
class Order {
  final String orderId;
  final String createTime;
  final double totalPrice;
  final int totalQuantity;
  final List<OrderItem> items;
  final String status;

  Order({
    required this.orderId,
    required this.createTime,
    required this.totalPrice,
    required this.totalQuantity,
    required this.items,
    required this.status,
  });
}

class ShippingOrders extends StatefulWidget {
  ShippingOrders({Key? key}) : super(key: key);

  @override
  _ShippingOrdersState createState() => _ShippingOrdersState();
}

class _ShippingOrdersState extends State<ShippingOrders> {
  // 模拟待收货订单数据
  List<Order> _shippingOrders = [
    Order(
      orderId: '202601280003',
      createTime: '2026-01-28 12:30:25',
      totalPrice: 85.7,
      totalQuantity: 6,
      items: [
        OrderItem(
          id: '1',
          name: '新鲜芒果 泰国进口大青芒 2个装 单果约400-500g 新鲜水果',
          image: 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
          price: 29.9,
          quantity: 2,
        ),
        OrderItem(
          id: '3',
          name: '广西百色芒果 桂七香芒 2个装 单果约300-400g 新鲜水果',
          image: 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
          price: 25.9,
          quantity: 1,
        ),
      ],
      status: '待收货',
    ),
    Order(
      orderId: '202601280004',
      createTime: '2026-01-28 11:15:40',
      totalPrice: 15.9,
      totalQuantity: 1,
      items: [
        OrderItem(
          id: '2',
          name: '海南小台农芒果 500g装 单果约80-120g 新鲜水果',
          image: 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
          price: 15.9,
          quantity: 1,
        ),
      ],
      status: '待收货',
    ),
  ];

  // 确认收货
  void _confirmReceipt(String orderId) {
    print('确认收货：$orderId');
    // 显示确认收货对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认收货'),
          content: Text('请确认您已收到该订单的商品？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消', style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 模拟确认收货成功
                setState(() {
                  _shippingOrders.removeWhere((order) => order.orderId == orderId);
                });
                // 显示确认收货成功提示
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('确认收货成功！')),
                );
              },
              child: Text('确认收货', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  // 查看物流
  void _checkLogistics(String orderId) {
    print('查看物流：$orderId');
    // 显示物流信息对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('物流信息'),
          content: Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('订单号：$orderId'),
                  SizedBox(height: 12),
                  Text('物流公司：顺丰速运'),
                  Text('物流单号：SF1234567890'),
                  SizedBox(height: 12),
                  Text('2026-01-28 10:00:00', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('快递已到达 [北京市朝阳区派送点]'),
                  SizedBox(height: 8),
                  Text('2026-01-28 08:00:00', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('快递离开 [北京市分拨中心]，发往 [北京市朝阳区派送点]'),
                  SizedBox(height: 8),
                  Text('2026-01-27 20:00:00', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('快递已到达 [北京市分拨中心]'),
                  SizedBox(height: 8),
                  Text('2026-01-27 15:00:00', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('快递离开 [广东省深圳市分拨中心]，发往 [北京市分拨中心]'),
                  SizedBox(height: 8),
                  Text('2026-01-27 10:00:00', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('商家已发货'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  // 构建订单商品项
  Widget _buildOrderItem(OrderItem item) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          // 商品图片
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          // 商品信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '¥${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text('x${item.quantity}', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建订单卡片
  Widget _buildOrderCard(Order order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 订单头部
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('订单号：${order.orderId}', style: TextStyle(fontSize: 14)),
                Text(order.createTime, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          // 订单商品列表
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: order.items.map((item) => _buildOrderItem(item)).toList(),
            ),
          ),
          // 订单底部
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '共${order.totalQuantity}件商品，合计：¥${order.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => _checkLogistics(order.orderId),
                      child: Text('查看物流', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        side: BorderSide(color: AppColors.gray300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => _confirmReceipt(order.orderId),
                      child: Text('确认收货', style: AppTextStyles.button),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        elevation: 2,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('待收货订单'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: _shippingOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_shipping, size: 80, color: Colors.grey[300]),
                  SizedBox(height: 20),
                  Text('暂无待收货订单', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // 跳转到首页
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('去购物', style: AppTextStyles.button),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      elevation: 2,
                      shadowColor: AppColors.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _shippingOrders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(_shippingOrders[index]);
              },
            ),
    );
  }
}
