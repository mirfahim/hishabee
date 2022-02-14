class AddUnitModel {
  AddUnitModel(this.subUnit, this.price);

  String subUnit;
  double price;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sub_unit': subUnit,
        'price': price,
      };
}
