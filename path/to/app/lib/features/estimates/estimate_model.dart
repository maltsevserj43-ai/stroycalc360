class EstimateItem {
  final String name;
  final int quantity;
  final double price;

  EstimateItem({required this.name, required this.quantity, required this.price});

  double calculateTotalCost() {
    return quantity * price;
  }
}
