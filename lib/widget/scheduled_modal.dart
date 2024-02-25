import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    List<String> _category = ["Work", "Education", "Life", "Sport", "Others"];
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: Text(
        "Create Task",
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 196, 124))),
      ),
      backgroundColor: Colors.grey[200],
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Task Name",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Task Name shouldn't be empty!";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Task Description",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Task Description shouldn't be empty!";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Category",
              ),
              items: _category
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            switch (e) {
                              "Sport" => const Icon(Icons.sports),
                              "Work" => const Icon(Icons.work),
                              "Education" => const Icon(Icons.school),
                              "Life" => const Icon(Icons.home),
                              "Others" => const Icon(Icons.more_horiz),
                              _ => const Icon(Icons.more_horiz),
                            },
                            SizedBox(width: 5),
                            Text(e),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (value) {},
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Category shouldn't be empty!";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      onSave();
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 2, 196, 124),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: GoogleFonts.robotoSlab(
                          textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.robotoSlab(
                          textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
