class Obstacle extends Entity {
  Obstacle(PVector position, PVector size) {
    super(position, size, EntityType.RECT);
  }
  
  Obstacle(PVector position, PVector size, EntityType type) {
    super(position, size, type);
  }
  
  void showObstacle() {
    show(color(0,0,200), color(0));
  }
}
