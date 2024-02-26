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
    // ignore: unused_local_variable
    List<String> category = ["Work", "Education", "Life", "Sport", "Others"];
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
              onChanged: (String? value) {},
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Name shouldn't be empty!";
                }
                return null;
              },
              initialValue: "",
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                labelText: "Task Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Category",
              ),
              items: category
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
                            const SizedBox(width: 5),
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
            TextFormField(
              controller: controller,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Date shouldn't be empty!";
                }
                return null;
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                labelText: "Date",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              readOnly: true,
              onTap: () {},
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
