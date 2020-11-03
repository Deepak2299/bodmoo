String BASE_URL = 'https://apicarparts.herokuapp.com/api/';

// String IMAGE = 'assets/logo.png';
String IMAGE = 'assets/bike.png';

//CATEGORY URL
String GET_CATG_URL = BASE_URL + 'store/products/categories/';
String ADD_CATG_URL = BASE_URL + 'store/products/addCategory/';

//SUB CATG
String GET_SUB_CATG_URL = BASE_URL + 'getByCategory/';
String ADD_SUB_CATG_URL = BASE_URL + 'store/products/addSubcategory/';

//BRANDS
String GET_BRANDS_URL = BASE_URL + 'store/products/brands/';
String ADD_BRANDS_URL = BASE_URL + 'store/products/addBrand/';

//CARS NAME
String GET_CARS_URL = BASE_URL + 'getByBrand/';
String ADD_CARS_URL = BASE_URL + 'store/products/addCars/';

//VARIANTS
String GET_VARIANTS_URL = BASE_URL + 'getCarVarients/';
String ADD_VARIANTS_URL = BASE_URL + 'store/products/addcarmodels/';

// CAR PARTS
String GET_ALL_CAR_PART_URL = BASE_URL + 'store/products/getCarParts/';
String GET_CAR_PART_URL = BASE_URL + 'store/products/carParts/';
String ADD_CAR_PART_URL = BASE_URL + 'store/products/addCarParts/';

//ORDERS
String GET_ORDERS_LIST = BASE_URL + 'store/products/getOrders/';
String POST_ADD_ORDER = BASE_URL + 'store/products/newOrder/';

// Part By Id
String GET_PART_BY_ID = BASE_URL + "store/products/getProduct/";
