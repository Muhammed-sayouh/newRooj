import 'dart:convert';

class Order {
  int paymentMethodId;
  int shippingCompanyId;
  double longitude;
  double latitude;
  List<OrderInfo> orderInfo;
  int orderId;

  Order({
    required this.orderInfo,
    required this.latitude,
    required this.longitude,
    required this.paymentMethodId,
    required this.shippingCompanyId,
    required this.orderId,
  });

  Map<String, String> toMap() {
    return {
      // 'api_password': Constants.API_PASSWORD,
      // 'payment_method_id': paymentMethodId.toString(),
      // 'shipping_company_id': shippingCompanyId.toString(),
      // 'longitude': longitude.toString(),
      // 'latitude': latitude.toString(),
      'order': json.encode(orderInfo
          .map((e) => OrderInfo(
                id: e.id,
                imageUrl: e.imageUrl,
                itemId: e.id,
                name: e.name,
                price: e.price,
                saleprice: e.saleprice,
              ).toCustomMap(e))
          .toList()),
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Order(
      paymentMethodId: map['payment_method_id'],
      shippingCompanyId: map['shipping_company_id'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      orderInfo:
          (map['order'] as List).map((e) => OrderInfo.fromMap(e)).toList(),
      orderId: 0,
    );
  }

  String toJson() => json.encode(toMap());

  static Order fromJson(String source) => fromMap(json.decode(source));
}

class OrderInfo {
  int id;
  final int itemId;
  int quantity;
  final String name;
  final String price;
  final String saleprice;
  final String imageUrl;

  OrderInfo({
    required this.id,
    required this.itemId,
    this.quantity = 1,
    required this.name,
    required this.price,
    required this.saleprice,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'quantity': quantity,
      'name': name,
      'price': price,
      'saleprice': saleprice,
      'image_url': imageUrl,
    };
  }

  Map<String, dynamic> toCustomMap(OrderInfo info) {
    return {
      'id': info.itemId,
      'quantity': info.quantity,
      'name': info.name,
      'price': info.price,
      "vendor_id": 4
    };
  }

  static OrderInfo fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OrderInfo(
      id: map['id'],
      itemId: map['item_id'],
      quantity: map['quantity'],
      name: map['name'],
      price: map['price'],
      saleprice: map['saleprice'],
      imageUrl: map['image_url'],
    );
  }

  String toJson() => json.encode(toMap());

  static OrderInfo fromJson(String source) => fromMap(json.decode(source));
}
