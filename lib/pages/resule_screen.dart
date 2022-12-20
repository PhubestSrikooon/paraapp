import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> queryResult(BuildContext context, XFile file, dynamic body) async {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      isScrollControlled: true,
      builder: (context) => bottomModalSheet(
            imagePath: file,
            body: body,
          ));
}

class bottomModalSheet extends StatefulWidget {
  final imagePath;
  final body;
  const bottomModalSheet({super.key, this.imagePath, this.body});

  @override
  State<bottomModalSheet> createState() => _bottomModalSheetState();
}

class _bottomModalSheetState extends State<bottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                width: 64,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 35.0,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Result Found',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "Click here to scan the para.",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: dataColumn(
                imagePath: widget.imagePath,
                body: widget.body,
              ),
            ))
          ],
        )));
  }
}

class dataColumn extends StatefulWidget {
  final imagePath;
  final body;
  const dataColumn({super.key, this.imagePath, this.body});

  @override
  State<dataColumn> createState() => _dataColumnState();
}

class _dataColumnState extends State<dataColumn> {
  String? thainame;
  String? breeder;
  String? origin;
  dynamic growth;
  dynamic branch_and_leaf;
  dynamic bark;
  dynamic rubber_tapping_system;
  dynamic product;
  dynamic disease;
  dynamic conditions;
  dynamic note;

  bool isNull = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.body == null) {
      isNull = true;
    } else {
      thainame = widget.body['general']['ชื่อไทย'];
      breeder = widget.body['general']['พ่อพันธุ์ x แม่พันธุ์'];
      origin = widget.body['general']['แหล่งที่มา'];
      growth = widget.body['growth'];
      branch_and_leaf = widget.body['branch-and-leaf'];
      bark = widget.body['bark'];
      rubber_tapping_system = widget.body['rubber-tapping-system'];
      product = widget.body['product'];
      disease = widget.body['disease'];
      conditions = widget.body['conditions'];
      note = widget.body['note'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: isNull
          ? <Widget>[Text('ไม่พบข้อมูล')]
          : <Widget>[
              Text(
                thainame.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Descrption",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              // Image(image: FileImage(File(widget.imagePath.path))),
              ParagraphChip(
                title: "ชื่อไทย",
                child: Text(thainame.toString()),
              ),
              ParagraphChip(
                title: "พ่อพันธุ์ \nx\nแม่พันธุ์",
                child: Text(
                  breeder.toString(),
                ),
              ),
              ParagraphChip(
                title: "แหล่งที่มา",
                child: Text(
                  origin.toString(),
                ),
              ),
              ParagraphChip(
                title: 'การเจริญเติบโต',
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "การเจริญเติบโตก่อนเปิดกรีด",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              growth['การเจริญเติบโตก่อนเปิดกรีด'].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "การเจริญเติบโตระหว่างกรีด",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              growth['การเจริญเติบโตระหว่างกรีด'].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ความสม่ำเสมอของขนาดลำต้นทั้งแปลง",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              growth['ความสม่ำเสมอของขนาดลำต้นทั้งแปลง']
                                  .toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ]),
              ),
              ParagraphChip(
                  title: "กิ่งและก้าน",
                  child: Column(
                    children: [
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "การแตกกิ่ง",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              branch_and_leaf['การแตกกิ่ง'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "ทรงพุ่ม",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              branch_and_leaf['ทรงพุ่ม'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "ขนาดทรงพุ่ม",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              branch_and_leaf['ขนาดทรงพุ่ม'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "ความทึบของพุ่ม",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              branch_and_leaf['ความทึบของพุ่ม'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "ความเร็วในการผลัดใบ",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              branch_and_leaf['ความเร็วในการผลัดใบ'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                    ],
                  )),
              ParagraphChip(
                  title: "เปลือก",
                  child: Column(
                    children: [
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "ความหนาเปลือกเดิม",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bark['ความหนาเปลือกเดิม'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          children: [
                            // make text การแตกกิ่ง align left of container
                            Text(
                              "ความหนาเปลือกงอกใหม่",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bark['ความหนาเปลือกงอกใหม่'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ]),
                    ],
                  )),
              ParagraphChip(
                title: "ระบบกรีด",
                child: Text(rubber_tapping_system['ระบบกรีด'].toString()),
              ),
              ParagraphChip(
                title: "ผลผลิตต่อไร่",
                child: Text(product['ผลผลิตต่อไร่'].toString()),
              ),
              ParagraphChip(
                title: 'การต้านทานโรค',
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ใบร่วงไฟทอฟธอรา",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              disease["ใบร่วงไฟทอฟธอรา"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ราแป้ง",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              disease["ราแป้ง"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ใบจุดคอลเลโทตริกัม",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              disease["ใบจุดคอลเลโทตริกัม"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ใบจุดก้างปลา",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              disease["ใบจุดก้างปลา"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "เส้นดำ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              disease["เส้นดำ"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ราสีชมพู",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              disease["ราสีชมพู"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ]),
              ),
              ParagraphChip(
                title: 'ความต้านทานตามสภาพแวดล้อม',
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "อาการเปลือกแห้ง",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              conditions["อาการเปลือกแห้ง"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ความต้านทานลม",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              conditions["ความต้านทานลม"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ความลาดชันสูง",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              conditions["ความลาดชันสูง"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ความชื้นในพื้นที่",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              conditions["ความชื้นในพื้นที่"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ระดับน้ำใต้ดินสูง",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              conditions["ระดับน้ำใต้ดินสูง"].toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ]),
              ),
              ParagraphChip(
                title: "ข้อแนะนำอื่น ๆ",
                child: Text(note['ข้อแนะนำอื่น ๆ'].toString()),
              ),
            ],
    );
  }
}

class ParagraphChip extends StatelessWidget {
  final String title;
  final Widget child;
  const ParagraphChip({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.5, color: Theme.of(context).colorScheme.primary),
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(16),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Text(title.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(flex: 3, child: child),
          ]),
        ));
  }
}
