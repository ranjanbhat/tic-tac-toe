int[][] grid=new int[3][3];
float intelligence=1;
//0 not filled, 1 is X, -1 is O

void setup()
{
  background(0);
  stroke(255);
  size(600,600);
  for(int i=0; i<3; i++)
  for(int j=0; j<3; j++)
  grid[i][j]=0;
  
}


void drawgrid()
{
  strokeWeight(4);
  for(int x=0; x<600; x+=200)
  for(int y=0; y<600; y+=200)
  {
    fill(0);
    rect(x,y,200,200);   
    textSize(150);
    fill(255);
    
    int r=grid[x/200][y/200];
    
         if(r==-1) text("O", x+45,y+165);
    else if(r== 1) text("X", x+55,y+160);
  }
}


void mousePressed()
{
  int i,j;
  
  i=floor(mouseX/200);
  j=floor(mouseY/200);
  if(grid[i][j]==0)
  { 
    grid[i][j]=1;  
    if(!filled(grid) && evaluate(grid)==0) 
    {
      if(random(1)<intelligence) 
      smartmove(); 
      else dumbmove();
    }
  }
   
}


void draw()
{
  drawgrid();
  checkstatus(); 
}


void checkstatus()
{
  if(evaluate(grid)==10)
  {
    fill(255);
    text("You win",0,300);
  }
  else 
  if(evaluate(grid)==-10)
  {
    fill(255);
    text("You lose",0,300);
  }
  else 
  if(filled(grid)) 
  { fill(255);
    text("It's a tie",0,300);
  }
     
}


void dumbmove()
{
  int i,j;
  int loopcounter=0;
  do
  {
    loopcounter++;
    i=floor(random(3));
    j=floor(random(3));
    if(grid[i][j]==0){ grid[i][j]=-1; break;}
    if(loopcounter>50) break;
  }while(true);

}



//void smartmove()
//{
//  boolean movemade=false;
  
//  if(!movemade)
//  {
//  //row win
//    for(int i=0 ;i<3; i++)
//    {
//      int sum=0;
//      for(int j=0; j<3; j++)
//      sum+=grid[i][j];
//      if(sum==-2)
//      for(int j=0;j<3; j++) if(grid[i][j]==0) { grid[i][j]=-1; movemade=true; break;}   
//    }
//  }
  
//  if(!movemade)
//  {
//  //col win
//    for(int i=0 ;i<3; i++)
//    {
//      int sum=0;
//      for(int j=0; j<3; j++)
//      sum+=grid[j][i];
//      if(sum==-2)
//      for(int j=0;j<3; j++) if(grid[j][i]==0) { grid[j][i]=-1; movemade=true; break;}   
//    }
//  }
  
//  if(!movemade)
//  {
//  //diag win
//    if(grid[0][0]+grid[1][1]+grid[2][2]==-2)
//    {
//      for(int i=0;i<3; i++) if(grid[i][i]==0) { grid[i][i]=-1; movemade=true; break;}   
//    }
//  }
  
//  if(!movemade)
//  {
//  //anti diag win
//    if(grid[0][2]+grid[2][0]+grid[1][1]==-2)
//    {
//      for(int i=0;i<3; i++) if(grid[i][2-i]==0) { grid[i][2-i]=-1; movemade=true; break;}  
//    }
//  }
   
    
//  if(!movemade)
//  {
//    //row loss
//    for(int i=0 ;i<3; i++)
//    {
//      int sum=0;
//      for(int j=0; j<3; j++)
//      sum+=grid[i][j];
//      if(sum==2)
//      for(int j=0;j<3; j++) if(grid[i][j]==0) { grid[i][j]=-1; movemade=true; break;}   
//    }
//  }
  
//  if(!movemade)
//  {
//  //col loss
//    for(int i=0 ;i<3; i++)
//    {
//      int sum=0;
//      for(int j=0; j<3; j++)
//      sum+=grid[j][i];
//      if(sum==2)
//      for(int j=0;j<3; j++) if(grid[j][i]==0) { grid[j][i]=-1; movemade=true; break;}   
//    }
//  }  
  
//  if(!movemade)
//  {
//  //diag loss
//    if(grid[0][0]+grid[1][1]+grid[2][2]==2)
//    {
//      for(int i=0;i<3; i++) if(grid[i][i]==0) { grid[i][i]=-1; movemade=true; break;}   
//    }
//  }
  
//  if(!movemade)
//  {
//  //anti diag loss
//    if(grid[0][2]+grid[2][0]+grid[1][1]==2)
//    {
//      for(int i=0;i<3; i++) if(grid[i][2-i]==0) { grid[i][2-i]=-1; movemade=true; break;}  
//    }
//  }  
  
  
//  if(!movemade)
//  dumbmove();
//}

void smartmove()
{
  int best=-1000;
  int bestx=0,besty=0;
  for(int i=0; i<3; i++)
  {
    for(int j=0; j<3; j++)
    {
        if(grid[i][j]==0)
        {
          grid[i][j]=-1;
          int val=minmax(grid,0,false);
          grid[i][j]=0;
          
          if(val>best){ best=val; besty=i; bestx=j;}
        }
    }
  }
  grid[besty][bestx]=-1;
}


int minmax(int A[][], int depth, boolean isMax)
{
  if (depth==9) return 0;
  
  int score=evaluate(A);
  
  if(score==10)
  return score;
  
  if(score==-10)
  return score;
  
  
  //maximizer move
  if(isMax)
  {
    int best=100;
    
    for(int i=0; i<3; i++)
    {
       for(int j=0; j<3; j++)
       {
         if(A[i][j]==0)
         {
         A[i][j]=-1;
         best=max(best,minmax(A,depth+1,!isMax));
         
         A[i][j]=0;
         }
       }
    }
    return best;
  }
  
  
  else
  {
    int best=1000;
    
    for(int i=0; i<3; i++)
    {
       for(int j=0; j<3; j++)
       {
         if(A[i][j]==0) 
         {A[i][j]=1;
         best=min(best,minmax(A,depth+1,!isMax));
         
         A[i][j]=0;
         }
       }
    }
    return best;
  }
   
}



int evaluate(int grid[][])
{
  if((grid[0][0]==grid[0][1] && grid[0][1]==grid[0][2] && grid[0][0]==1) ||
     (grid[1][0]==grid[1][1] && grid[1][1]==grid[1][2] && grid[1][0]==1) ||
     (grid[2][0]==grid[2][1] && grid[2][1]==grid[2][2] && grid[2][0]==1) ||
     (grid[0][0]==grid[1][0] && grid[1][0]==grid[2][0] && grid[0][0]==1) ||
     (grid[0][1]==grid[1][1] && grid[1][1]==grid[2][1] && grid[0][1]==1) ||
     (grid[0][2]==grid[1][2] && grid[1][2]==grid[2][2] && grid[0][2]==1) ||
     (grid[0][0]==grid[1][1] && grid[1][1]==grid[2][2] && grid[0][0]==1) ||
     (grid[2][0]==grid[1][1] && grid[1][1]==grid[0][2] && grid[2][0]==1) )
     return 10;
  else 
  if((grid[0][0]==grid[0][1] && grid[0][1]==grid[0][2] && grid[0][0]==-1) ||
     (grid[1][0]==grid[1][1] && grid[1][1]==grid[1][2] && grid[1][0]==-1) ||
     (grid[2][0]==grid[2][1] && grid[2][1]==grid[2][2] && grid[2][0]==-1) ||
     (grid[0][0]==grid[1][0] && grid[1][0]==grid[2][0] && grid[0][0]==-1) ||
     (grid[0][1]==grid[1][1] && grid[1][1]==grid[2][1] && grid[0][1]==-1) ||
     (grid[0][2]==grid[1][2] && grid[1][2]==grid[2][2] && grid[0][2]==-1) ||
     (grid[0][0]==grid[1][1] && grid[1][1]==grid[2][2] && grid[0][0]==-1) ||
     (grid[2][0]==grid[1][1] && grid[1][1]==grid[0][2] && grid[2][0]==-1) )
     return -10;
  else return 0;
}



boolean filled(int grid[][])
{
  for(int i=0; i<3; i++)
  for(int j=0; j<3; j++)
  {
    if(grid[i][j]==0) return false;
  }
  return true;
}
