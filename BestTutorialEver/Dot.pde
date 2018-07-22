class Dot extends Entity {
  PVector vel;
  PVector acc;
  Brain brain;

  boolean isDead = false;
  boolean reachedGoal = false;
  boolean isBest = false;//true if this dot is the best dot from the previous generation

  float fitness = 0;

  Dot() {
    super(new PVector(width/2, height- 10), new PVector(4, 4), EntityType.ELLIPSE);
    //start the dots at the bottom of the window with a no velocity or acceleration
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    brain = new Brain(1000); //new brain with 1000 instructions
  }


  //-----------------------------------------------------------------------------------------------------------------
  //draws the dot on the screen
  void showDot() {
    color dotColor;
    //if this dot is the best dot from the previous generation then draw it as a big green dot
    if (isBest) {
      dotColor = color(0, 255, 0);
    } else if (isDead) {
      dotColor = color(200, 0, 0);
    } else {//all other dots are just smaller black dots
      dotColor = color(0);
    }
    super.show(dotColor);
  }

  //----------------------------------------------------------------------------------------------------------------------
  //moves the dot according to the brains directions
  void move() {
    if (brain.hasStep()) {//if there are still directions left then set the acceleration as the next PVector in the direcitons array
      acc = brain.nextStep();
    } else {//if at the end of the directions array then the dot is isDead
      kill();
    }

    //apply the acceleration and move the dot
    vel.add(acc);
    vel.limit(5);//not too fast
    position.add(vel);
  }

  //-------------------------------------------------------------------------------------------------------------------
  //calls the move function and check for collisions and stuff
  void update(Obstacle[] obstacles) {
    if (!isDead && !reachedGoal) {
      move();
      if (outOfBounds() || isTouching(obstacles)) {//if near the edges of the window then kill it 
        kill();
      } else if (isTouching(goal)) {//if reached goal
        reachedGoal = true;
        kill();
      }
    }
  }


  //--------------------------------------------------------------------------------------------------------------------------------------
  //calculates the fitness
  void calculateFitness() {
    if (reachedGoal) {//if the dot reached the goal then the fitness is based on the amount of steps it took to get there
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {//if the dot didn't reach the goal then the fitness is based on how close it is to the goal
      float distanceFromGoal = this.distanceFrom(goal);
      fitness = 1.0/(distanceFromGoal * distanceFromGoal);
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------------------
  //clone it 
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();//babies have the same brain as their parents
    return baby;
  }

  void kill() {
    isDead = true;
    calculateFitness();
  }
}
