function [TopRanked] =F_AHP(ext,ahp,mahp,nahp,Ri,n_Topranks,prefrenced_data)
  ext_UPD=ext;
  ext_UPD(:,end)=[];
  ext_UPD(:,end)=[];
  ext_UPD(:,end)=[];
  if mahp~=nahp
    disp("AHP should be square matrix")
  endif
  index=0;
  value=[];
  for i=1:mahp
    index=index+1;
    value(index)=(prod(ahp(i,:)))^(1/mahp);
  endfor  
  Value = [reshape(value,[],1)];
  ValueSum=sum(Value);
  index=0;
  priority_vector=[];
  for i=1:mahp
    index=index+1;
    priority_vector(index)=(Value(i)/ValueSum);
  endfor
  Priority_Vector = [reshape(priority_vector,[],1)];
  Check_PV = sum(Priority_Vector);
  A_3_matrix=ahp*Priority_Vector;
  index=0;
  a4=[];
  for i=1:mahp
    index=index+1;
    a4(index)=A_3_matrix(i)/Priority_Vector(i);
  endfor
  A4 = [reshape(a4,[],1)];
  Average_A4=mean(A4);
  consistancy_index=(Average_A4-mahp)/(mahp-1);
  RI=interp1(Ri(1,:),Ri(2,:),16);
  consistancy_ratio=consistancy_index/RI;
  if consistancy_ratio<=0.1
    disp(["Consistancy Within Limit(<=0.1): " num2str(consistancy_ratio)])
  elseif consistancy_ratio>0.1
    disp(["Consistancy Not Within Limit, Revise Weights in AHP(>0.1): " num2str(consistancy_ratio)])
  endif
  matrix_data=[ext_UPD(:,1) ext_UPD(:,2) ext_UPD(:,3) ext_UPD(:,4) ext_UPD(:,5) ext_UPD(:,6) ext_UPD(:,13) ext_UPD(:,14) ext_UPD(:,21) ext_UPD(:,22)];
  fprintf('\n')
  Normalized_matrix=min(matrix_data,prefrenced_data(1,:))./max(matrix_data,prefrenced_data(1,:));
  Weight_matrix=(sum((Normalized_matrix.*Priority_Vector')'(:,:)))';
  ahp_matrix=[ext_UPD Weight_matrix];
  [mahpm,nahpn]=size(ahp_matrix);
  AHP_matrix=[(1:size(ahp_matrix,1))'   sortrows(ahp_matrix,-nahpn)];
  [mAHPm,nAHPn]=size(AHP_matrix);
  index=0;
  topranked=[];
  for i=1:n_Topranks
    index=index+1;
    topranked(index,:)=AHP_matrix(i,:);
  endfor
  TopRanked=[reshape(topranked,[],nAHPn)];
myline = "Rank,Width,Depth,Fck,Fy,DiaBottom,LayersBottom,No_LB1,SpacingLB1,\
No_LB2,SpacingLB2,No_LB3,SpacingLB3,DiaTop,LayersTop,No_LT1,\
SpacingLT1,No_LT2,SpacingLT2,No_LT3,SpacingLT3,DiaStirrup,\
SpacingStirrup,Weight";
  myLine=strsplit(myline, ',');
  MyLine=myLine(~cellfun('isempty',myLine));
  TopRanked_User=TopRanked;
  idx = any(TopRanked_User)==0 ;
  TopRanked_User(:,idx)=[];
  MyLine(idx) =[] ;
  prettyprint(struct2table(cell2struct(num2cell(TopRanked_User,1),MyLine,2)));
endfunction