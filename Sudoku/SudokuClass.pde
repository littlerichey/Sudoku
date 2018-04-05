import java.util.Stack; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.Arrays;
class SudokuBoard {
  boolean problem = false;
  int[][] board = new int[9][9];
  final int[][] SOLUTION;
  final int[][] START;
  // alter to change difficulty
  final int HARDNESS = 100;
  boolean solved = false;
  SudokuBoard() {
    do{
    problem = false;
    blank(); //<>// //<>//
   // view();
    randomGen(); //<>// //<>//
    checkedSolution();
   // view();
    }while(problem);/*
    for (int[] i : board) {
      for (int j : i) {
        j = 0;
      }
    }*/
   // view();
    /*
    altRandomGen();
    view();*/
    //notRandom(); //<>// //<>//
    SOLUTION = deepClone(board); //<>// //<>//
    gen(board, 0);
    //view();
    START = deepClone(board);
    //viewAny(START);
    board = deepClone(START);
  }
  void placeNum(int num, int y, int x) {
    System.out.println(3);
    //viewAny(SOLUTION);
    if (START[y][x] == 0) {
      System.out.println(1);
      board[y][x] = num;
    }
  }
  void blank(){
    for (int i = 0; i <=8; i++) {
      for ( int j = 0; j <=8; j++) {
        board[i][j] = 0;
      }
    }
  }
  void checkedSolution(){
    for (int i = 0; i <=8; i++) {
      for ( int j = 0; j <=8; j++) {
        if(board[i][j] == 0){
          problem = true;
        }
      }
    }
  }
  void randomGen(){
    for (int i = 1; i <=9; i++) {
      for ( int j = 0; j <=8; j++) {
        setSpace(i, j);
      }
    }
  }
  void altRandomGen(){
    for (int i = 0; i <=8; i++) {
      for ( int j = 0; j <=8; j++) {
        altSetSpace(i, j);
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
    //viewAny(tBoard);
    tBoard[tempRow][tempCol] = 0;
    //viewAny(tBoard);

    if (checkSolves(0, 0, tBoard, 0) > 1|| times > HARDNESS) {

      board = safeBoard;
    } else {

      gen(tBoard, times +1);
    }
  }
  /*void viewAny(int[][] tBoard) {
    for (int[] i : tBoard) {
      for (int j : i) {
        System.out.print(j);
        System.out.print(' ');
      }
      System.out.println("");
    }
    System.out.println("");
  }
  void view() {
    viewAny(board);
  }*/
  void display(int srow, int scol) {
    background(255);
    for (int i = 0; i < displayHeight; i+= 100) {
      if ((i/100)%3 == 0) {
        strokeWeight(3);
      } else {
        strokeWeight(1);
      }

      line(i, 0, i, displayHeight-1);
      line(0, i, displayWidth-1, i);
    }
    rectMode(CENTER);
    fill(255, 0, 0);
    if(!solved){
      rect(100*scol+50, 100*srow+50, 100, 100);
    }
    textSize(30);
    textAlign(CENTER, CENTER);
    int r = 0;
    int c = 0;
    fill(0);
    for (int i = 0; i <= 8; i++) {
      int x = (100*i)+50;
      for (int j = 0; j <= 8; j++) {
        int y = (100*j)+50;
        if (board[r][c]>0) {
          if (board[r][c] == START[r][c]) {
            fill(0);
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
    if(Arrays.deepEquals(board, SOLUTION)){
      solved = true;
    }
    if (solved) {
      fill(0, 255, 0);
      textSize(270);
      textAlign(CENTER, CENTER);
      text("Solved", 455, 450);
    }
  }
  void altSetSpace(int row, int col){
    int temp = int(random(1,10));
    boolean fail = true;
    if (isOption(temp, row, col, board)) {
      if (hardSpacePlaceable(temp, row, col, board)) {
        board[row][col] = temp;
        fail = false;
      }
    } else {
      for (int i=01; i <= 9; i++) {
        if (isOption(i, row, col, board)) {
          if (hardSpacePlaceable(i, row, col, board)) {
            fail = false;
            board[row][col] = i;
            i += 10;
          }
        }
      }
      if (fail) {
        System.out.println("fail at /nrow: " + row+"/ncolumn: "+ col);
       // view();
      }
    }
  }

  /*
  boolean[] spaceOptions(int y, int x) {
   boolean[] options = new boolean[9];
   for (int i = 0; i< options.length; i++) {
   options[i] = true;
   }
   for (int i=1; i <= options.length; i++) {
   for (int j=0; j < board.length; j++) {
   if (board[j][x] == i) {
   options[i-1] = false;
   }
   }
   for (int j=0; j < board[x].length; j++) {
   if (board[y][j] == i) {
   options[i-1] = false;
   }
   }
   }
   options = spaceOpsBox(y, x, options);
   return options;
   }
   boolean[] spaceOpsBox(int y, int x, boolean[] options) {
   int boxXE = (x/3 +1)*3;
   int boxYE = (y/3 +1)*3;
   int boxXS = (x/3)*3;
   int boxYS = (y/3)*3;
   for (int op=1; op <= options.length; op++) {
   for (int i = boxXS; i < boxXE; i++) {
   for (int j = boxYS; j < boxYE; j++) {
   if (board[j][i] == op) {
   options[op-1] = false;
   }
   }
   }
   }
   return options;
   }*/
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
        //view();
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
    //viewAny(ttBoard);
    ttBoard[row][x] = num;
    //viewAny(ttBoard);
    //view();
    return numFillable(num, row+1, ttBoard);
  }
  boolean hardSpacePlaceable(int num, int row, int x, int[][] tBoard) {
    boolean yup = true;
    int[][] ttBoard = deepClone(tBoard);
    ttBoard[row][x] = num;
    for( int i = 1; i <= 9; i++){
      int trow = row;
      for(int j:ttBoard[row]){
        if(j == i){
          trow = row+1;
        }
      }
      if(!(numFillable(i, trow, ttBoard))){
        yup = false;
      }
    }
    return yup;
  }

  /*
  boolean setSpace(int x, int y, int num, int last) {
   boolean yup = false;
   if (spaceOptions(x, y)[num]) {
   System.out.println(spaceOptions(x, y)[num]);
   board[y][x] = num+1;
   yup = true;
   } else {
   if (num < 8 && last> -1) {
   if (setSpace(x, y, num+1, 1)) {
   yup = true;
   }
   }
   if (num >0 && last < 1) {
   if (setSpace(x, y, num-1, -1)) {
   yup = true;
   }
   }
   }
   return yup;
   }*/
  // I coulnd't quite figure out how to randomly generate a solved sudoku
  void notRandom() {
    board = new int[][]{
      new int[]{2, 9, 5, 7, 4, 3, 8, 6, 1}, 
      new int[]{4, 3, 1, 8, 6, 5, 9, 2, 7}, 
      new int[]{8, 7, 6, 1, 9, 2, 5, 4, 3}, 
      new int[]{3, 8, 7, 4, 5, 9, 2, 1, 6}, 
      new int[]{6, 1, 2, 3, 8, 7, 4, 9, 5}, 
      new int[]{5, 4, 9, 2, 1, 6, 7, 3, 8}, 
      new int[]{7, 6, 3, 5, 2, 4, 1, 8, 9}, 
      new int[]{9, 2, 8, 6, 7, 1, 3, 5, 4}, 
      new int[]{1, 5, 4, 9, 3, 8, 6, 7, 2}       
    };
  }
  int[][] deepClone(int[][] pass ) {
    int [][] get = new int[pass.length][];
    for (int i = 0; i < pass.length; i++) {
      get[i] = pass[i].clone();
    }
    return get;
  }
}