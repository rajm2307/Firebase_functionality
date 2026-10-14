class ApiRoutes {
  static const String baseUrl = "https://fakestoreapi.com";

  // Auth Endpoints
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";

  // Products Endpoints
  static const String allProducts = "$baseUrl/products";
  static const String categories = "$baseUrl/products/categories";
  static const String fetchedCategoryProducts = "$baseUrl/products/category";
  static const String productDetails = "$baseUrl/products";

  // Dynamic Route Example
  static String userDetails(int userId) => "$baseUrl/users/$userId";
}