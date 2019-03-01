import './menu.dart';

class VendorObject {
  String name;
  String address;
  String imgUrl;
  num rating;
  String description;
  List<MenuObject> todayOffering;

  VendorObject(
    this.name,
    this.address,
    this.imgUrl,
    this.rating,
    this.description,
    this.todayOffering
  );
}

