import 'package:flutter/material.dart';

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  //varaibles
  ListItem? selectedItem = ListItem(
      image: "assets/magition_pic.png",
      title: "Shot 01 Maya hands wide open"); // Store selected item

// Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            // LEFT SECTION: Expandable List
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.grey[200],
                color: Colors.black,
                padding: const EdgeInsets.all(1.0),
                child: ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      elevation: 2,
                      child: ExpansionTile(
                        leading: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            size: 30,
                            isExpanded
                                ? Icons.arrow_drop_down_outlined
                                : Icons.arrow_right,
                            key: ValueKey(isExpanded),
                          ),
                        ),
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            isExpanded = expanded;
                          });
                        },
                        childrenPadding: EdgeInsets.all(0),
                        title: Container(
                          height: 30, // 🔹 Fixed height
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              // const Icon(Icons.arrow_right, size: 30, color: Colors.black54), // Custom arrow
                              // const SizedBox(width: 8),
                              Text(
                                sections[index].headerTitle,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        trailing:
                            const SizedBox.shrink(), // Removes default arrow
                        children: sections[index].items.map((item) {
                          return ListTile(
                            leading: Image.asset(item.image,
                                width: 70, height: 40, fit: BoxFit.cover),
                            title: Text(item.title,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w200)),
                            onTap: () {
                              setState(() {
                                selectedItem = item; // Update selected item
                              });
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // MIDDLE SECTION: Show Selected Item
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: selectedItem == null
                    ? const Center(
                        child: Text("Select an item",
                            style: TextStyle(fontSize: 20, color: Colors.grey)))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedItem!.title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Image.asset(selectedItem!.image,
                              width: 250, height: 250, fit: BoxFit.cover),
                        ],
                      ),
              ),
            ),

            // RIGHT SECTION
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                // child: const Center(
                //   child: Text("Right Section", style: TextStyle(color: Colors.white, fontSize: 20)),
                // ),
                child: Column(
                  children: [
                    /* DropdownButton(
                         // Initial Value
                         value: dropdownvalue,
                         // Down Arrow Icon
                         icon: const Icon(Icons.keyboard_arrow_down),    
                         // Array list of items
                         items: items.map((String items) {
                         return DropdownMenuItem(
                         value: items,
                         child: Text(items),
                         );
                       }).toList(),
                       // After selecting the desired option,it will
                       // change button value to selected value
                       onChanged: (String? newValue) { 
                          setState(() {
                          dropdownvalue = newValue!;
                          });
                       },
                     ),*/

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: "Shot Settings",
                          dropdownColor: Colors.grey[900],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                          items: ["Shot Settings", "Camera", "Microphone"]
                              .map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              print(newValue);
                            });
                          },
                        ),
                      ),
                    ),

                    Text(
                      'Name',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      selectedItem?.title == null ? "" : selectedItem!.title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    ),
                    Divider(
                      color: Colors.white,
                      height: 2,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text(
                      'Script (You can change script here)',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    ),

                    //  Script Box
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                      child: TextField(
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          // labelText: "Script (You can change script here)",
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),

                    Divider(
                      color: Colors.white,
                      height: 2,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text(
                      'Notes',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Text(
                          "No Notes",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w100),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(width: 30),
                        const Icon(Icons.add_circle_outline_rounded,
                            size: 25, color: Colors.white), // Custom arrow
                      ],
                    ),
                    Text(
                      'Size',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: items
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (value) {},
                          isExpanded: false,
                          value: items.first,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Equipment Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Equipment",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        //Eqipment Section
                        Row(children: [
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              initialValue: 5.toString(),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[800],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                setState(() {
                                  // equipmentList[index].quantity = int.tryParse(value) ?? 1;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Equipment Dropdown
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: "Tripod",
                                  dropdownColor: Colors.grey[900],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  items: [
                                    "Tripod",
                                    "Camera",
                                    "Microphone",
                                    "Lights"
                                  ].map((String item) {
                                    return DropdownMenuItem(
                                        value: item, child: Text(item));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      print(newValue);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 70),
                        ]),

                        SizedBox(height: 10),

                        //selection Equipment
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                initialValue: "Qty",
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[800],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  setState(() {
                                    // equipmentList[index].quantity = int.tryParse(value) ?? 1;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: "Select Euipment",
                                    dropdownColor: Colors.grey[900],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                    items: [
                                      "Select Euipment",
                                      "Camera",
                                      "Microphone"
                                    ].map((String item) {
                                      return DropdownMenuItem(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        print(newValue);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Delete Button
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {},
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
        ),
      ),
    );
  }
}

// Sample Data Model
class ListItem {
  final String image;
  final String title;
  // final String subtitle;

  // ListItem({required this.image, required this.title, required this.subtitle});
  ListItem({required this.image, required this.title});
}

class Section {
  final String headerTitle;
  final List<ListItem> items;

  Section({required this.headerTitle, required this.items});
}

// Dummy Data for Expandable List
List<Section> sections = [
  Section(
      headerTitle: "Scene 12 (Maya's Maagical journey ild stage - Night) A",
      items: [
        ListItem(
            image: "assets/magition_pic.png",
            title: "Shot 01 Maya hands wide open"),
        ListItem(
            image: "assets/hand_pic.png",
            title: "Shot 02 Hand feather close up in fire"),
        ListItem(
            image: "assets/peagion_pic.png",
            title: "Shot 03 Pigeon flying in air"),
      ]),
  Section(headerTitle: "Scene 12 A (Dark Dream)", items: [
    ListItem(
        image: "assets/hand_pic.png",
        title: "Shot 02 Hand feather close up in fire"),
    ListItem(
        image: "assets/peagion_pic.png", title: "Shot 03 Pigeon flying in air"),
  ]),
];










































































































































































































































//Approach 1: Using Row and Expanded (Horizontal Split)

/*class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      elevation: 2,
                      child: ExpansionTile(
                        title: Container(
                          height: 50, // 🔹 Set fixed height for header
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_right, size: 30, color: Colors.black54), // Custom arrow icon
                              const SizedBox(width: 8),
                              Text(
                                sections[index].headerTitle,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   sections[index].headerTitle,
                        //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        // ),
                        // leading: const Icon(Icons.arrow_drop_down, size: 30),
                        // const Icon(Icons.folder, color: Colors.blue), // Folder icon for header
                        trailing: const SizedBox.shrink(), // Removes default arrow
                        children: sections[index].items.map((item) {
                          return ListTile(
                            leading: Image(image: AssetImage(item.image)),
                            // CircleAvatar(
                            //   radius: 25,
                            //   backgroundImage: AssetImage(item.image), // Load images from assets
                            // ),
                            title: Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                            // subtitle: Text(item.subtitle),
                            onTap: () {
                              print("Tapped on ${item.title}");
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
                child: const Center(child: Text("Middle Section", style: TextStyle(color: Colors.white))),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: const Center(child: Text("Right Section", style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/



//Approach 2: Using Column and Row (Vertical + Horizontal Split)

/*class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.orange,
                child: const Center(child: Text("Top Section", style: TextStyle(color: Colors.white))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.purple,
                      child: const Center(child: Text("Left Section", style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.teal,
                      child: const Center(child: Text("Right Section", style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

//Approach 3: Using LayoutBuilder for Responsive Design
/*class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return Row(
                children: [
                  Expanded(child: Container(color: Colors.red, child: const Center(child: Text("Left")))),
                  Expanded(child: Container(color: Colors.blue, child: const Center(child: Text("Middle")))),
                  Expanded(child: Container(color: Colors.green, child: const Center(child: Text("Right")))),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(child: Container(color: Colors.red, child: const Center(child: Text("Top")))),
                  Expanded(child: Container(color: Colors.blue, child: const Center(child: Text("Middle")))),
                  Expanded(child: Container(color: Colors.green, child: const Center(child: Text("Bottom")))),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}*/