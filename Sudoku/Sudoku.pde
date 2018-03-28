import java.util.Stack;
int nums = 0;
class SudokuBoard {
  int[][] board = new int[9][9];
  SudokuBoard() {
    for (int[] i : board) {
      for (int j : i) {
        j = 0;
      }
    }
    
    for (int i = 1; i <=9; i++) {
      for (int row=0; row < board.length; row++) {
        nums++;
        setSpace(i, row);
      }
    }
  }


  void gen() {
  }
  void view() {
    for (int[] i : board) {
      for (int j : i) {
        System.out.print(j);
        System.out.print(' ');
      }
      System.out.println("");
    }
  }/*
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
    if (isOption(num, row, temp) && board[row][temp] == 0) {
      board[row][temp] = num;
      fail = false;
    } else {
      for (int i=0; i < board[row].length; i++) {
        if (isOption(num, row, i) && board[row][i] == 0) {
          board[row][i] = num;
          i += board[row].length;
          fail = false;
        }
      }
    }
    if (fail) {
      System.out.println("fail at " + num);
      view();
    }
  }
  boolean isOption(int num, int y, int x) {
    boolean yup = true;
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

    return yup;
  }
  int checkSolves(int x, int y, int[][] rBoard){
    int solves = 0;
    if(rBoard[y][x] > 0){
      if(x<8){
        x++;
      }else{
        if(y<8){
          y++;
          x = 0;
        }else{
          return solves;
        }
      }
      checkSolves(x,y,rBoard);
    }
    for(int i = 1; i <= 9; i++{
    }    
    return solves;
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
