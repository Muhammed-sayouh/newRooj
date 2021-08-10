import 'package:flutter/material.dart';

class MainAuthImage extends StatelessWidget {
  const MainAuthImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/authbg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
