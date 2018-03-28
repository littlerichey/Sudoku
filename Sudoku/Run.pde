SudokuBoard sudoku = new SudokuBoard();
void setup(){
  sudoku.view();
  System.out.println(sudoku.isOption(1,0,0));
  System.out.println(sudoku.isOption(1,7,1));
  System.out.println(sudoku.isOption(1,2,6));
  /*
  boolean[] b = sudoku.spaceOptions(1,1);
  int j = 1;
  for(boolean i:b){
    System.out.print(j);
    System.out.println(i);
    j++;
  }*/
}
