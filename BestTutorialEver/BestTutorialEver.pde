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
  obstacles = new Obstacle[1];
  obstacles[0] = new Obstacle(new PVector(0, 300), new PVector(600, 10));
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
    obstacles[0].showObstacle();
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
  }
}

void drawStats() {
  fill(225);
  noStroke();
  rect(0, 0, width, 100);
  fill(0);
  text("Generation: " + generation, 10,30);
  if (showBestOnly) {
    text("Showing last best dot", 10, 55);
  }
  if (bestSteps != 0) {
    text("Current shortest path: " + bestSteps, 10 + textWidth("Generation: "+generation) + 20, 30);
  }
}
