class Contact {
  String name;
  String phoneNumber;
  String address;
  String company;
  bool isFavorited;
  String id;

  Contact({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.company,
    required this.isFavorited,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "address": address,
    "company": company,
    "isFavorited": isFavorited,
    "id": id,
  };
}
