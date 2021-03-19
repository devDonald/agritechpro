import 'package:flutter/material.dart';

List<String> gender = ['Male', 'Female'];

class FarmerCard extends StatelessWidget {
  final String image, fullName, gender, occupation, location;
  final Function onTap;

  const FarmerCard({
    Key key,
    this.image,
    this.fullName,
    this.gender,
    this.occupation,
    this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (screenSize.width - 20) / 2,
        height: 120.0,
        margin: EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        padding: EdgeInsets.all(
          12.2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 1.5),
              blurRadius: 3.0,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              image,
              height: 100.0,
              width: 100.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBody(
                    title: fullName,
                    icon: Icons.person,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextBody(
                    title: gender,
                    icon: Icons.anchor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextBody(
                    title: occupation,
                    icon: Icons.work,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextBody(
                    title: location,
                    icon: Icons.location_on,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextBody extends StatelessWidget {
  final String title;
  final IconData icon;

  const TextBody({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(
                icon,
                size: 16,
                color: Colors.red,
              ),
            ),
          ),
          TextSpan(text: title),
        ],
      ),
    );
  }
}
