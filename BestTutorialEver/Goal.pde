class Goal extends Entity {
  Goal(PVector position) {
    super(position, new PVector(10, 10), EntityType.ELLIPSE);
  }

  void showGoal() {
    show(color(200, 0, 0));
  }
}
