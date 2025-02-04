import 'package:flutter/material.dart';
import 'package:flutter_image_overlap/flutter_image_overlap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webdemo_poc/uitil/color_constants.dart';
import 'package:webdemo_poc/prompt_calling.dart';
import 'dart:typed_data'; // Add this import

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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

  static List<String> shotList = ["Shot Settings", "Camera", "Microphone"];
  String shotValue = shotList[0];
  static List<String> equipmentList = [
    "Tripod",
    "Camera",
    "Microphone",
    "Lights"
  ];
  String equipmentValue = equipmentList[0];
  static List<String> equipmentListQty = [
    "Select Equipment",
    "Camera",
    "Microphone"
  ];
  String equipmentQtyValue = equipmentListQty[0];

  // Step 1: Create a TextEditingController
  final TextEditingController _promptTextController = TextEditingController();

  //Instance for prompt

  StabilityAIService serviceClass = StabilityAIService();

  Uint8List? _generatedImage;

  // bool _isLoading = false; // Track loading state

  Future<void> _generateImage() async {
    // setState(() {
    //   _isLoading = true; // Start loading
    // });
    // if (_isLoading)
    //   CircularProgressIndicator(); // Show loading indicator on the screen

    final image =
        await serviceClass.generateImageFromText(_promptTextController.text);
    setState(() {
      _generatedImage = image;
      // _isLoading = false;
      // if (!_isLoading) Image.memory(_generatedImage!);
    }); // Assign the resolved Uint8List
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Container(
          child: Column(
            children: [topStrip(), Expanded(child: screenBody())],
          ),
        ));
  }

  Widget topStrip() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: ColorConstants.greyBorderColor, width: 2))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: ColorConstants.topContainerBg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "The word of MAAYA - the time freezes in magic",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "assets/images/play_icon.svg",
                  color: ColorConstants.playIconColor,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  "assets/images/upload.svg",
                  width: 18,
                  height: 18,
                  color: ColorConstants.downloadIconColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 5, bottom: 5, right: 20),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            color: ColorConstants.playIconColor, width: 2)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Create new",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Center(
                    child: OverlappingImages(
                      images: [
                        NetworkImage(
                            'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        NetworkImage(
                            'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                      ],
                      imageRadius: 15.0,
                      overlapOffset: 10.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "+2",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  screenBody() {
    return Row(
      children: [
        Container(
          // color: Colors.grey[200],
          width: MediaQuery.of(context).size.width / 5,
          color: Colors.black,
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                      color: ColorConstants.greyBorderColor, width: 2),
                )),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Scenes",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.window_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      elevation: 2,
                      child: ExpansionTile(
                        leading: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            size: 30,
                            color: Colors.white,
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
                        childrenPadding: const EdgeInsets.all(0),
                        title: Container(
                          height: 30, // 🔹 Fixed height
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              // const Icon(Icons.arrow_right, size: 30, color: Colors.black54), // Custom arrow
                              // const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  sections[index].headerTitle,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: const SizedBox.shrink(),
                        // Removes default arrow
                        children: sections[index].items.map((item) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: selectedItem?.title == item.title
                                ? ColorConstants.greySelectionColor
                                : Colors.black,
                            child: ListTile(
                              leading: Image.asset(item.image,
                                  width: 80, height: 60, fit: BoxFit.cover),
                              title: Text(item.title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white)),
                              onTap: () {
                                setState(() {
                                  selectedItem = item; // Update selected item
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: ColorConstants.topContainerBg,
              border: Border(
                  left: BorderSide(
                      color: ColorConstants.greyBorderColor, width: 2),
                  right: BorderSide(
                      color: ColorConstants.greyBorderColor, width: 2))),
          child: selectedItem == null
              ? const Center(
                  child: Text("Select an item",
                      style: TextStyle(fontSize: 20, color: Colors.grey)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      selectedItem!.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _generatedImage != null
                        ? Image.memory(_generatedImage!,
                            width: MediaQuery.of(context).size.width / 1.75,
                            height: MediaQuery.of(context).size.height / 1.75,
                            fit: BoxFit.contain)
                        : Image.asset(selectedItem!.image,
                            width: MediaQuery.of(context).size.width / 1.75,
                            height: MediaQuery.of(context).size.height / 1.75,
                            fit: BoxFit.contain),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: ColorConstants.greyTextBoxColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.edit_outlined,
                              color: ColorConstants.greyIconColor,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                                controller: _promptTextController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Give a command to edit shot",
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0)),
                                )),
                          ),
                          Icon(
                            Icons.mic_outlined,
                            color: ColorConstants.darkBlueColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: ColorConstants.darkBlueColor,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  // Action to perform when the text is tapped
                                  print('Text tapped!');
                                  print(_promptTextController.text);
                                  // setState(() {
                                  if (_promptTextController.text.length > 0) {
                                    _generateImage();
                                  }
                                  // });
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //       content: Text('You tapped the text!')),
                                  // );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Generate",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.star_outline,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )

                              /*  const Row(
                                children: [
                                  Text(
                                    "Generate",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.star_outline,
                                    color: Colors.white,
                                  )
                                ],
                              )*/
                              ),
                        ],
                      ),
                    )
                  ],
                ),
        )),
        Container(
          width: MediaQuery.of(context).size.width / 5,
          color: ColorConstants.topContainerBg,
          // child: const Center(
          //   child: Text("Right Section", style: TextStyle(color: Colors.white, fontSize: 20)),
          // ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  decoration: BoxDecoration(
                    color: ColorConstants.greyTextBoxBgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      padding: EdgeInsets.zero,
                      value: shotValue,
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      items: shotList.map((String item) {
                        return DropdownMenuItem<String>(
                            value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          shotValue = newValue ?? "";
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: ColorConstants.greyTextColor),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        selectedItem?.title == null ? "" : selectedItem!.title,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ColorConstants.greyBorderColor,
                  height: 2,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Text(
                    'Script (You can change script here)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: ColorConstants.greyTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //  Script Box
                Container(
                  margin: const EdgeInsets.all(
                    12.0,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.greyTextBoxBgColor,
                  ),
                  child: TextField(
                    maxLines: 8,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "shot script",
                      hintStyle: const TextStyle(color: Colors.white),
                      // labelText: "Script (You can change script here)",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: ColorConstants.greyBorderColor,
                  height: 2,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                          color: ColorConstants.greyTextColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No Notes",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(width: 30),
                          Icon(Icons.add_circle_outline_rounded,
                              size: 20, color: Colors.white), // Custom arrow
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ColorConstants.greyBorderColor,
                  height: 2,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                  child: Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: ColorConstants.greyTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: ColorConstants.greyBorderColor,
                        style: BorderStyle.solid,
                        width: 2),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      items: items
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      menuWidth: 100,
                      onChanged: (value) {
                        setState(() {
                          dropdownvalue = value ?? "";
                        });
                      },
                      borderRadius: BorderRadius.circular(5),
                      isExpanded: false,
                      value: dropdownvalue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: ColorConstants.greyBorderColor,
                  height: 2,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Equipment Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Equipment",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                              color: ColorConstants.greyTextColor,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline_rounded,
                                size: 20, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      //Eqipment Section
                      Row(children: [
                        SizedBox(
                          height: 50,
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
                        // Equipment Dropdown
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: ColorConstants.greyBorderColor,
                                style: BorderStyle.solid,
                                width: 2),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: equipmentValue,
                              dropdownColor: Colors.grey[900],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              items: equipmentList.map((String item) {
                                return DropdownMenuItem(
                                    value: item, child: Text(item));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  equipmentValue = newValue ?? "";
                                });
                              },
                            ),
                          ),
                        ),
                      ]),

                      const SizedBox(height: 10),

                      //selection Equipment
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: ColorConstants.greyBorderColor,
                                      style: BorderStyle.solid,
                                      width: 2),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: equipmentQtyValue,
                                    dropdownColor: Colors.grey[900],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                    items: equipmentListQty.map((String item) {
                                      return DropdownMenuItem(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        equipmentQtyValue = newValue ?? "";
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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
