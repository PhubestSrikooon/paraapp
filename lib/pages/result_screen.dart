import 'package:flutter/material.dart';

void queryResult(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      isScrollControlled: true,
      builder: (context) => bottomModalSheet());
}

class bottomModalSheet extends StatefulWidget {
  const bottomModalSheet({super.key});

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
            Padding(
              padding: EdgeInsets.all(8),
              child: dataColumn(),
            )
          ],
        )));
  }
}

class dataColumn extends StatefulWidget {
  const dataColumn({super.key});

  @override
  State<dataColumn> createState() => _dataColumnState();
}

class _dataColumnState extends State<dataColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "RRT406",
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          "Description",
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}
