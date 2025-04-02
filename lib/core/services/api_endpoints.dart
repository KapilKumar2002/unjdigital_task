class ApiEndpoints {
  // baseUrl
  static const String baseUrl =
      "https://c43d9c37-22a2-4d9b-9f13-923d980cd6ec.mock.pstmn.io";

  // User Endpoints

  static String getUsers(String page) => "/users?page=$page";
  static String getUserById(String id) => "/users/$id";
  static String updateUser(String id) => "/users/$id";
  static String deleteUser(String id) => "/users/$id";
}


// we are using string interpolation here. In this we can use variables within the strings
// with the help of "$" sign as we are doing "/users?page=$page"
// static String getUsers(String page) => "/users?page=$page"; will work lika a function
// on use we will send page number in the getUsers function