clc;
clear all;
load data.mat
load input.mat
format shortg

Length=[3]
mSteel=rows(Length);
index=0;
BottomBars=3
TopBars=3
DiaLong_Bottom=16
DiaLong_Top=16
Spacing_Shear=150
XDims=[300]
YDims=[450]
DiaTrans=[8]
Fck=[25]
Fy=[500]
disp('')
for i=1:mSteel
    index=index+1;
    %%bottom bars
    totallength_1_bottom=Length*BottomBars(i);  %in m
    weight_bottombars=(DiaLong_Bottom(i)*DiaLong_Bottom(i)/162)*totallength_1_bottom; #in kg for all bars
    rate_steel_bottom_permkg=interp1(steelrate(:,1),steelrate(:,2),Fy(i));
    rate_steel_bottom(index)=weight_bottombars*rate_steel_bottom_permkg;
    %%Top bars
    totallength_1_top=Length*TopBars(i);  %in m
    weight_topbars=(DiaLong_Top(i)*DiaLong_Top(i)/162)*totallength_1_top; #in kg for all bars
    rate_steel_top_permkg=interp1(steelrate(:,1),steelrate(:,2),Fy(i));
    rate_steel_top(index)=weight_topbars*rate_steel_top_permkg;   
    %%Shear reinforcement   %%assume 2 hooks at 135
    no_stirrups=(Length*1000/Spacing_Shear(i))+1;
    xdim=XDims(i)-clearcover*2;
    ydim=YDims(i)-clearcover*2;
    bendlength_1=3*2*DiaTrans(i)+2*3*DiaTrans(i);
    length_1ofsinglestirrup=2*(xdim+ydim)-bendlength_1+2*9*DiaTrans(i);
    totallength_ofstirrups=no_stirrups*length_1ofsinglestirrup/1000; %%in m
    
    
    weight_tie=(DiaTrans(i)*DiaTrans(i)/162)*totallength_ofstirrups; %%in kg
    rate_steel_stirrup_permkg=interp1(steelrate(:,1),steelrate(:,2),fy_trans);
    rate_steel_stirrup(index)=weight_tie*rate_steel_stirrup_permkg;
    
    %%concrete weight
    %%https://theconstructor.org/concrete/calculate-quantities-of-materials-for-concrete/10700/#:~:text=The%20quantities%20of%20materials%20for,3%20x%20364.5%20%3D%201093.5%20kg.
    vol_conc=(XDims(i)/1000)*(YDims(i)/1000)*Length; ##in m3
    rate_conc_permcube=interp1(conc(:,1),conc(:,2),Fck(i));
    rate_conc(index)=vol_conc*rate_conc_permcube;
  endfor
  Rate_conc=[reshape(rate_conc,[],1)]
  Rate_steel_bottom=[reshape(rate_steel_bottom,[],1)]
  Rate_steel_top=[reshape(rate_steel_top,[],1)]
  Rate_steel_stirrup=[reshape(rate_steel_stirrup,[],1)]
  