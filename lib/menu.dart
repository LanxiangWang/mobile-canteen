class MenuObject {
  String name;
  String description;
  String imgUrl;
  String ingredients;
  num remain;
  num total;
  String vendor;
  String status;

  MenuObject(String name, String description, String imgUrl, String ingredients,
      num remain, num total, String vendor, String status) {
    this.name = name;
    this.description = description;
    this.imgUrl = imgUrl;
    this.ingredients = ingredients;
    this.remain = remain;
    this.vendor = vendor;
    this.status = status;
    this.total = total;
  }
}
