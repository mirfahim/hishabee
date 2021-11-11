class Contact {
  final int id;
  final int userId;
  final int shopId;
  final String name;
  final String mobile;
  final String email;
  final String address;
  final String imageSrc;
  final DateTime createdAt;
  final DateTime updatedAt;

  Contact(this.id, this.userId, this.shopId, this.name, this.mobile, this.email,
      this.address, this.imageSrc, this.createdAt, this.updatedAt);
}
