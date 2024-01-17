
import 'package:flutter/material.dart';
//import 'package:always_show_scrollbars/always_show_scrollbars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: MyDataTable(),
    );
  }
}

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<Map<String, dynamic>> jsonList = [
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Visually inspect the bogie frame and their components for crack, loose, missing and leakage etc. and check whether all equipment is secure."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Perform visual check on longitudinal beams, cross beams for cracks, damages and corrosion."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Perform visual check on brake supports, damper supports, traction center supports and stabilizer assembly supports for cracks, damages and corrosion."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Check bogie brackets visually for cracks, damages and corrosion"
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Perform visual check on longitudinal beams, cross beams for cracks, damages and corrosion."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Perform visual check on brake supports, damper supports, traction center supports and stabilizer assembly supports for cracks, damages and corrosion."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Check bogie brackets visually for cracks, damages and corrosion"
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Perform visual check on longitudinal beams, cross beams for cracks, damages and corrosion."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Perform visual check on brake supports, damper supports, traction center supports and stabilizer assembly supports for cracks, damages and corrosion."
    },
    {
      "Assembly": "Bogie",
      "SubAssembly": "Bogie Frame",
      "Activities":
          "Check bogie brackets visually for cracks, damages and corrosion"
    }
  ];

  List<String> dropdownValues = ["OK", "Not ok", "Maybe"];
  Map<int, String> selectedValues = {};
  Map<int, TextEditingController> textControllers = {};

  late ScrollController _horizontalScrollController;
  late ScrollController _verticalScrollController;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < jsonList.length; i++) {
      selectedValues[i] = dropdownValues[1];
      textControllers[i] = TextEditingController();
    }
    _horizontalScrollController = ScrollController();
    _verticalScrollController = ScrollController();
  }

  void resetDropdownValues() {
    setState(() {
      for (int i = 0; i < jsonList.length; i++) {
        selectedValues[i] = dropdownValues[0];
      }
    });
  }

  void onSaveButtonPressed() {
    // Implement the logic to save remarks here
    for (int i = 0; i < jsonList.length; i++) {
      TextEditingController? controller = textControllers[i];
      if (controller != null) {
        String remark = controller.text;
        // You can save the remark data as needed, e.g., in a database or print it for testing
        print('Saved Remark for Row $i: $remark');
      }
    }
    // Optional: Clear the text field controllers after saving
    textControllers.forEach((_, controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion DataGrid Demo'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0), // Set the desired margin
            child: TextButton(
              onPressed: () {
                resetDropdownValues();
              },
              child: Text(
                'All OK',
                style: TextStyle(
                  color: Color.fromARGB(255, 41, 106, 236),
                  fontSize: 18, // Set the desired font size
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            controller: _verticalScrollController,
            scrollDirection: Axis.vertical,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _horizontalScrollController,
              showTrackOnHover: true,
              radius: Radius.circular(5),

              interactive: true,
              // Ensure the scrollbar is always shown
              
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.all(21.0),
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Assembly')),
                      DataColumn(label: Text('SubAssembly')),
                      DataColumn(label: Text('Activities')),
                      DataColumn(label: Text('Dropdown')),
                      DataColumn(label: Text('Remark')),
                    ],
              
                    dataRowHeight: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black), // Add border to the DataTable
                    ),
                    rows: List<DataRow>.generate(
                      jsonList.length,
                      (index) => DataRow(
                        color: index % 2 == 0
                            ? MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 115, 171, 218))
                            : null,
                        cells: <DataCell>[
                          DataCell(Text('${jsonList[index]["Assembly"]}')),
                          DataCell(Text('${jsonList[index]["SubAssembly"]}')),
                          DataCell(Container(
                            width: constraints.maxWidth * 0.58,
                            child: Text('${jsonList[index]["Activities"]}'),
                          )),
DataCell(DropdownButton<String>(
                            value: selectedValues[index],
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  selectedValues[index] = newValue;
                                }
                              });
                            },
                            items: dropdownValues
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          
                          )),
                          DataCell(TextField(
                            controller: textControllers[index],
                            decoration: InputDecoration(
                              hintText: 'Enter Remark',
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSaveButtonPressed,
        tooltip: 'Save Remarks',
        child: Icon(Icons.save),
      ),
    );
  }
}
