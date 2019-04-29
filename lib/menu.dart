class MenuObject {
  String name;
  String description;
  String imgUrl;
  String ingredients;
  num remain;
  num total;
  num price;
  String vendor;
  String status;
  num dishId;

  MenuObject(String name, String description, String imgUrl, String ingredients,
      num remain, num total, num price, String vendor, String status, num dishId) {
    this.name = name;
    this.description = description;
    this.imgUrl = imgUrl;
    this.ingredients = ingredients;
    this.remain = remain;
    this.vendor = vendor;
    this.status = status;
    this.total = total;
    this.price = price;
    this.dishId = dishId;
  }
}
