SudokuBoard sudoku = new SudokuBoard();
void setup(){
  sudoku.view();
  boolean[] b = sudoku.spaceOptions(1,1);
  int j = 1;
  for(boolean i:b){
    System.out.print(j);
    System.out.println(i);
    j++;
  }
}