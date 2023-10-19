import 'package:flutter/material.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Admin Password',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const Divider(
              color: Color(0xff7c4dff),
              indent: 3,
              endIndent: 1040,
              thickness: 3,
            ),
            const SizedBox(
              height: 100,
            ),
            formField(oldPasswordController, TextInputType.number,
                'Old Password', 'Enter Old Password'),
            const SizedBox(
              height: 30,
            ),
            formField(
              oldPasswordController,
              TextInputType.number,
              'New Password',
              'Enter New Password',
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 900,
              height: 50,
              color: const Color(0xff7c4dff),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(
                      0xff7c4dff,
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Update Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  formField(TextEditingController controller, TextInputType textInputType,
      String labelname, String hint) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          label: Text(labelname), hintText: hint, border: OutlineInputBorder()),
    );
  }
}
