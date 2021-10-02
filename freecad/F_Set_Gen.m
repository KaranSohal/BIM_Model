function [xumaxbyd,beam_name,mYDims,DiaLong_Top,beam_number,Length,MuLim,XDims,YDims,Fck,Fy,DiaLong_Bottom,DiaLong_top,DiaTrans,d]= F_Set_Gen(s,length_1,h,Shut,fck_1,fy,SteelDiaLong,SteelDiaTrans,clearcover,Es);
Length=length_1(h);
  z = s{1}{h};
  z1 = strsplit(z,',');
  beam_name= z1{1,2};
  disp([("Length of Beam: ") (num2str(Length)) ("m")])
  disp([("Name of Beam: ") (num2str(beam_name))])
  
  z2=strsplit(beam_name,'B');
  beam_number= str2num(z2{1,2})
  
  index = 0;
  length_1_Beam=[]; Xdims=[]; Ydims=[]; fck_2=[];fy_1=[];DiaLong_bottom=[];Diatrans=[];DiaLong_top=[];smalld=[];Xumax_d=[];  
  XDim_Range=[Length*1000/16 Length*1000/10];
  XDim = Shut(Shut>=XDim_Range(1,1) & Shut<= XDim_Range(1,2));
  [mX,nX]=size(XDim);
  index = 0;
  for i=1:mX
    YDim_Range =[1.5*XDim(i) 2*XDim(i)];
    YDim = Shut(Shut>=YDim_Range(1,1) & Shut<= YDim_Range(1,2));
    [mY,nY]=size(YDim);
    for j=1:mY
      [mfck_1,nfck_1]=size(fck_1);
      for k=1:mfck_1
        [mfy,nfy]=size(fy);
        for l=1:mfy
          [mSDL,nSDL]=size(SteelDiaLong);
          for m=1:mSDL
            [mSDT,nSDT]=size(SteelDiaTrans); 
            for n=1:mSDT
              [mSDLc,nSDLc]=size(SteelDiaLong);
              for o=1:mSDLc
                  index=index+1;
                  length_1_Beam=length_1(h);
                  Xdims(index)=XDim(i);
                  Ydims(index)=YDim(j);
                  fck_2(index)=fck_1(k);
                  fy_1(index)=fy(l);
                  DiaLong_bottom(index)=SteelDiaLong(m);
                  Diatrans(index)=SteelDiaTrans(n);
                  DiaLong_top(index)=SteelDiaLong(o);
                  smalld(index)=(YDim(j)-clearcover-(SteelDiaLong(m)/2)-(SteelDiaTrans(n)));
                  xumax_d=((0.0035)/(0.0055+0.87*(fy(l)/Es)));
                  ru(index)=0.36*xumax_d*(1-0.416*xumax_d);
                  Xumax_d(index)=xumax_d;
                endfor           
            endfor
          endfor
        endfor
      endfor
    endfor
  endfor
  Length_Beam = [reshape(length_1_Beam,[],1)];
  XDims = [reshape(Xdims,[],1)];
  YDims = [reshape(Ydims,[],1)];
  Fck = [reshape(fck_2,[],1)];
  Fy = [reshape(fy_1,[],1)];
  DiaLong_Bottom = [reshape(DiaLong_bottom,[],1)];
  DiaLong_Top = [reshape(DiaLong_top,[],1)];
  DiaTrans = [reshape(Diatrans,[],1)];
  d = [reshape(smalld,[],1)];
  Ru = [reshape(ru,[],1)];
  xumaxbyd = [reshape(Xumax_d,[],1)];
  index=0;
  %%Design
  [mYDims,nYDims]=size(YDims);
  Mulim=[];
  for i=1:mYDims
    index=index+1;
    Mulim(index)=Ru(i)*Fck(i)*XDims(i)*d(i)*d(i)/(1000000);
  endfor
  MuLim = [reshape(Mulim,[],1)]; %kNm

endfunction