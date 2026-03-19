import 'package:flutter/material.dart';
import 'package:mango_shop/pages/Main/index.dart';
import 'package:mango_shop/utils/colors.dart';
import 'package:mango_shop/utils/text_styles.dart';

class CartView extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(List<CartItem>)? onCartItemsChanged;
  final Function(int)? onCartCountChanged;

  CartView({Key? key, required this.cartItems, this.onCartItemsChanged, this.onCartCountChanged}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool _isAllSelected = true;

  // 计算购物车总数量
  int get _cartCount {
    return widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // 通知父组件购物车数量变化
  void _notifyCartCountChanged() {
    if (widget.onCartCountChanged != null) {
      widget.onCartCountChanged!(_cartCount);
    }
  }

  // 更新购物车数据
  void _updateCartItems(List<CartItem> newCartItems) {
    if (widget.onCartItemsChanged != null) {
      widget.onCartItemsChanged!(newCartItems);
    }
  }

  // 计算总价
  double get _totalPrice {
    return widget.cartItems
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  // 计算选中商品数量
  int get _selectedCount {
    return widget.cartItems
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  // 切换商品选中状态
  void _toggleItemSelection(int index) {
    // 创建购物车数据的副本
    final newCartItems = List<CartItem>.from(widget.cartItems);
    newCartItems[index].isSelected = !newCartItems[index].isSelected;
    
    setState(() {
      _isAllSelected = newCartItems.every((item) => item.isSelected);
    });
    
    // 更新购物车数据
    _updateCartItems(newCartItems);
  }

  // 切换全选状态
  void _toggleAllSelection() {
    // 创建购物车数据的副本
    final newCartItems = List<CartItem>.from(widget.cartItems);
    final newIsAllSelected = !_isAllSelected;
    newCartItems.forEach((item) => item.isSelected = newIsAllSelected);
    
    setState(() {
      _isAllSelected = newIsAllSelected;
    });
    
    // 更新购物车数据
    _updateCartItems(newCartItems);
  }

  // 增加商品数量
  void _increaseQuantity(int index) {
    // 创建购物车数据的副本
    final newCartItems = List<CartItem>.from(widget.cartItems);
    newCartItems[index].quantity++;
    
    // 更新购物车数据
    _updateCartItems(newCartItems);
    _notifyCartCountChanged();
  }

  // 减少商品数量
  void _decreaseQuantity(int index) {
    // 创建购物车数据的副本
    final newCartItems = List<CartItem>.from(widget.cartItems);
    if (newCartItems[index].quantity > 1) {
      newCartItems[index].quantity--;
      
      // 更新购物车数据
      _updateCartItems(newCartItems);
      _notifyCartCountChanged();
    }
  }

  // 删除商品
  void _removeItem(int index) {
    // 创建购物车数据的副本
    final newCartItems = List<CartItem>.from(widget.cartItems);
    newCartItems.removeAt(index);
    
    setState(() {
      _isAllSelected = newCartItems.every((item) => item.isSelected);
    });
    
    // 更新购物车数据
    _updateCartItems(newCartItems);
    _notifyCartCountChanged();
  }

  // 清空购物车
  void _clearCart() {
    // 显示确认对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认清空'),
          content: Text('确定要清空购物车吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消', style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                // 更新购物车数据
                _updateCartItems([]);
                
                setState(() {
                  _isAllSelected = false;
                });
                
                Navigator.of(context).pop();
                // 显示清空成功提示
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('购物车已清空')),
                );
              },
              child: Text('确定', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          if (widget.cartItems.isNotEmpty)
            TextButton(
              onPressed: _clearCart,
              child: Text('清空', style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      body: widget.cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(index);
                    },
                  ),
                ),
                _buildCheckoutBar(),
              ],
            ),
    );
  }

  // 构建空购物车界面
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/ic_public_cart_normal.png',
            width: 100,
            height: 100,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Text('购物车是空的', style: TextStyle(color: Colors.grey, fontSize: 16)),
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              elevation: 2,
              shadowColor: AppColors.primary.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建购物车商品项
  Widget _buildCartItem(int index) {
    final item = widget.cartItems[index];
    return Container(
      padding: EdgeInsets.all(16),
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
      child: Row(
        children: [
          // 选择框
          Checkbox(
            value: item.isSelected,
            onChanged: (value) => _toggleItemSelection(index),
            activeColor: Colors.red,
          ),
          // 商品图片
          Container(
            width: 80,
            height: 80,
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
                Text(
                  '¥${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 数量控制
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _decreaseQuantity(index),
                          icon: Icon(Icons.remove, size: 18),
                          constraints: BoxConstraints(minWidth: 30),
                        ),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text(item.quantity.toString()),
                        ),
                        IconButton(
                          onPressed: () => _increaseQuantity(index),
                          icon: Icon(Icons.add, size: 18),
                          constraints: BoxConstraints(minWidth: 30),
                        ),
                      ],
                    ),
                    // 删除按钮
                    IconButton(
                      onPressed: () => _removeItem(index),
                      icon: Icon(Icons.delete_outline, color: Colors.grey),
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

  // 构建结算栏
  Widget _buildCheckoutBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          // 全选
          Row(
            children: [
              Checkbox(
                value: _isAllSelected,
                onChanged: (value) => _toggleAllSelection(),
                activeColor: Colors.red,
              ),
              Text('全选'),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 总价
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '合计: ¥${_totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '已选 ${_selectedCount} 件商品',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                // 结算按钮
                ElevatedButton(
                  onPressed: _selectedCount > 0
                      ? () {
                          // 结算逻辑
                          print('结算 ${_selectedCount} 件商品，总价：¥${_totalPrice.toStringAsFixed(2)}');
                          // 显示结算确认对话框
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('确认结算'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('共 ${_selectedCount} 件商品', style: TextStyle(color: Colors.grey[700])),
                                    SizedBox(height: 8),
                                    Text('合计：¥${_totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('取消', style: TextStyle(color: Colors.grey[600])),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // 模拟结算成功
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('结算成功！')),
                                      );
                                    },
                                    child: Text('确认结算', style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null,
                  child: Text('结算 ${_selectedCount}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    shadowColor: Colors.red.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}