import java.awt.event.KeyEvent; //<>// //<>//
int s;  //<>//
SudokuBoard sudoku = new SudokuBoard(); //<>// //<>// //<>// //<>//
int x = 0;
int y = 0;
boolean check = false; //<>//
//int s = int(displayHeight*.9);
void setup() {
  s = displayHeight*9/10;
  s-=(s%9)-1; //<>//
  surface.setResizable(true);
  println(s);
  surface.setSize(s,s);
  surface.setResizable(false);
  background(255);
  frameRate(20);
}
void draw() {
  sudoku.display(y, x, check);
  if (keyPressed) {
    switch(key) {
    case '1': 
      System.out.println(2);
      sudoku.placeNum(1, y, x);
      break;
    case '2': 
      sudoku.placeNum(2, y, x);
      break;
    case '3': 
      sudoku.placeNum(3, y, x);
      break;
    case '4': 
      sudoku.placeNum(4, y, x);
      break;
    case '5': 
      sudoku.placeNum(5, y, x);
      break;
    case '6': 
      sudoku.placeNum(6, y, x);
      break;
    case '7': 
      sudoku.placeNum(7, y, x);
      break;
    case '8': 
      sudoku.placeNum(8, y, x);
      break;
    case '9': 
      sudoku.placeNum(9, y, x);
      break;
    case '0': 
      sudoku.placeNum(0, y, x);
      break;
    case ' ':
      check = true;
      break;
    default:
      check = false;
    }
    switch(keyCode) {
    case UP:
      if (y>0) {
        y--;
      }
      break;
    case DOWN:
      if (y<8) {
        y++;
      }
      break;
    case RIGHT:
      if (x<8) {
        x++;
      }
      break;
    case LEFT:
      if (x>0) {
        x--;
      }
      break;
    }
  }
}
