import java.util.Stack;
class SudokuBoard {
  int[][] board = new int[9][9];
  SudokuBoard() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if (!(setSpace(i, j, int(random(0, 9)), 0))) {
          System.out.println("fail");
          j = 10;
          i = 10;
        }
        view();
        
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
  }
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
      for (int j=0; j < board.length; j++) {
        if (board[x][j] == i) {
          options[i-1] = false;
        }
      }
    }
    spaceOpsBox(y, x, options);
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
  }
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
  }
}