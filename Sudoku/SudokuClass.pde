import java.util.Stack; //<>// //<>// //<>//
import java.util.Arrays;
class SudokuBoard {
  int[][] board = new int[9][9];
  final int[][] SOLUTION;
  SudokuBoard() {
    for (int[] i : board) {
      for (int j : i) {
        j = 0;
      }
    }
    for (int i = 1; i <=9; i++) {
      setSpace(i, 0);
      view();
    }
    notRandom();
    SOLUTION = board.clone();
  }


  void gen() {
  }
  void viewAny(int[][] tBoard) {
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
  }
  void display() {
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
    textSize(30);
    textAlign(CENTER, CENTER);
    int r = 0;
    int c = 0;
    fill(0);
    for (int i = 0; i <= 8; i++) {
      int y = (100*i)+50;
      for (int j = 0; j <= 8; j++) {
        int x = (100*j)+50;
        if (board[r][c]>0) {
          text(board[r][c], x, y);
        }
        r++;
      }
      r=0;
      c++;
    }
    if(Arrays.deepEquals(board,SOLUTION)){
      fill(0,255,0);
      textSize(270);
      textAlign(CENTER, CENTER);
      text("Solved",455,450);
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
      if (spacePlaceable(num, row, temp, board)) {
        board[row][temp] = num;
        fail = false;
      }
    } else {
      for (int i=0; i < board[row].length; i++) {
        if (isOption(num, row, i, board)) {
          if (spacePlaceable(num, row, i, board)) {
            fail = false;
            board[row][i] = num;
            i += board[row].length;
          }
        }
      }
      if (fail) {
        System.out.println("fail at " + num);
        view();
      }
    }
  }


  boolean isOption(int num, int y, int x, int[][] iBoard) {
    int[][] tBoard = iBoard.clone();
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
    int [][] rBoard = iBoard.clone();

    if (rBoard[y][x] > 0) {
      if (x<8) {
        x++;
      } else {
        if (y<8) {
          y++;
          x = 0;
        } else {
          solves++;
        }
      }
      solves = checkSolves(x, y, rBoard, solves);
    } else {
      for (int i = 1; i <= 9; i++) {
        if (isOption(i, y, x, rBoard)) {
          int[][] trBoard = rBoard.clone();
          trBoard[y][x] = i;
          if (x<8) {
            solves = checkSolves(x+1, y, trBoard,solves);
          } else {
            if (y<8) {
              solves = checkSolves(0, y+1, trBoard,solves);
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
    int[][] tBoard = iBoard.clone();
    if (row == 0|| row == 9) {
      return true;
    } else {
      for (int i = 8; i >=0; i--) {
        if (isOption(num, row, i, tBoard)) {
          int[][] rBoard = tBoard.clone();
          rBoard[row][i] = num;
          if (numFillable(num, row+1, rBoard)) {
            return true;
          }
        }
      }
    }


    return false;
  }
  boolean spacePlaceable(int num, int row, int x, int[][] tBoard) {

    int[][] ttBoard = tBoard.clone();
    viewAny(ttBoard);
    ttBoard[row][x] = num;
    viewAny(ttBoard);
    view();
    return numFillable(num, row+1, ttBoard);
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
      new int[]{7, 6, 3, 5, 3, 4, 1, 8, 9}, 
      new int[]{9, 2, 8, 6, 7, 1, 3, 5, 4}, 
      new int[]{1, 5, 4, 9, 3, 8, 6, 7, 2}       
    };
  }
  
}
