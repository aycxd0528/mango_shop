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

class PendingShipmentOrders extends StatefulWidget {
  PendingShipmentOrders({Key? key}) : super(key: key);

  @override
  _PendingShipmentOrdersState createState() => _PendingShipmentOrdersState();
}

class _PendingShipmentOrdersState extends State<PendingShipmentOrders> {
  // 模拟待发货订单数据
  List<Order> _pendingShipmentOrders = [
    Order(
      orderId: '202601280003',
      createTime: '2026-01-28 15:20:10',
      totalPrice: 59.8,
      totalQuantity: 2,
      items: [
        OrderItem(
          id: '1',
          name: '新鲜芒果 泰国进口大青芒 2个装 单果约400-500g 新鲜水果',
          image: 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
          price: 29.9,
          quantity: 2,
        ),
      ],
      status: '待发货',
    ),
    Order(
      orderId: '202601280004',
      createTime: '2026-01-28 16:05:30',
      totalPrice: 41.8,
      totalQuantity: 3,
      items: [
        OrderItem(
          id: '2',
          name: '海南小台农芒果 500g装 单果约80-120g 新鲜水果',
          image: 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
          price: 15.9,
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
      status: '待发货',
    ),
  ];

  // 提醒发货
  void _remindShipment(String orderId) {
    print('提醒发货：$orderId');
    // 显示提醒发货确认对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提醒发货'),
          content: Text('是否确认提醒商家发货？'),
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
                // 显示提醒发货成功提示
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('已提醒商家尽快发货')),
                );
              },
              child: Text('确认提醒', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  // 查看订单详情
  void _viewOrderDetail(String orderId) {
    print('查看订单详情：$orderId');
    // 显示订单详情提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('订单详情功能开发中')),
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
                      onPressed: () => _viewOrderDetail(order.orderId),
                      child: Text('查看详情', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
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
                      onPressed: () => _remindShipment(order.orderId),
                      child: Text('提醒发货', style: AppTextStyles.button),
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
        title: Text('待发货'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: _pendingShipmentOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
                  SizedBox(height: 16),
                  Text('暂无待发货订单', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _pendingShipmentOrders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(_pendingShipmentOrders[index]);
              },
            ),
    );
  }
}
