class getOrdersModel {
  String orderId;
  String orderStatus;
  String orderPlaceDate;
  String orderDeliverDate;
  int numberOfItemsOrdered;
}

class orderItemModel {
  String brandName, vehicleName, vehicleModel, modelYear;
  int qty;
  int price;
  String partName;
  String partId;
}

class postOrderModel {
  List<orderItemModel> itemsOrdered;
  DateTime placeOrderDate;

  String transactionId;
  UserModel userModel;
}

class UserModel {
  String userId;
  String customerName;
  String deliveryAdd;
  String phoneNumber;
}



//POST ORDER
{
  "user_id":"dada",
  "customer_name":"RAM",
  "Delivery_add":'A-100, sec37 fbd',
  'phone_numer':"584223233",
  'transaction_id':"razorpay_id1333",
  'orderdate':2020-10-21,
  'items':
  [
    {
      'brand_name': 'dad',
      
    }
  ]
}