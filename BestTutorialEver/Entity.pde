class Entity {
  PVector position;
  PVector size;
  EntityType type;

  Entity(PVector position, PVector size, EntityType type) {
    this.position = position;
    this.size = size;
    this.type = type;
  }

  void show(color fill, color stroke) {
    fill(fill);
    stroke(stroke);
    show();
  }

  void show(color fill) {
    noStroke();
    fill(fill);
    show();
  }

  void show() {
    if (this.type == EntityType.RECT) { //<>//
      showRect();
    } else {
      showEllipse();
    }
  }

  void showRect() {
    rectMode(CORNER);
    rect(position.x, position.y, size.x, size.y);
  }

  void showEllipse() {
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size.x, size.y);
  }

  boolean isTouching(Entity[] otherEntities) {
    for (int i=0; i< otherEntities.length; i++) {
      if (isTouching(otherEntities[i])) {
        return true;
      }
    }
    return false;
  }

  boolean isTouching(Entity otherEntity) {
    if (type == EntityType.ELLIPSE && otherEntity.type == EntityType.ELLIPSE && size.x == size.y && otherEntity.size.x == otherEntity.size.y) {
      return isTouchingEllipse(otherEntity);
    } else {
      return otherEntity.position.x < this.position.x + this.size.x &&
        otherEntity.position.y < this.position.y+this.size.y &&
        otherEntity.position.x + otherEntity.size.x > this.position.x &&
        otherEntity.position.y + otherEntity.size.y > this.position.y;
    }
  }

  boolean isTouchingEllipse(Entity ellipseEntity) {
    return dist(position.x, position.y, ellipseEntity.position.x, ellipseEntity.position.y) < (size.x/2) + (ellipseEntity.size.x/2);
  }

  float distanceFrom(Entity otherEntity) {
    return dist(position.x, position.y, otherEntity.position.x, otherEntity.position.y);
  }

  boolean outOfBounds() {
    return position.x< size.x || position.y<100+size.y || position.x>width-size.x || position.y>height -size.y;
  }
}

enum EntityType {
  RECT, 
    ELLIPSE
}
