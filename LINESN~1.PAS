uses graph,crt;
type ballpresence = array [0..8,0..8] of boolean;
type colors = array [0..8,0..8] of integer;
type matmenu = array [0..2] of string[10];
var
   ci,cj,l,l1,l2,ui,uj,popx,popy,zi,i,j,d,k,colnum,score,x,y,mc,colldp,colbuf,u,pop,
   bufx,bufy,mc1,bufi,k1,bufj,buttonhit,bufcol,ColTry:integer;
   t: ballpresence;  elementcolor,cmat:colors;
   c,ch,ch1:char;
   p,p1:pointer;
   size:word;
   k2,checking: boolean;
   tox: string;  mi,mk,z:byte;

const
     ball : array[0..8] of integer = (71,113,155,197,239,281,323,365,407);
      menu: matmenu = ('PLAY','RULES','EXIT');



{<<<<<<<<<<<<<<<<<Splash Screen>>>>>>>>>>>>>>>>>>>>>>>}
Procedure Splash(var mk:byte);
Begin
     {Letter L}
     setcolor(14);
     setfillstyle(1,14);
     fillellipse(70,150,20,20);
     for zi:= 150 to 290 do begin
     bar(60,150,80,zi);
     delay(10); end;
     fillellipse(70,290,20,20);
     for zi:= 70 to 140 do begin
     bar(70,280,zi,300);
     delay(10); end;
     fillellipse(140,290,20,20);
     {End of letter L}
     {Letter I}
     setcolor(9);
     setfillstyle(1,9);
     fillellipse(190,150,20,20);
     for zi:= 150 to 290 do begin
     bar(180,150,200,zi); delay(10); end;
     fillellipse(190,290,20,20);
     {End of letter I}
     {Letter N}
     setcolor(12);
     setfillstyle(1,12);
     fillellipse(240,290,20,20);
     for zi:= 290 downto 150 do begin
     bar(230,290,250,zi); delay(10); end;
     fillellipse(240,150,20,20);
     line(230,150,250,150);
     for zi:= 230 to 300 do begin
     line(230,150,zi,(2*zi)-310);         delay(10);
     line(250,150,zi+20,(2*(zi+20))-350); delay(10); end;
     line(300,290,320,290);
     floodfill(270,220,12);
     fillellipse(310,290,20,20);
     for zi:=290 downto 150 do begin
     bar(300,290,320,zi);  delay(10); end;
     fillellipse(310,150,20,20);
     {End ofletter N}
     {Letter E}
     setcolor(10);
     setfillstyle(1,10);
     fillellipse(420,150,20,20);
     for zi:= 420 downto 340 do begin
     bar(420,140,zi,160); delay(10); end;
     for zi:= 150 to 230 do begin
     bar(340,150,360,zi); delay(10); end;
     for zi:= 340 to 420 do begin
     bar(340,210,zi,230); delay(10); end;
     for zi:= 230 to 300 do begin
     bar(340,230,360,zi); delay(10); end;
     for zi:= 360 to 420 do begin
     bar(360,300,zi,280); delay(10); end;
     fillellipse(420,290,20,20);
     {End of letter E}
     {Letter S}
     setcolor(13);
     setfillstyle(1,13);
     fillellipse(470,290,20,20);
     for zi:= 470 to 560 do begin
     bar(470,300,zi,280); delay(10); end;
     for zi:= 280 downto 210 do begin
     bar(560,280,540,zi); delay(10); end;
     for zi:= 540 downto 470 do begin
     bar(540,210,zi,230); delay(10); end;
     for zi:= 230 downto 140 do begin
     bar(470,230,490,zi);  delay(10); end;
     for zi:= 470 to 560 do begin
     bar(470,160,zi,140); delay(10); end;
     fillellipse(550,150,20,20);
     {End of letter S}
      setcolor(15);
      settextstyle(6,0,6);
      outtextxy(220,325,'PLAY');
      outtextxy(220,370,'RULES');
      outtextxy(220,415,'EXIT');
      y:=325;
      mk:=0;
      repeat
       ch:=readkey;
       setcolor(15);
       outtextxy(220,325,'PLAY');
       outtextxy(220,370,'RULES');
       outtextxy(220,415,'EXIT');
       setcolor(12);
         case ch of
          #72: if y>325 then begin y:=y-45; mk:=mk-1; end else begin y:=415; mk:=2; end;
          #80: if y<415 then begin y:=y+45; mk:=mk+1; end else begin y:=325; mk:=0; end;
         end;
      outtextxy(220,y,menu[mk]);
     until ch=#13;
End;


{<<<<<<<<<<<<<<<<<<< DRAWING THE PLAYGROUND>>>>>>>>>>>>>>>>>}
Procedure Setka;
           Begin
            i:=92;
            repeat
              line(i,50,i,428);
              line(50,i,428,i);
              i:=i+42;
            until (i>428);
         setlinestyle(0,0,1);
         rectangle(50,50,428,428);
         Rectangle(455,50,614,429);
         setcolor(14); settextstyle(6,0,6);
         outtextxy(470,60,'L');
         setcolor(9); outtextxy(500,60,'I');
         setcolor(12); outtextxy(510,60,'N');
         setcolor(10); outtextxy(540,60,'E');
         setcolor(13); outtextxy(570,60,'S');
         setcolor(15);
         settextstyle(6,0,1);
         Outtextxy(480,210,'Use keyboard ');
         Outtextxy(480,230,'to move balls!!!');
         outtextxy(470,342,'TAKE: <Enter>');
         outtextxy(470,382,'EXIT:  <Esc>');
         outtextxy(470,362,'UNTAKE: <Alt+Z>');
         settextstyle(0,0,1);
         rectangle(519,263,549,293);
         rectangle(519,298,549,328);
         rectangle(484,298,514,328);
         rectangle(554,298,584,328);
         outtextxy(531,278,'');
         outtextxy(531,313,'');
         outtextxy(499,310,'');
         outtextxy(569,310,'');
        end;


{<<<<<<<<<<<<<<<<<<< YEREQ XARY GUND GCELU PROCEDURA>>>>>>>>>>>>>>>>>}
      Procedure RandomBalls;
        Begin
       d:=random(6);
        Case d of
        0: begin setfillstyle(1,14); setcolor(14); colnum:=14; end;
        1: begin setfillstyle(1,12); setcolor(12); colnum:=12; end;
        2: begin setfillstyle(1,9);  setcolor(9);  colnum:=9;  end;
        3: begin setfillstyle(1,10); setcolor(10); colnum:=10; end;
        4: begin setfillstyle(1,13); setcolor(13); colnum:=13; end;
        5: begin setfillstyle(1,7);  setcolor(7);  colnum:=7;  end; end;
   repeat
    i:=random(9);
    j:=random(9);
   until not t[i,j] ;
   fillellipse(ball[i],ball[j],10,10);
   t[i,j]:=true;
   ElementColor[i,j]:=colnum;
   End;


{<<<<<<<<<<<<<<<<<<<<PROCEDURE CHANGIN X YS TO I JS>>>>>>>>>>>>>>>}
Procedure MATRIX;
 Begin
  case x of
  55:  i:=0;
  97:  i:=1;
  139: i:=2;
  181: i:=3;
  223: i:=4;
  265: i:=5;
  307: i:=6;
  349: i:=7;
  391: i:=8; end;
   case y of
  55:  j:=0;
  97:  j:=1;
  139: j:=2;
  181: j:=3;
  223: j:=4;
  265: j:=5;
  307: j:=6;
  349: j:=7;
  391: j:=8; end;
 end;

 Procedure Unmatrix;
 Begin
 case ui of
 0: popx:=55;
 1: popx:=97;
 2: popx:=139;
 3: popx:=181;
 4: popx:=223;
 5: popx:=265;
 6: popx:=307;
 7: popx:=349;
 8: popx:=391;
 end;
 case uj of
 0: popy:=55;
 1: popy:=97;
 2: popy:=139;
 3: popy:=181;
 4: popy:=223;
 5: popy:=265;
 6: popy:=307;
 7: popy:=349;
 8: popy:=391;
 End;
end;

{<<<<<<<<<<<<<Achokner hashvelu yev artacelu>>>>>>>>>>>>>>>>>>}
 Procedure ScoreCount;
 Begin
 case colldp of
 4: score:=score+8;
 5: score:=score+10;
 6: score:=score+12;
 7: score:=score+14;
 8: score:=score+16;
 End;
 str(score,tox);
 tox:='Score: ' + tox ;
 setfillstyle(1,black);
 bar(470,145,600,215);
 setcolor(white);
 settextstyle(6,0,2);
 outtextxy(470,145,tox);
 end;


{<<<<<<<<<<<<<<<SHARQERY JNJELU PROCEDURE>>>>>>>>>>>>>>>>>>>}
function LineDel :boolean;
Begin

   pop:=0;
{<<<<<--------UXXADZIQ SHARQERI JNJUM--------->>>>>}
   linedel:=true;
   for i:= 0 to 8 do
   begin
    colldp:=0;
    bufcol:=0;
    for j:= 0 to 8 do
     begin
      if (t[i,j]) and (bufcol=elementcolor[i,j])
      then
      colldp:=colldp+1
      else
       if t[i,j] then
          begin
           colldp:=0;
           bufcol:=elementcolor[i,j];
          end  else
          begin  bufcol:=0; colldp:=0; end;
      if colldp>=4 then
       begin
       scorecount;
       for uj:= j-colldp to j do
        begin
        getimage(1,1,35,35,p^);
        t[i,uj]:=false;  ui:=i;
        unmatrix;
        putimage(popx,popy,p^,0)
        end;
       pop:=pop+1;
       end;
       if pop<>0 then linedel:=true else linedel:=false;
     end;
     scorecount;
     end;

{<<<<---------HORIZONAKAN SHARQERI JNJUM--------->>>>>}
   for j:= 0 to 8 do
   begin
    colldp:=0;
    bufcol:=0;
    for i:= 0 to 8 do
     begin
      if (t[i,j]) and (bufcol=elementcolor[i,j])
      then
      begin
      colldp:=colldp+1
      end
      else
       if t[i,j] then
          begin
           colldp:=0;
           bufcol:=elementcolor[i,j];
          end else
          begin  bufcol:=0; colldp:=0; end;
      if colldp>=4 then
       begin
       scorecount;
       for ui:= i-colldp to i do
        begin
        getimage(1,1,35,35,p^);
        t[ui,j]:=false; uj:=j;
        unmatrix;
        putimage(popx,popy,p^,0);
        end;
       pop:=pop+1;
       end;
       if pop<>0 then linedel:=true else linedel:=false;
     end;
     end;
     scorecount;
End;


{<<<<<<<<<<<<<<<<<<<<Way checking algorithm>>>>>>>>>>>>>>}
Function Check:Boolean;
Begin
l:=1; l1:=0;
for ci:= 0 to 8 do
 for cj:= 0 to 8 do
  if t[ci,cj] then cmat[ci,cj]:=-1 else cmat[ci,cj]:=0;
  cmat[bufi,bufj]:=-2;
  cmat[i,j]:=-3;
  if (bufi>0) and (cmat[bufi-1,bufj]=0) then cmat[bufi-1,bufj]:=l ;
  if (bufj>0) and (cmat[bufi,bufj-1]=0) then cmat[bufi,bufj-1]:=l ;
  if (bufi<8) and (cmat[bufi+1,bufj]=0) then cmat[bufi+1,bufj]:=l ;
  if (bufj<8) and (cmat[bufi,bufj+1]=0) then cmat[bufi,bufj+1]:=l ;
  repeat

  for ci:= 0 to 8 do
  begin
   for cj:= 0 to 8 do
   begin
    if cmat[ci,cj]=l then begin
    if (ci>0) and ((cmat[ci-1,cj]=0) or( cmat[ci-1,cj]=-3)) then cmat[ci-1,cj]:=l+1;
    if (cj>0) and ((cmat[ci,cj-1]=0) or (cmat[ci,cj-1]=-3)) then cmat[ci,cj-1]:=l+1;
    if (ci<8) and ((cmat[ci+1,cj]=0) or (cmat[ci+1,cj]=-3)) then cmat[ci+1,cj]:=l+1;
    if (cj<8) and ((cmat[ci,cj+1]=0) or (cmat[ci,cj+1]=-3)) then cmat[ci,cj+1]:=l+1;
   end;                                                    end;

   end;
   inc(l);
   inc(l1);
  until (cmat[i,j]<>-3)
  or (l1 >= 81);
  if (cmat[i,j]<>-3) or  ((bufi=i) and ((j=bufj+1) or (j=bufj-1)))
   or ((bufj=j) and ((i=bufi+1) or (i=bufi-1))) then check:=true else
   check:=false;
end;




{<<<<<<<<<<<<<<<<<<<<<<GAME OVER SCREEN>>>>>>>>>>>>>>>>>>>>}
Function GameOver: Boolean;
Begin
 l2 :=0;
 for i:= 0 to 8 do
  for j:= 0 to 8 do
   if t[i,j] then inc(l2) ;
   if l2 = 81 then
   begin
   cleardevice;
   settextstyle(6,0,6);
   setcolor(12);
   setcolor(14);
settextstyle(3,0,9);
Outtextxy(65,149,'G');
setcolor(9);
outtextxy(125,149,'A');
setcolor(12);
outtextxy(185,149,'M');
setcolor(10);
outtextxy(245,149,'E');
setcolor(9);
outtextxy(325,149,'O');
setcolor(13);
outtextxy(385,149,'V');
setcolor(14);
outtextxy(445,149,'E');
setcolor(10);
outtextxy(505,149,'R');
setcolor(8);
settextstyle(6,0,3);
outtextxy(230,289,'<Press any key>');
                       readln;

   GameOver := true;
  end else GameOver := false;
End;

{<<<<<<<<<<<<<<SHARIKNERY TEXAPOXELU PROCEDURE>>>>>>>>>>}
 Procedure Move;
 Begin
  x:=55;
  y:=55;
  i:=1;
  j:=1;
  size:= imagesize(50,50,90,90);
          getmem(P,size);
          repeat
           c:=ReadKey;
            PutImage(x,y,p^,0);
   case c of
      #75: if x>96  then  x:=x-42;
      #77: if x<365 then  x:=x+42;
      #72: if y>96  then  y:=y-42;
      #80: if y<365 then  y:=y+42;
      #13:
          begin
          matrix;
           if (ButtonHit=0) and (t[i,j]) then
            Begin
            Bufx:=x;
            Bufy:=y;
            ButtonHit:=1;
            Bufi:=i;
            Bufj:=j;
            BufCol:=ElementColor[i,j];
            setcolor(4);
            setlinestyle(0,0,3);
            rectangle(ball[bufi]-18,ball[bufj]-18,ball[bufi]+18,ball[bufj]+18);
            end;
           if (ButtonHit=1) and
           (not t[i,j]) and (check) then
            begin
             setcolor(black);
            rectangle(ball[bufi]-18,ball[bufj]-18,ball[bufi]+18,ball[bufj]+18);
            getimage(1,1,35,35,p^);
            putimage(bufx,bufy,p^,0);
            t[Bufi,Bufj]:=false;
            ElementColor[Bufi,Bufj]:=0;
            ButtonHit:=0;
            Setcolor(BufCol);
            Setfillstyle(1,BufCol);
            Fillellipse(Ball[i],Ball[j],10,10);
            T[i,j]:=True;
            ElementColor[i,j]:=BufCol;
            k:=0;
            if (not linedel) then
            repeat
            RandomBalls;
            k:=k+1;
            until k=3;
            linedel;
            end;    end;
            #44: if buttonhit=1 then
            begin
            setcolor(black);
            rectangle(ball[bufi]-18,ball[bufj]-18,ball[bufi]+18,ball[bufj]+18);
            buttonhit:=0;
            end;         end;
            GetImage(x,y,x+7,y+7,p^);
            setcolor(7);
            settextstyle(0,0,1);
            outtextxy(x,y,'>');
      until (c=#27) or (GameOver) ;
      end;

Function PLAY: boolean;
Begin
cleardevice;
     randomize;
     setcolor(15);
     Setka;
     if (not linedel) then
     repeat
     RandomBalls;
     k:=k+1;
     until k=3;
     linedel;
     Move;
     play:=true;
End;



Procedure RULES;
Begin
cleardevice;
repeat
setcolor(12);
settextstyle(3,0,8);
outtextxy(181,10,'RULES');
settextstyle(6,0,3);
setcolor(7);
outtextxy(90,160,' This strategy game will make you think');
outtextxy(90,180,'and concentrate for hours if you accept');
outtextxy(90,200,' the challenge. The game will randomly');
outtextxy(90,220,'place three color balls on the board at');
outtextxy(90,240,' every round, you have to strategically');
outtextxy(90,260,'select one ball and move it to the most');
outtextxy(90,280,'         convenient location');
setcolor(14);
outtextxy(130,350,'<Press enter to go back to menu>');
ch:=readkey;
until ch=#13;
cleardevice;
splash(z);
 case z of
     0:  PLAY;
     1:  RULES;
     2:  exit;
end;
end;


{<<<<<<<<<<<<<<<<<<<<<<<<MAIN PROGRAM>>>>>>>>>>>>>>>>>}
Begin
     initgraph(i,j,'');
     splash(z);
     case z of
     0:  PLAY;
     1:  RULES;
     2:  exit;
     end;
End.