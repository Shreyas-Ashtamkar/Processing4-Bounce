float padding = 20;

Arena gameBoard;
Ball  ball;

void setup(){
  size(900, 900);
  
  gameBoard = new Arena(width, height, padding);
  ball = new Ball(60, padding+70, padding+70, 1, 2);
}

void draw(){
  gameBoard.draw();
  ball.draw();
}
