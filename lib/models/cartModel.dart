class getOrdersModel
{
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
