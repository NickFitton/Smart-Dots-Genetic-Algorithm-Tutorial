Population test;
Obstacle[] obstacles;
Goal goal = new Goal(new PVector(400, 110));
boolean showBestOnly = false;
int generation = 1;
int bestSteps;


void setup() {
  size(800, 900); //size of the window
  frameRate(100);//increase this to make the dots go faster
  background(255);
  textSize(20);
  drawStats();
  obstacles = new Obstacle[5];
  for (int i=0; i<obstacles.length; i++) {
    float size = random(10, 200);
    obstacles[i] = new Obstacle(new PVector(random(0, width), random(300, 600)), new PVector(size, size), EntityType.ELLIPSE);
  }
  test = new Population(1000);//create a new population with 1000 members
}


void draw() { 
  background(255);
  drawStats();

  //draw goal
  goal.showGoal();

  //draw obstacle(s)
  fill(0, 0, 255);

  for (int i=0; i<obstacles.length; i++) {
    obstacles[i].showObstacle();
  }

  if (test.allDotsDead()) {
    //genetic algorithm
    test.naturalSelection();
    test.mutateDemBabies();
  } else {
    //if any of the dots are still alive then update and then show them

    test.update();
    test.show();
  }
}

void keyPressed() {
  if (key == ' ') {
    showBestOnly = !showBestOnly;
  } else if (key == 'R' || key == 'r') {
    generation = 0;
    bestSteps = 0;
    obstacles = new Obstacle[5];
    for (int i=0; i<obstacles.length; i++) {
      float size = random(10, 200);
      obstacles[i] = new Obstacle(new PVector(random(0, width), random(300, 600)), new PVector(size, size), EntityType.ELLIPSE);
    }
    test = new Population(1000);//create a new population with 1000 members
  }
}

void drawStats() {
  fill(225);
  noStroke();
  rect(0, 0, width, 100);
  stroke(200);
  line(0, 100, width, 100);
  fill(0);
  text("Generation: " + generation, 10, 30);
  if (showBestOnly) {
    text("Showing last best dot", 10, 55);
  }
  if (bestSteps != 0) {
    text("Current shortest path: " + bestSteps, 10 + textWidth("Generation: "+generation) + 20, 30);
  }
}
