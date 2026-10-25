// cat position
float catX, catY;
float catSpeed = 5;

// falling banana arrays
int numObjects = 5;
float[] bananaX = new float[numObjects];
float[] bananaY = new float[numObjects];
float bananaSpeed = 5;

// game variables
int score = 0;
boolean gameOver = false;

void setup() {
  size(600, 800);
  catX = width / 2;
  catY = height - 50;

// initialize falling bananas
  for (int i = 0; i < numObjects; i++) {
    bananaX[i] = random(0, width - 30);
    bananaY[i] = random(-100, 0); // start off-screen
  }
}

void draw() {
  background(220, 249, 250); // light blue background
  
  if (!gameOver) {
    drawCat(catX, catY); // draw the cat
    moveCat(); // move the cat

// draw the falling bananas
    for (int i = 0; i < numObjects; i++) {
      drawBanana(bananaX[i], bananaY[i]);
      bananaY[i] += bananaSpeed;

// reset banana position when it hits the ground
      if (bananaY[i] > height) {
        bananaY[i] = random(-200, 0);
        bananaX[i] = random(0, width - 30);
        score += 1; // increase score 
      }

// check if the cat touch a banana
      if (dist(catX, catY, bananaX[i], bananaY[i]) < 50) {
        gameOver = true; // end game if cat touches banana
      }
    }

// display score
    fill(217, 222, 89);
    textSize(20);
    text("Score: " + score, 10, 30);
  } else {
// display game over
    fill(255, 0, 0);
    textSize(35);
    text("GAME OVER!", width / 2 - 100, height / 2);
    textSize(20);
    text("final score : " + score, width / 2 - 60, height / 2 + 40);
  }
}

// function to draw cat
void drawCat(float x, float y) {
  fill(252, 212, 151); // orange cat color
  ellipse(x, y, 60, 50); // cat body
  triangle(x - 30, y + 5, x - 25, y - 40, x - 5, y - 20); // left ear
  triangle(x + 30, y + 5, x + 25, y - 40, x + 5, y - 20); // right ear

  fill(0); 
  ellipse(x - 10, y - 10, 10, 10); // left eye
  ellipse(x + 10, y - 10, 10, 10); // right eye

  fill(255); // white color for eye highlights
  ellipse(x - 8, y - 12, 3, 3); // left eye tears
  ellipse(x + 12, y - 12, 3, 3); // right eye tears
}

//function to draw a banana
void drawBanana(float x, float y) {
  noStroke();
  
// banana body 
  fill(245, 243, 127); // yellow color
  beginShape();
  vertex(x, y);             
  bezierVertex(x + 50, y - 60, x + 100, y - 60, x + 100, y); // upper curve
  bezierVertex(x + 100, y - 30, x + 50, y - 30, x, y + 20); // lower curve
  endShape(CLOSE);
  
// brown tip
  fill(139, 69, 19); // brown color 
  ellipse(x + 100, y, 10, 10); 
  ellipse(x, y + 5, 10, 10); 
}

// function to move the cat
void moveCat() {
  if (keyPressed) {
    if (keyCode == LEFT && catX > 0) {
      catX -= catSpeed;
    }
    if (keyCode == RIGHT && catX < width) {
      catX += catSpeed;
    }
  }
}
