import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /// The text that goes into the button
  final String text;

  /// The iconData that goes into the button
  final IconData icon;

  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// The width of the button in percentage
  ///
  /// The default value is [50] which represents 50% of parent width
  final double width;

  /// When set to true turns the button content into a spinner
  final bool isLoading;

  final Color color;

  final Color backgroundColor;

  const CustomButton({
    Key key,
    @required this.text,
    this.icon,
    @required this.onPressed,
    this.width = 100,
    this.color = Colors.white,
    this.backgroundColor,
    this.isLoading = false,
  })  : assert(text != null),
        assert(width >= 20),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          isLoading ? 55.0 : MediaQuery.of(context).size.width * (width / 100),
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        color: (backgroundColor == null)
            ? Theme.of(context).primaryColor
            : backgroundColor,
        height: 50.0,
        child: _buildButtonContent(),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildButtonContent() {
    final _text = Text(
      text,
      style: TextStyle(
        color: (color == null) ? Colors.white : color,
      ),
    );

    if (isLoading) {
      return const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ),
      );
    } else {
      if (icon == null) {
        return Center(
          child: _text,
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text,
            const SizedBox(
              width: 7.0,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 18.0,
            )
          ],
        );
      }
    }
  }
}
