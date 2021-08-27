import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/restaurant.dart';

class DeliveryInfoSection extends StatelessWidget {
  const DeliveryInfoSection({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) => _section(
        title: _titleText(title: "Delivery"),
        addressInfo: _deliveryInfo(
          restaurant: restaurant.name,
          name: "Siwat Ponpued",
          phoneNumber: "0971077427",
          address: "97/9, Banglen, Bangkok, Thailand",
        ),
      );

  Widget _section({required Widget title, required Widget addressInfo}) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            SizedBox(
              height: 16,
            ),
            addressInfo,
          ],
        ),
      );

  Widget _titleText({required String title}) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );

  Widget _deliveryInfo({
    required String restaurant,
    required String name,
    required String phoneNumber,
    required String address,
  }) =>
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "from",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        restaurant,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "to",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                phoneNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
