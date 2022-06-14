import 'dart:convert';

BookingDetailsModel bookingDetailsModelFromJson(String str) =>
    BookingDetailsModel.fromJson(json.decode(str));

String bookingDetailsModelToJson(BookingDetailsModel data) =>
    json.encode(data.toJson());

class BookingDetailsModel {
  BookingDetailsModel({
    required this.status,
    required this.uid,
    required this.totalPrice,
    required this.productId,
  });

  int status;
  String uid;
  double totalPrice;
  List<String> productId;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
        status: json["status"],
        uid: json["uid"],
        totalPrice: json["totalPrice"].toDouble(),
        productId: List<String>.from(json["productId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "uid": uid,
        "totalPrice": totalPrice,
        "productId": List<dynamic>.from(productId.map((x) => x)),
      };
}
