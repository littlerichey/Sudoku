import java.util.Stack; //<>// //<>// //<>// //<>//
class SudokuBoard {
  int[][] board = new int[9][9];
  SudokuBoard() {
    for (int[] i : board) {
      for (int j : i) {
        j = 0;
      }
    }
    for (int i = 1; i <=9; i++) { //<>//
      setSpace(i, 0);
      view();
    }
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
  void view(){
    viewAny(board);
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
  boolean isOption(int num, int y, int x, int[][] tBoard) {
    boolean yup = true;
    if (tBoard[y][x] == 0) {
      for (int[] i : board) {
        if (i[x]== num) {
          yup = false;
        }
      }
      for (int i : board[y]) {
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
          if (board[j][i] == num) {
            yup = false;
          }
        }
      }
    } else {
      return false;
    }

    return yup;
  }

  int checkSolves(int x, int y, int[][] rBoard) {
    int solves = 0;
    if (rBoard[y][x] > 0) {
      if (x<8) {
        x++;
      } else {
        if (y<8) {
          y++;
          x = 0;
        } else {
          return solves+1;
        }
      }
      checkSolves(x, y, rBoard);
    }
    for (int i = 1; i <= 9; i++) {
    }    
    return 0;
  }
  boolean numFillable(int num, int row, int[][]tBoard) {
    if (row == 0|| row == 9) {
      return true;
    } else {
      for (int i = 8; i >=0 ; i--) {
        if (isOption(num, row, i, tBoard)) {
          int[][] rBoard = tBoard;
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
    
    int[][] ttBoard = tBoard;
    viewAny(ttBoard);
    ttBoard[row][x] = num;
    viewAny(ttBoard);
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
}