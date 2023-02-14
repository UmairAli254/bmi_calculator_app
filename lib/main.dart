import "package:flutter/material.dart";

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Your BMI"),
          centerTitle: true,
        ),
        body: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var _formKey = GlobalKey<FormState>();
  var weight;
  var height;
  var wController = TextEditingController();
  var hController = TextEditingController();
  var bmi;
  var bgColor = Colors.white;
  var bmiMsg = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 1.0,
        color: bgColor,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "BMI Calculator",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Weight Text Field
                            TextFormField(
                                controller: wController,
                                decoration: InputDecoration(
                                    prefix: Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: const Icon(
                                        Icons.fitness_center,
                                      ),
                                    ),
                                    labelText: "Enter your Weight (in Kgs)"),
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val?.isEmpty ?? true) {
                                    return "Please enter weight";
                                  }
                                }),

                            SizedBox(height: 10),
                            // Height Text Field

                            TextFormField(
                                controller: hController,
                                decoration: InputDecoration(
                                    prefix: Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: const Icon(
                                        Icons.accessibility_new,
                                      ),
                                    ),
                                    labelText: "Enter your Height (in Feet)"),
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val?.isEmpty ?? true) {
                                    return "Please enter height";
                                  }
                                }),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  weight = wController.text;
                                  height = hController.text;

                                  if (height.contains(".")) {
                                    weight = int.parse(weight);

                                    var ls = height.split(".");
                                    var strToNm =
                                        ls.map((str) => int.parse(str));
                                    strToNm = strToNm.toList();

                                    // Convert inches into feet and add(+) feet + inches
                                    var inchToFeet =
                                        (strToNm[0] + (strToNm[1] / 12));

                                    // Convert Feet into meter
                                    var mHeight = inchToFeet / 3.281;

                                    // BMI formula
                                    bmi = weight / (mHeight * mHeight);

                                    print(bmi);
                                  } else {
                                    weight = int.parse(weight);
                                    height = int.parse(height);

                                    // Convert feet to meter
                                    var mHeight = height / 3.281;
                                    // bmi formula w / (h*h);
                                    bmi = weight / (mHeight * mHeight);
                                    print(bmi);
                                  }

                                  if (bmi > 24.9 && bmi < 30) {
                                    bmiMsg = "You are Overweight";
                                    bgColor = Colors.orange.shade100;
                                  } else if (bmi > 30) {
                                    bmiMsg = "Obesity";
                                   bgColor = Colors.orange.shade100;
                                  }
                                  else if (bmi < 18.5) {
                                    bmiMsg = "You are Underweight";
                                    bgColor = Colors.red.shade100;
                                  } else {
                                    bgColor = Colors.green.shade100;
                                    bmiMsg = "Congrats, You are Healthy!";
                                  }

                                  setState(() {});
                                } //Form Validation Condition ends here
                              },
                              child: const Text(
                                "Calculate",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your BMI = ${bmi?.toStringAsFixed(2) ?? "0"}",
                      style: const TextStyle(fontSize: 19),
                    ),
                    SizedBox(height: 2),
                    Text(
                      bmiMsg,
                      style: const TextStyle(fontSize: 19),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "Healthy BMI is 18.5 to 24.9",
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
      ),
    );
  }
}
