class Mediaquery {
  double mediaHeight;
  double mediaWidth;
  Mediaquery({required this.mediaHeight, required this.mediaWidth});
  double getHeight(double value) {
    return (value / 856.7272727272727) * mediaHeight;
  }

  double getWidht(double value) {
    return (value / 392.72727272727275) * mediaWidth;
  }
}
