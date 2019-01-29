import java.util.Stack;  //<>// //<>// //<>// //<>// //<>//
import java.util.Arrays;
class SudokuBoard {
  boolean problem = false;
  int[][] board = new int[9][9];
  final int[][] SOLUTION;
  final int[][] START;
  // alter to change difficulty
  final int HARDNESS = 999999999;
  boolean solved = false;
  SudokuBoard() {
    do {
      problem = false;
      blank();
      randomGen();
      checkedSolution();
    } while (problem);
    SOLUTION = deepClone(board);
    gen(board, 0);
    START = deepClone(board);
    board = deepClone(START);
  }
  void placeNum(int num, int y, int x) {
    System.out.println(3);
    if (START[y][x] == 0) {
      System.out.println(1);
      board[y][x] = num;
    }
  }
  void blank() {
    for (int i = 0; i <=8; i++) {
      for ( int j = 0; j <=8; j++) {
        board[i][j] = 0;
      }
    }
  }
  void checkedSolution() {
    for (int i = 0; i <=8; i++) {
      for ( int j = 0; j <=8; j++) {
        if (board[i][j] == 0) {
          problem = true;
        }
      }
    }
  }
  void randomGen() {
    for (int i = 1; i <=9; i++) {
      for ( int j = 0; j <=8; j++) {
        setSpace(i, j);
      }
    }
  }
  void gen(int[][] iBoard, int times) {
    int tempRow = int(random(9));
    int tempCol = int(random(9));
    int[][] tBoard = deepClone(iBoard);
    int[][] safeBoard = deepClone(tBoard);
    while (tBoard[tempRow][tempCol] == 0) {
      tempRow = int(random(9));
      tempCol = int(random(9));
    }
    tBoard[tempRow][tempCol] = 0;
    if (checkSolves(0, 0, tBoard, 0) > 1|| times > HARDNESS) {
      board = safeBoard;
    } else {
      gen(tBoard, times +1);
    }
  }
  void display(int srow, int scol, boolean check) {
    background(255);
    rectMode(CENTER);
    fill(0, 255, 0);
    if (!solved) {
      rect((height/9)*scol+(height/18), (height/9)*srow+(height/18), (height/9), (height/9));
    }
    for (int i = 0; i < displayHeight; i+= (height/9)) {
      if ((i/(height/9))%3 == 0) {
        strokeWeight(3);
      } else {
        strokeWeight(1);
      }
      line(i, 0, i, displayHeight-1);
      line(0, i, displayWidth-1, i);
    }
    textSize(30);
    textAlign(CENTER, CENTER);
    int r = 0;
    int c = 0;
    fill(0);
    for (int i = 0; i <= 8; i++) {
      int x = ((height/9)*i)+(height/18);
      for (int j = 0; j <= 8; j++) {
        int y = ((height/9)*j)+(height/18);
        if (board[r][c]>0) {
          if (board[r][c] == START[r][c]) {
            fill(0);
          } else if (board[r][c] != SOLUTION[r][c] && check) {
            fill(255, 0, 0);
          } else {
            fill(0, 0, 255);
          }
          text(board[r][c], x, y);
        }
        r++;
      }
      r=0;
      c++;
    }
    if (Arrays.deepEquals(board, SOLUTION)) {
      solved = true;
    }
    if (solved) {
      fill(0, 255, 0);
      textSize(height/3.5);
      textAlign(CENTER, CENTER);
      text("Solved", height/2, height/2);
    }
  }
  void setSpace(int num, int row) {
    int temp = int(random(9));
    boolean fail = true;
    if (isOption(num, row, temp, board)) {
      if (softSpacePlaceable(num, row, temp, board)) {
        board[row][temp] = num;
        fail = false;
      }
    } else {
      for (int i=0; i < board[row].length; i++) {
        if (isOption(num, row, i, board)) {
          if (softSpacePlaceable(num, row, i, board)) {
            fail = false;
            board[row][i] = num;
            i += board[row].length;
          }
        }
      }
      if (fail) {
        problem = true;
        System.out.println("fail at " + num);
      }
    }
  }
  boolean isOption(int num, int y, int x, int[][] iBoard) {
    int[][] tBoard = deepClone(iBoard);
    boolean yup = true;
    if (tBoard[y][x] == 0) {
      for (int[] i : tBoard) {
        if (i[x]== num) {
          yup = false;
        }
      }
      for (int i : tBoard[y]) {
        if (i == num) {
          yup = false;
        }
      }
      int boxXE = (x/3 +1)*3;
      int boxYE = (y/3 +1)*3;
      int boxXS = (x/3)*3;
      int boxYS = (y/3)*3;
      for (int i = boxXS; i < boxXE; i++) {
        for (int j = boxYS; j < boxYE; j++) {
          if (tBoard[j][i] == num) {
            yup = false;
          }
        }
      }
    } else {
      return false;
    }
    return yup;
  }
  int checkSolves(int x, int y, int[][] iBoard, int solves) {
    int [][] rBoard = deepClone(iBoard);
    if (rBoard[y][x] > 0) {
      boolean run = true;
      if (x<8) {
        x++;
      } else {
        if (y<8) {
          y++;
          x = 0;
        } else {
          solves++;
          run = false;
        }
      }
      if (run) {
        solves = checkSolves(x, y, rBoard, solves);
      }
    } else {
      for (int i = 1; i <= 9; i++) {
        if (isOption(i, y, x, rBoard)) {
          int[][] trBoard = deepClone(rBoard);
          trBoard[y][x] = i;
          if (x<8) {
            solves = checkSolves(x+1, y, trBoard, solves);
          } else {
            if (y<8) {
              solves = checkSolves(0, y+1, trBoard, solves);
            } else {
              solves++;
            }
          }
        }
      }
    }
    return solves;
  }
  boolean numFillable(int num, int row, int[][]iBoard) {
    int[][] tBoard = deepClone(iBoard);
    if (row == 0|| row == 9) {
      return true;
    } else {
      for (int i = 8; i >=0; i--) {
        if (isOption(num, row, i, tBoard)) {
          int[][] rBoard = deepClone(tBoard);
          rBoard[row][i] = num;
          if (numFillable(num, row+1, rBoard)) {
            return true;
          }
        }
      }
    }
    return false;
  }
  boolean softSpacePlaceable(int num, int row, int x, int[][] tBoard) {
    int[][] ttBoard = deepClone(tBoard);
    ttBoard[row][x] = num;
    return numFillable(num, row+1, ttBoard);
  }
  int[][] deepClone(int[][] pass ) {
    int [][] get = new int[pass.length][];
    for (int i = 0; i < pass.length; i++) {
      get[i] = pass[i].clone();
    }
    return get;
  }
}
