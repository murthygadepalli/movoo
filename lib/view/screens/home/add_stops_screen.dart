import 'package:flutter/material.dart';

class MultiStopScreen extends StatefulWidget {
  @override
  _MultiStopScreenState createState() => _MultiStopScreenState();
}

class _MultiStopScreenState extends State<MultiStopScreen> {
  final TextEditingController pickupController = TextEditingController();
  final List<TextEditingController> dropControllers = [TextEditingController()];

  void _addStop(int index) {
    if (dropControllers.length < 4) {
      setState(() {
        dropControllers.insert(index + 1, TextEditingController());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Maximum 4 stops allowed")),
      );
    }
  }

  void _removeStop(int index) {
    if (dropControllers.length > 1) {
      setState(() {
        dropControllers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Back", style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pickup
          _buildPickupField(),
          const SizedBox(height: 12),

          // Drop fields with reorderable behavior
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dropControllers.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex -= 1;
                final item = dropControllers.removeAt(oldIndex);
                dropControllers.insert(newIndex, item);
              });
            },
            itemBuilder: (context, index) {
              return _buildDropField(index, key: ValueKey(dropControllers[index]));
            },
          ),

          const SizedBox(height: 20),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.my_location, color: Colors.purple),
                label: const Text("Select on map", style: TextStyle(color: Colors.purple)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite, color: Colors.purple),
                label: const Text("Saved Addresses", style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),

          const Divider(),

          // Recent Addresses
          _buildRecentTile("372, 2nd road-Sr Nagar", "78 Spice 2nd road, Hyderabad 500034, Telangana, India."),
          _buildRecentTile("Home", "78 Spice 2nd road, Hyderabad 500034, Telangana, India.", isHome: true),
          _buildRecentTile("372, 2nd road-Sr Nagar", "78 Spice 2nd road, Hyderabad 500034, Telangana, India."),

        ],
      ),
    );
  }

  /// Pickup Field (rounded with green dot)
  /// Pickup Field (rounded with green dot outside)
  Widget _buildPickupField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Green dot outside
        const Icon(Icons.circle, color: Colors.green, size: 14),
        const SizedBox(width: 8),

        // White rounded box with shadow
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: TextField(
              controller: pickupController,
              decoration: const InputDecoration(
                hintText: "Enter Your Pickup",
                border: InputBorder.none,
                enabledBorder: InputBorder.none, // removes default enabled border
                focusedBorder: InputBorder.none, // removes border on focus
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Drop Field (rounded with numbered red dot, drag handle, X and +)
  /// Drop Field (rounded with numbered red dot, drag handle, X and + outside)
  Widget _buildDropField(int index, {required Key key}) {
    return Row(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Red numbered dot OUTSIDE container
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.red,
          child: Text(
            "${index + 1}",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),

        // White rounded container with shadow
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                // Text field
                Expanded(
                  child: TextField(
                    controller: dropControllers[index],
                    decoration: const InputDecoration(
                      hintText: "Enter Your Drop",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none, // removes default enabled border
                      focusedBorder: InputBorder.none, // removes border on focus
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),

                // Drag handle INSIDE container
                ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Cross (remove)
        if (dropControllers.length > 1)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.close, color: Colors.purple, size: 20),
              onPressed: () => _removeStop(index),
            ),
          ),

        const SizedBox(width: 8),

        // Plus (add)
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, color: Colors.purple, size: 20),
            onPressed: () => _addStop(index),
          ),
        ),
      ],
    );
  }


  Widget _buildRecentTile(String title, String subtitle, {bool isHome = false}) {
    return ListTile(
      leading: Icon(isHome ? Icons.home : Icons.access_time, color: isHome ? Colors.purple : Colors.grey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 20, color: Colors.grey),
          Text("Save", style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

}
