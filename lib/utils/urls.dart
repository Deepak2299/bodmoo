String BASE_URL = 'https://apicarparts.herokuapp.com/api/';

// String IMAGE = 'assets/logo.png';
String IMAGE = 'assets/bike.png';

//CATEGORY URL
String GET_CATG_URL = BASE_URL + 'store/categories/';
String ADD_CATG_URL = BASE_URL + 'store/addCategory/';

//SUB CATG
String GET_SUB_CATG_URL = BASE_URL + 'getByCategory/';
String ADD_SUB_CATG_URL = BASE_URL + 'store/addSubcategory/';

//BRANDS
String GET_BRANDS_URL = BASE_URL + 'store/brands/';
String ADD_BRANDS_URL = BASE_URL + 'store/addBrand/';

//CARS NAME
String GET_CARS_URL = BASE_URL + 'getByBrand/';
String ADD_CARS_URL = BASE_URL + 'store/addCars/';

//VARIANTS
String GET_VARIANTS_URL = BASE_URL + 'getCarVarients/';
String ADD_VARIANTS_URL = BASE_URL + 'store/addcarmodels/';

// CAR PARTS
String GET_ALL_CAR_PART_URL = BASE_URL + 'store/getCarParts/';
String GET_CAR_PART_URL = BASE_URL + 'store/carParts/';
String ADD_CAR_PART_URL = BASE_URL + 'store/addCarParts/';

// DELETE PARTS DETAILS
String DELETE_CAR_PARTS = BASE_URL + "store/removeCarParts/";
String DELETE_CAR_MODELS =
    BASE_URL + "store/removeCarParts/deleteParticularModel/";
String DELETE_BRAND = BASE_URL + "store/removeCarParts/deleteBrand/";
String DELETE_VEHICLE = BASE_URL + "store/removeCarParts/deleteSpecificCar/";
String DELETE_CATG = BASE_URL + "store/removeCategory/";
String DELETE_SUB_CATG = BASE_URL + "store/removeSubCategory/";

//ORDERS
String GET_ORDERS_LIST = BASE_URL + 'store/getOrders/';
String POST_ADD_ORDER = BASE_URL + 'store/newOrder/';

// Part By Id
String GET_PART_BY_ID = BASE_URL + "store/getProduct/";
