String BASE_URL = 'https://apicarparts.herokuapp.com/api/';

// String IMAGE = 'assets/cycle.png';
String IMAGE = 'assets/bike.png';

//CATEGORY URL
String GET_CATG_URL = BASE_URL + 'store/products/categories/';

//SUB CATG
String GET_SUB_CATG_URL = BASE_URL + 'store/products/getByCategory/';

//BRANDS
String GET_BRANDS_URL = BASE_URL + 'store/products/brands/';

//CARS NAME
String GET_CARS_URL = BASE_URL + 'store/products/getByBrand/';

//VARIANTS
String GET_VARIANTS_URL = BASE_URL + 'store/products/getCarVarients';

// CAR PARTS
String GET_ALL_CAR_PART_URL = BASE_URL + 'store/products/getCarParts/';
String GET_CAR_PART_URL = BASE_URL + 'store/products/carParts/';

//ORDERS
String GET_ORDERS_LIST = BASE_URL + 'store/orders/getOrders/';
String POST_ADD_ORDER = BASE_URL + 'store/orders/newOrder/';

// Part By Id
String GET_PART_BY_ID = BASE_URL + "store/orders/getProducts/";

//USER LOGIN
String LOGIN_URL = BASE_URL + 'store/users/login';
String SIGNUP_URL = BASE_URL + 'store/users/addUser';

String ADD_ADDRESS_URL = BASE_URL + 'store/users/addUser/address';
String GET_ADDRESS_URL = BASE_URL + 'store/users/getAddress/';
String EDIT_ADDRESS_URL = BASE_URL + 'store/users/updateAddress/';
String DELETE_ADDRESS_URL = BASE_URL + 'store/users/deleteAddress/';

String SPECIFIC = BASE_URL + 'store/products/getSpecificParts';
