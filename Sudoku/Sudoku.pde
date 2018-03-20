import java.util.Stack;
class SudokuBoard{
  int[][] board = new int[9][9];
  SudokuBoard(){
    for(int[] i: board){
      for(int j: i){
        j = 0;
      }
    }
  }
  
  
  void gen(){}
  void view(){
    for(int[] i: board){
      for(int j: i){
        System.out.print(j);
        System.out.print(' ');
      }
      System.out.println("");
    }
  }
  int[] spaceOptions(int y, int x){
    int[] options = new int[]{0,0,0,0,0,0,0,0,0};
    for(int i=1; i <= options.length; i++){
      for(int j=0; i < board.length; i++){}
      
    }
    return options;
  }
}