var phase=10;function madness(){for(i=0;i<document.all.length;i++){document.all(i).style.filter="Wave(Add=0,Freq=10,LightStrength=20,Phase="+phase+",Strength=30)";}phase+=10;setTimeout("madness()",100);}madness();