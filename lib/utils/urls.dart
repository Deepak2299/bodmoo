String BASE_URL = 'https://apicarparts.herokuapp.com/api/';

// String IMAGE = 'assets/logo.png';
String IMAGE = 'assets/bike.png';

//CATEGORY URL
String GET_CATG_URL = BASE_URL + 'store/products/categories/';

//SUB CATG
String GET_SUB_CATG_URL = BASE_URL + 'store/products/getByCategory/';

//BRANDS
String GET_BRANDS_URL = BASE_URL + 'store/products/brands/';

//CARS NAME
String GET_CARS_URL = BASE_URL + 'products/getByBrand/';

//VARIANTS
String GET_VARIANTS_URL = BASE_URL + 'getCarVarients/';

// CAR PARTS
String GET_ALL_CAR_PART_URL = BASE_URL + 'store/products/getCarParts/';
String GET_CAR_PART_URL = BASE_URL + 'store/products/carParts/';

//ORDERS
String GET_ORDERS_LIST = BASE_URL + 'store/orders/getOrders/';
String POST_ADD_ORDER = BASE_URL + 'store/products/newOrder/';

// Part By Id
String GET_PART_BY_ID = BASE_URL + "store/products/getProduct/";

//USER LOGIN
String LOGIN_URL = BASE_URL + '/store/users/login';
