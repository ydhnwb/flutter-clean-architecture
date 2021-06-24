class ErrorMapper {
  static const _HTTP_CODE_UNAUTHORIZED = 401;
  static const _HTTP_CODE_NOT_FOUND = 404;
  static const _LOCAL_DB_NOT_FOUND = 1404;


  static String getErrorMessage(int statusCode){
    switch(statusCode){
      case _HTTP_CODE_NOT_FOUND: 
        return "Data not found";
      case _HTTP_CODE_UNAUTHORIZED:
        return "Wrong credentials.";
      case _LOCAL_DB_NOT_FOUND:
        return "Data not found on local database";
      default:
        return "Something wrong. [$statusCode]";
    }
  }
}