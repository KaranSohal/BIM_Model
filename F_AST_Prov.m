function [mSteel,EffectiveCover,BottomBars,Ast_Provided_Bottom,TopBars,Ast_Provided_Top]=F_AST_Prov(YDims,d,Ast_Bottom_Required,DiaLong_Top,Ast_Top_Required,DiaLong_Bottom,Ast_Total_Required)
  index=0;
  [mSteel,nSteel]=size(Ast_Total_Required);
  Effectivecover=[]; N_Bottom=[]; Ast_provided_bottom=[];N_Top=[];Ast_provided_top=[];
  for i=1:mSteel
    index=index+1;
    N_bottom=ceil((Ast_Bottom_Required(i))/((pi/4)*DiaLong_Bottom(i)*DiaLong_Bottom(i)));
    N_top=ceil((Ast_Top_Required(i))/((pi/4)*DiaLong_Top(i)*DiaLong_Top(i)));
    if N_top<2
      n_top=2;
    else
      n_top=N_top;
    endif
    if N_bottom<2
      n_bottom=2;
    else
      n_bottom=N_bottom;
    endif  
    Effectivecover(index)=(YDims(i)-d(i));
    Ast_provided_top(index)=(n_top)*(pi/4)*(DiaLong_Top(i)*DiaLong_Top(i));
    Ast_provided_bottom(index)=(n_bottom)*(pi/4)*(DiaLong_Bottom(i)*DiaLong_Bottom(i));
    N_Top(index)=n_top;
    N_Bottom(index)=n_bottom;
  endfor
  EffectiveCover=[reshape(Effectivecover,[],1)];
  BottomBars=[reshape(N_Bottom,[],1)];
  Ast_Provided_Bottom=[reshape(Ast_provided_bottom,[],1)];
  TopBars=[reshape(N_Top,[],1)];
  Ast_Provided_Top=[reshape(Ast_provided_top,[],1)];
endfunction