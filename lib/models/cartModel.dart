List<getOrdersModel> getOrdersList;

class getOrdersModel {
  String orderId;
  String orderStatus;
  String orderPlaceDate;
  String orderDeliverDate;
  int numberOfItemsOrdered;
}

List<orderItemModel> orderItems; //(get orderItems from Order ID)

class orderItemModel {
//  String catgName, subCatgName;
  String brandName, vehicleName, vehicleModel, modelYear;
  int qty;
  int price;
  String partName;
  String partId;
}

class postOrderModel {
  UserModel user;
  DateTime placeOrderDate;
  String transactionId;
  List<orderItemModel> itemsOrdered;
}

class UserModel {
  String userId;
  String customerName;
  String deliveryAdd;
  String phoneNumber;
}

//POST ORDER
Map<String, dynamic> map = {
  "user": {
    "user_id": "33mrfs",
    "customer_name": "RAM",
    "Delivery_add": 'A-100, sec37, fbd',
    'phone_numer': "584223233"
  },
  "transactionId": "razorpayId",
  'orderdate': 2020 - 10 - 21,

  'items': [
    {
      'part_id': '123',
      'qty': '1',
    }
  ]
};
