import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'orderInfo.dart';

class DbHelper {
  static const String tableName = 'orders';
  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  DbHelper.internal();

  // static Database _db ;

  Future<Database> createDatabase() async {
    // if (_db != null) {
    //   return _db;
    // }
    String path = join(await getDatabasesPath(), 'order.db');
    Database _db =
        await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      db.execute(
          'create table $tableName(id integer primary key autoincrement,item_id integer,quantity integer, name varchar(255), price varchar(255), saleprice varchar(255), image_url varchar(255))');
    });
    return _db;
  }

  Future<int> createOrder(OrderInfo order, {required int counter}) async {
    Database db = await createDatabase();
    final List<OrderInfo> orders = await allOrders();
    return db.insert(tableName, order.toMap());
  }

  Future<bool> isexisting(int orderId) async {
    print('$orderId order id');
    final List<OrderInfo> orders = await allOrders();
    bool isExested = false;
    for (var i = 0; i < orders.length; i++) {
      if (orders[i].itemId == orderId) {
        print(orders[i].itemId);
        isExested = true;
        return true;
      } else {
        isExested = false;
        return false;
      }
    }
    print('$isExested isssss');
    return isExested;
    // final existingOrder = orders.isEmpty
    //     ? []
    //     : orders.where(
    //         (element) => element.itemId == orderId,
    //       );
    // print('${existingOrder.toString()} is ex');
    // if (existingOrder != null) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future<int> updateOrder(int itemId, int quantity) async {
    Database db = await createDatabase();
    return db.update(tableName, {'quantity': quantity},
        where: 'item_id = ?', whereArgs: [itemId]);
  }

  Future<List<OrderInfo>> allOrders() async {
    Database db = await createDatabase();
    final extractedData = await db.query(tableName);
    final orders = extractedData.isEmpty
        ? <OrderInfo>[]
        : extractedData.map((e) => OrderInfo.fromMap(e)).toList();
    return orders;
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete(tableName, where: 'item_id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllOrders() async {
    Database db = await createDatabase();
    return db.delete(tableName);
  }
}
