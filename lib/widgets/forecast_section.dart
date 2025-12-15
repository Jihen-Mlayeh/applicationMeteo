import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'forecast_card.dart';

class ForecastSection extends StatelessWidget {
  final List<ForecastData> forecasts;
  final Animation<Offset>? slideAnimation;

  const ForecastSection({
    Key? key,
    required this.forecasts,
    this.slideAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (forecasts.isEmpty) {
      return const SizedBox.shrink();
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'PRÉVISIONS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: forecasts.length,
            itemBuilder: (context, index) {
              return ForecastCard(
                forecast: forecasts[index],
                index: index,
              );
            },
          ),
        ),
      ],
    );

    return slideAnimation != null
        ? SlideTransition(
      position: slideAnimation!,
      child: content,
    )
        : content;
  }
}