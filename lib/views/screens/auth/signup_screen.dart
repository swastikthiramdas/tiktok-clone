import 'package:flutter/material.dart';
import 'package:tiktok/constraints.dart';
import 'package:tiktok/controllers/auth_controller.dart';

import '../../widget/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String uil =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.nicepng.com%2Fourpic%2Fu2y3a9e6t4o0a9w7_profile-picture-default-png%2F&psig=AOvVaw0l1IjQNJIuU4_yclJzaR0a&ust=1683779296271000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCIDj0en06f4CFQAAAAAdAAAAABAJ';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(uil),
                  backgroundColor: Colors.grey,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_a_photo,
                    ), onPressed: () {
                    AuthController().pickImage();
                  },
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Username',
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                isObsecure: true,
                icon: Icons.password,
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => AuthController()
                  .ReisterUser(_usernameController.text, _emailController.text, _passwordController.text , AuthController().ProfilePhoto),
              child: Container(
                width: width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
