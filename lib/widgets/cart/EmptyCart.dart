
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenzo/core/constants/AppColor.dart';

class EmptyCart extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const EmptyCart({
    super.key,
    required this.onContinueShopping,
  });

  static const Color brown = Color(0xFF6F4E37);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 155,
              width: 155,
              decoration: BoxDecoration(
                color: const Color(0xFFF0E8E0),
                borderRadius: BorderRadius.circular(80),
              ),
              child: Icon(
                CupertinoIcons.cart,
                size: 80,
                color: AppColors.brownDark,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Looks like you haven\'t added anything to your cart yet. Explore our collection and find something you love.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onContinueShopping,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brown,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
