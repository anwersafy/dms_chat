import 'package:flutter/material.dart';




class ResponsiveAnimatedContainer extends StatelessWidget {

   ResponsiveAnimatedContainer(Key? key,)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            final containerWidth = isWideScreen ? 500.0 : 300.0;
            final containerHeight = isWideScreen ? 300.0 : 200.0;

            return AnimatedContainer(
              width: containerWidth,
              height: containerHeight,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(

                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children:[
                      Text('Category:'),
                      Text('Economic'),

                    ]

                  ),
                  Row(
                    children:[
                      Text('Category:'),
                      Text('Economic'),

                    ]

                  ),
                  Row(
                    children:[
                      Text('Category:'),
                      Text('Economic'),

                    ]

                  ),
                  Row(
                    children:[
                      Text('Category:'),
                      Text('Economic'),

                    ]

                  ),
                  Row(
                    children:[
                      Text('Category:'),
                      Text('Economic'),

                    ]

                  ),

                ],
              ),
            );
          },
        ),
      );
  }
}
