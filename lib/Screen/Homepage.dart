import 'package:dummy/provider/countProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    final sliderProvider = Provider.of<multiProvider>(context, listen: false);
    print("build function ");

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Providerusing ex"),
      ),
      body: Container(
        child: Center(
          child: Consumer<multiProvider>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                      value: sliderProvider.sliderValue,
                      onChanged: (NewSliderValue) {
                        sliderProvider.ChangeSlider(NewSliderValue);
                      }),
                  Container(
                    height: 100,
                    color: const Color.fromARGB(255, 0, 0, 0)
                        .withOpacity(value.sliderValue),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
