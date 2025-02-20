import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoalna/screens/utils/constants.dart';

class ShimmerExampleItems extends StatefulWidget {
  const ShimmerExampleItems({super.key});

  @override
  State<ShimmerExampleItems> createState() => _ShimmerExampleState();
}

class _ShimmerExampleState extends State<ShimmerExampleItems> {
  late bool _isLoading;

  @override
  // void initState() {
  //   _isLoading = true;
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: NewWidget());
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        // Shimmer.fromColors(
        //   // enabled: true,
        //   baseColor: Colors.grey[400]!,
        //   highlightColor: Colors.grey[100]!,
        //   child: const ListTile(
        //     title: Text('Slide to unlock'),
        //     trailing: Icon(Icons.keyboard_arrow_right),
        //   ),
        // ),
        // const Divider(),
        Shimmer.fromColors(
          // enabled: true,
          baseColor: Constants.Primarycolor.withOpacity(0.2),
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400]!,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 1.5,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[400]!,
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[400]!,
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[400]!,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                // height: 400,
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 13),
                    child: placeHoldercat(),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.2),
                  // separatorBuilder: (_, __) => const SizedBox(height: 2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  placeHoldercat1(),
                  placeHoldercat1()
                  // Container(
                  //   height: 150,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: Colors.grey[400]!,
                  //   ),
                  // ),
                  // Container(
                  //   height: 150,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: Colors.grey[400]!,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

// Some white boxes to indicate a placeholder for contents to come.
// Copied from https://pub.dev/packages/shimmer/example

Widget placeHoldercat() => Row(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 10, left: 20, top: 10, bottom: 10),
          padding: const EdgeInsets.only(
            top: 10,
          ),
          height: 130,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            //color: Colors.grey,

            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.4),
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
              ),
              Container(
                width: 60,
                height: 55.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 1),
              Column(
                //   mainAxisAlignment: MainAxisAlignment.start,

                // crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  // Container(
                  //   width: 60,
                  //   height: 10.0,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  // Container(
                  //   width: 60,
                  //   height: 10.0,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  Container(
                    width: 50,
                    height: 8.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

Widget placeHoldercat1() => Row(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 10),
          padding: const EdgeInsets.all(10),
          height: 240,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            //color: Colors.grey,

            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.4),
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
              ),
              Container(
                width: 150,
                height: 170.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                //   mainAxisAlignment: MainAxisAlignment.start,

                // crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Container(
                    width: 145,
                    height: 10.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   width: 60,
                  //   height: 10.0,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  Container(
                    width: 60,
                    height: 10.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
