import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsShimmerLoading extends StatefulWidget {
  const LessonsShimmerLoading({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  State<LessonsShimmerLoading> createState() => _LessonsShimmerLoadingState();
}

class _LessonsShimmerLoadingState extends State<LessonsShimmerLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = _controller.value;
            return LinearGradient(
              colors: const [
                Color(0xFFE3E3E3),
                Color(0xFFF5F5F5),
                Color(0xFFE3E3E3),
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1 + slide * 3, 0),
              end: Alignment(0 + slide * 3, 0),
            ).createShader(bounds);
          },
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            itemCount: widget.itemCount,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) => const _ShimmerTile(),
          ),
        );
      },
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 12.h,
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ],
      ),
    );
  }
}
