import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  const CustomBtn({Key key, this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Color(0xFF16F2B4),
          border: Border.all(
            color: Color(0xFF16F2B4),
            width: 2.0,

          ),
          borderRadius: BorderRadius.circular(
            12.0,
          )
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,

        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false:true,
              child: Center(
                child: Text(
                text ?? "Text",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ?  Color(0xFF16F2B4) : Colors.white,
                    fontWeight: FontWeight.w600,

                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
