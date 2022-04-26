class PageRequestModel {
  var page = 0;
  var size = 20;
  var isLast = false;
  var isLoading = false;

  Map<String, dynamic> getRequestParam() {
    return {'page': page, 'size': size};
  }

  void setResult(List<dynamic> result) {
    if (result.length % size == 0) {
    } else {
      isLast = true;
    }
    isLoading = false;
    page++;
  }

  void setRefresh() {
    page = 0;
    isLast = false;
    isLoading = false;
  }
}
