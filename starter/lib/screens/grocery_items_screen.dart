import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../components/grocery_tile.dart';
import '../fooderlich_theme.dart';
import '../models/grocery_item.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  // 1
  final Function(GroceryItem) onCreate;
  // 2
  final Function(GroceryItem) onUpdate;
  // 3
  final GroceryItem? originalItem;
  // 4
  final bool isUpdating;

  const GroceryItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  }) : isUpdating = (originalItem != null);

  @override
  GroceryItemScreenState createState() => GroceryItemScreenState();
}

class GroceryItemScreenState extends State<GroceryItemScreen> {
  // TODO: Add grocery item screen state properties
  String name = '';
  Importance importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  final _nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final originalItem = widget.originalItem;
    if (originalItem != null) {
      name = originalItem.name;
      importance = originalItem.importance;
      _dueDate = originalItem.date;
      _currentColor = originalItem.color;
      _timeOfDay = TimeOfDay.fromDateTime(originalItem.date);
      _currentSliderValue = originalItem.quantity;

      _nameController.text = originalItem.name;
    }

    _nameController.addListener(() {
      name = _nameController.text;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add GroceryItemScreen Scaffold
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final groceryItem = GroceryItem(
                  id: widget.originalItem?.id ?? Uuid().v1(),
                  name: name,
                  importance: importance,
                  color: _currentColor,
                  quantity: _currentSliderValue,
                  date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                      _timeOfDay.hour, _timeOfDay.minute),
                );
                if (widget.isUpdating) {
                  widget.onUpdate(groceryItem);
                  Navigator.pop(context);
                } else {
                  widget.onCreate(groceryItem);
                }
              },
              icon: Icon(Icons.check)),
        ],
        title: Text(
          'GroceryItem',
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontFamily: GoogleFonts.lemon().fontFamily,
              fontWeight: FontWeight.w200),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildNameField(),
          buildImportanceField(),
          buildDateField(),
          buildColorPicker(),
          buildQuantityField(),
          GroceryTile(
            groceryItem: GroceryItem(
              id: 'asd',
              name: name,
              importance: importance,
              color: _currentColor,
              quantity: _currentSliderValue,
              date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                  _timeOfDay.hour, _timeOfDay.minute),
            ),
          )
        ],
      ),
    );
  }

// TODO: Add buildNameField()
  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: Theme.of(context).textTheme.headline2,
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            hintText: 'input',
          ),
        ),
      ],
    );
  }

// TODO: Add buildImportanceField()
  Widget buildImportanceField() {
    const textStyle = TextStyle(color: Colors.white);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: Theme.of(context).textTheme.headline2,
        ),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text('row', style: textStyle),
              selected: importance == Importance.low,
              onSelected: (v) {
                setState(() {
                  importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text('medium', style: textStyle),
              selected: importance == Importance.medium,
              onSelected: (v) {
                setState(() {
                  importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text('high', style: textStyle),
              selected: importance == Importance.high,
              onSelected: (v) {
                setState(() {
                  importance = Importance.high;
                });
              },
            ),
          ],
        )
      ],
    );
  }

// TODO: ADD buildDateField()
// TODO: Add buildTimeField()
  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.headline2,
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final dateSeleted = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                if (dateSeleted != null) {
                  setState(() {
                    _dueDate = dateSeleted;
                  });
                }
              },
              child: Text(
                'select',
                style: TextStyle(color: _currentColor),
              ),
            ),
          ],
        ),
        Text(
          DateFormat('yyyy-MM-dd').format(_dueDate),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time Of Day',
              style: Theme.of(context).textTheme.headline2,
            ),
            TextButton(
              onPressed: () async {
                final timeSeleted = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                if (timeSeleted != null) {
                  setState(() {
                    _timeOfDay = timeSeleted;
                  });
                }
              },
              child: Text(
                'select',
                style: TextStyle(color: _currentColor),
              ),
            ),
          ],
        ),
        Text(_timeOfDay.format(context))
      ],
    );
  }

// TODO: Add buildColorPicker()
  Widget buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 10,
          height: 50,
          color: _currentColor,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            'Color',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: BlockPicker(
                      pickerColor: Colors.white,
                      onColorChanged: (color) {
                        _currentColor = color;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Text('Save'),
                      )
                    ],
                  );
                });
          },
          child: Text(
            'select',
            style: TextStyle(color: _currentColor),
          ),
        )
      ],
    );
  }

// TODO: Add buildQuantityField()
  Widget buildQuantityField() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Quantity',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              _currentSliderValue.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
        Slider(
          value: _currentSliderValue.toDouble(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: _currentSliderValue.toString(),
          activeColor: _currentColor,
          inactiveColor: _currentColor.withOpacity(0.5),
        )
      ],
    );
  }
}
