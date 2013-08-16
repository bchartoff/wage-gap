import controlP5.*;
import java.util.*;

public ControlP5 cp5;
public ControlWindow cw;
public ArrayList checkboxes = new ArrayList();
public float wid = 900;
public float lmargin = 0;
public float rmargin = 90;
public float tmargin = 0;
public float bmargin = 0;
public float h = 450;
public int numBars = 1;
public color[] colors = {#038B87,#265755,#024240,#63E2DD,#A0E2E0,
#1D4599,#2F3F60,#031A49,#7297E6,#A9BDE6,
#E69F17,#8F743F,#6D4903,#F9C96D,#F9E0B0,
#E67317,#8F633F,#6D3203,#F9AB6D,#F9D0B0};
public int colori = 0;
public color activecolor;
public ArrayList bars = new ArrayList();
public float pct = 1;
public double barwid;
public boolean fixmale = true;
public ArrayList categories = new ArrayList();
public ControlFont cf;
public ArrayList cbArrayValuesList = new ArrayList();
public int barindex = 0;
public WageCategory c1;
public WageCategory c2;
public PVector PV;
public PFont mono;
public PFont mono2;
public Indicator ind;
public String cbname;
public String tabname;
public Indicator cbindicator;
public int cbcount;
public int tabcount;
//[] cbArrayValues;


void setup(){
  colori=9;
  readData("wage_data.csv");
  size((int)wid + (int)lmargin + int(rmargin), (int)h + int(tmargin)+int(bmargin));
  fill(255);
  noStroke();
  rect(lmargin,tmargin,wid/2,h);
  fill(150);
  rect(wid/2+lmargin,tmargin,wid/2,h);
  barwid = wid/2;
 
  mono = loadFont("HiraKakuPro-W6-12.vlw");
  mono2 = loadFont("AvenirNextCondensed-Medium-11.vlw");




  for(int k = 0; k < categories.size(); k++){
    WageCategory wc = (WageCategory) categories.get(k);
    ArrayList indicators = wc.getIndicators();
    for(int m = 0; m < indicators.size(); m++){
       Indicator i = (Indicator) indicators.get(m);
    }
  }
  
  for(tabcount = 0; tabcount < categories.size(); tabcount++){
    PV = new PVector(wid/2+lmargin,0,0);
    cp5.window().setPositionOfTabs(PV);
    c1 = (WageCategory) categories.get(tabcount);
    cp5.tab("default").remove();
    cp5.addTab(c1.getName())
       .setHeight(40)
       .setWidth(80)
       .setColorBackground(color(210))
       .setColorForeground(color(210))
       .setColorLabel(color(0))
       .setColorActive(color(150))
       .activateEvent(true)
       .captionLabel().toUpperCase(false);
       ;

       
       CheckBox cb = cp5.addCheckBox(""+tabcount)
                .setPosition(wid/2 + lmargin+ 20, tmargin+ 50)
                .setColorBackground(color(255))
                .setColorForeground(color(255))
                .setSize(20, 20)
                .setItemsPerRow(2)
                .setSpacingColumn(220)
                .setSpacingRow(20)
                ;
               
            
              
        ArrayList indicators = c1.getIndicators();
        for(cbcount = 0; cbcount < indicators.size(); cbcount++){
          ind = (Indicator) indicators.get(cbcount);
          cb.addItem(ind.getName(), cbcount).toUpperCase(false);
          cf.init(cb.getValueLabel());
        }

        cb.moveTo(c1.getName());
        cbArrayValuesList.add(cb.getArrayValue());
        checkboxes.add(cb);
        
     cp5.addButton("sort_all"+tabcount)
       .setValue(1)
       .setLabel("  Sort All")
       .setPosition(wid+lmargin+5,tmargin)
       .setSize((int)rmargin-10,30)
       .setColorForeground(color(255,12,12,72))
       .setColorBackground(color(255,12,12,72))
       .moveTo(c1.getName())
       .captionLabel().toUpperCase(false)
       
       ;
       
    cp5.addButton("check_all"+tabcount)
       .setValue(2)
       .setLabel(" Check All")
       .setPosition(wid+lmargin+5,tmargin+40)
       .setSize((int)rmargin-10,30)
       .setColorForeground(color(255,12,12,72))
       .setColorBackground(color(255,12,12,72))
       .moveTo(c1.getName())
       .captionLabel().toUpperCase(false)
       
       ;
       
    cp5.addButton("uncheck_all"+tabcount)
       .setValue(3)
       .setLabel("Uncheck All")
       .setPosition(wid+lmargin+5,tmargin+80)
       .setSize((int)rmargin-10,30)
       .setColorForeground(color(255,12,12,72))
       .setColorBackground(color(255,12,12,72))
       .moveTo(c1.getName())
       .captionLabel().toUpperCase(false)
       ;
               
       
       
  }
  CheckBox cb0 = (CheckBox) checkboxes.get(0);
  Tab t = cb0.getTab();
  t.setActive(true);
  cb0.activate(0);

  }


public void readData(String dataFile){
  String lines[] = loadStrings(dataFile);
  for(int i = 0; i< lines.length; i++){
    String [] temp = new String [4];
    temp= split(lines[i], ',');
    if(temp[0].length() > 0){
      WageCategory wagecategory = new WageCategory(temp[0]);
      categories.add(wagecategory);
        for(int j = i+1; j < lines.length; j++){
          temp = split(lines[j], ',');
          if(temp[1].length() == 0){
            break;
          }
          else{
            Indicator indicator = new Indicator(temp[1]);
            indicator.setMaleWage(Float.parseFloat(temp[2]));
            indicator.setFemaleWage(Float.parseFloat(temp[3]));
            wagecategory.addIndicator(indicator);
          }
        }
      }
    else{
      
    }
  }

}

public void fixMale(){
  fixmale = true;
  /* change Bar constructor to just gap
  make wid, color, startx inputs of printbar
  construct arraylist of malewages
  construct arraylist of femalewages
  construct list of bars, with male h = 1
  gap = femalewage/malewages
  */
}

public class WageCategory{
  public String name;
  public ArrayList indicators = new ArrayList();
  
  public WageCategory(String n){
    name = n;
  }
  
  public String getName(){
    return name;
  }
  
  public void addIndicator(Indicator i){
    indicators.add(i);
  }
  
  public ArrayList getIndicators(){
    return indicators;
  }
}

public class Indicator{
  public String name;
  public float maleWage;
  public float femaleWage;
  public int cbBarIndex;
  
  public Indicator(String n){
    name = n;
  }
  
  public void setBarIndex(int i){
    cbBarIndex = i;
  }
  
  public int getBarIndex(){
    return cbBarIndex;
  }
  
  public void setMaleWage(float mw){
    maleWage = mw;
  }
  
  public void setFemaleWage(float fw){
    femaleWage = fw;
  }
  
  public String getName(){
    return name;
  }
  
  public float getMaleWage(){
    return maleWage;
  }
  
  public float getFemaleWage(){
    return femaleWage;
  }
}

void draw(){
   fill(150);
   rect(wid/2+lmargin,tmargin,wid/2,h);
   printBars();
   printBox(mouseX,mouseY);
   printMargins();
   

}


public void mouseMoved(){
  printBox(mouseX,mouseY);
}


public void printBox(int x, int y){
  int boxwidth = 220;
  int boxheight = 90;
  if(x < wid/2+lmargin && x > lmargin && y > tmargin+h/2 && y < (h+tmargin)){
    smooth();
    fill(255);
    if(x > boxwidth + lmargin && y < h+tmargin-boxheight){
      rect(x-boxwidth,y,boxwidth,boxheight);
      for(int i = 0; i < bars.size(); i++){
        Bar b = (Bar)bars.get(i);
        if(mouseX > b.getStartx()+lmargin && mouseX < b.getStartx()+b.getwid()+lmargin){
          fill(0);
          text(b.getIndicator().getName() + "\n" + "Women earn " + nf((100*(b.getIndicator().getFemaleWage()/
          b.indicator.getMaleWage())),2,1) + "\n" + "cents for every dollar" + "\n" + "that men earn", x-boxwidth+10, y+20);
        }
      }
    }
    if(x < boxwidth+lmargin && y < h+tmargin-boxheight){
      rect(x,y,boxwidth,boxheight);
      for(int i = 0; i < bars.size(); i++){
        Bar b = (Bar)bars.get(i);
        if(mouseX > b.getStartx()+lmargin && mouseX < b.getStartx()+b.getwid()+lmargin){
          fill(0);
          text(b.getIndicator().getName() + "\n" + "Women earn " + nf((100*(b.getIndicator().getFemaleWage()/
          b.indicator.getMaleWage())),2,1) + "\n" + "cents for every dollar" + "\n" + "that men earn", x+10, y+20);
        }
      }
    }
    if(y > h+tmargin-boxheight && x < boxwidth+lmargin){
      rect(x,y-boxheight,boxwidth,boxheight);
      for(int i = 0; i < bars.size(); i++){
        Bar b = (Bar)bars.get(i);
        if(mouseX > b.getStartx()+lmargin && mouseX < b.getStartx()+b.getwid()+lmargin){
          fill(0);
          text(b.getIndicator().getName() + "\n" + "Women earn " + nf((100*(b.getIndicator().getFemaleWage()/
          b.indicator.getMaleWage())),2,1) + "\n" + "cents for every dollar" + "\n" + "that men earn", x+10, y-boxheight+20);
        }
      }
    }
    
    if(y > h+tmargin-boxheight && x > boxwidth+lmargin){
      rect(x-boxwidth,y-boxheight,boxwidth,boxheight);
      for(int i = 0; i < bars.size(); i++){
        Bar b = (Bar)bars.get(i);
        if(mouseX > b.getStartx()+lmargin && mouseX < b.getStartx()+b.getwid()+lmargin){
          fill(0);
          text(b.getIndicator().getName() + "\n" + "Women earn " + (int)(100*(b.getIndicator().getFemaleWage()/
          b.indicator.getMaleWage())) + "\n" + "cents for every dollar" + "\n" + "that men earn", x+10-boxwidth, y-boxheight+20);
        }
      }
    }
    
    
  }
}

public void printMargins(){
  fill(255);
  rect(0,0,wid+lmargin+rmargin,tmargin);
  rect(0,0,lmargin,h+tmargin+bmargin);
  rect(0,h+tmargin,wid+lmargin+rmargin,bmargin);
  rect(wid+lmargin,0,rmargin,h+tmargin+bmargin);
  
  fill(0);
  textFont(mono);
  text("Male Wages, fixed at One Dollar",wid/4+lmargin-100,tmargin+100);
  fill(255);
  text("Relative Female Wages",wid/4+lmargin-75,h+tmargin+bmargin-100);
  textFont(mono2);
}

public void controlEvent(ControlEvent theEvent) {
 if (theEvent.isGroup()) {   
    cbname = theEvent.getGroup().getName();
    CheckBox cb = (CheckBox) checkboxes.get(int(cbname));
    c2 = (WageCategory) categories.get(int(cbname));
    ArrayList indicators = c2.getIndicators();
    float[] cbArrayValues = (float[]) cbArrayValuesList.get(int(cbname));
    float[] tempcbArrayValues = cb.getArrayValue();
    int j = 0;
    for(int i = 0; i < tempcbArrayValues.length; i++){
      if(cbArrayValues[i] != tempcbArrayValues[i]){
        if(tempcbArrayValues[i] == 1){
          cbindicator = (Indicator) indicators.get(i);
          float gap = cbindicator.getFemaleWage()/cbindicator.getMaleWage();
          Bar b = new Bar(colors[(colori+1)%colors.length], 1-gap, barindex);
          b.setIndicator(cbindicator);
          insertBar(b);
          cbindicator.setBarIndex(barindex);
          barindex++;
          printBars();
          j = i;
          colori++;
          cbArrayValuesList.set(int(cbname), tempcbArrayValues);
          Toggle item = cb.getItem(j);
          item.setColorActive(colors[colori%colors.length]);
        }
        if(tempcbArrayValues[i] == 0){
          cbindicator = (Indicator) indicators.get(i);
          int removeindex = 0;
          for(int m = 0 ; m <bars.size(); m++){
            Bar b = (Bar) bars.get(m);
            if(b.getIndex() == cbindicator.getBarIndex()){
              removeindex = m;
            }
          }
          bars.remove(removeindex);
          barwid = (wid/2)/bars.size();
          for(int k = 0; k < bars.size(); k++){
            Bar bar = (Bar) bars.get(k);
            bar.setwid(barwid);
            bar.setStartx(barwid*k);
          }
          printBars();
          j = i;
          cbArrayValuesList.set(int(cbname), tempcbArrayValues);
          Toggle item = cb.getItem(j);
        }

      }
    }

    
   

    
    if (theEvent.isTab()) {
    tabname = theEvent.getTab().getName();
    if (tabname.equals("extra")) {
    }
    else{
      fill(150);
      rect(wid/2+lmargin,0+tmargin,wid/2,h);
    }
  }
  
  if (theEvent.isController()){
    if(theEvent.getController().getValue() == 1){
      sortBars();
      refreshBars();
      printBars();
    }
    
    if(theEvent.getController().getValue() == 2){
      for(int n = 0; n < checkboxes.size(); n++){
        CheckBox cb = (CheckBox) checkboxes.get(n);
        cb.activateAll();
      }
    }
    if(theEvent.getController().getValue() == 3){
      for(int n = 0; n < checkboxes.size(); n++){
        CheckBox cb = (CheckBox) checkboxes.get(n);
        cb.deactivateAll();
      }
    }


  }
  
}


public class Bar{
  public color col; public double startx; public double wide; float gap;
  int index;
  Indicator indicator;
  
  public Bar(color c, float g, int i){
    index = i;
    col = c;
    gap = g;
  }
  
  public int getIndex(){
    return index;
  }
  public void setwid(double w){
     wide = w;
  }
  
  public void setIndicator(Indicator i){
    indicator = i;
  }
  
  public Indicator getIndicator(){
    return indicator;
  }
  
  public void setStartx(double sx){
    startx = sx;
  }
  
  public float getGap(){
    return gap;
  }
  
  public double getwid(){
    return wide;
  }
  
  public double getStartx(){
    return startx;
  }
  
  public void printBar(){
    fill(col, 60);
    noStroke();
    rect((float)startx+lmargin, tmargin, (float)wide, h/2);
    fill(0);
    float cents = gap*100;
    if(bars.size() <= 11){
      text(nf(cents,1,1) + " cents",(float)startx+lmargin+2, (h/2)*(1+gap)+tmargin);
    }
    else{
      text(nf(cents,1,1),(float)startx+lmargin+2, (h/2)*(1+gap)+tmargin);
    }
    fill(col);
    rect((float)startx+lmargin,(h/2)*(1+gap)+tmargin,(float)wide,(1-gap)*h/2);
  }
  
}

public void printBars(){
  fill(255);
  noStroke();
  rect(lmargin,tmargin,wid/2,h);
  
  for (int i = 0; i < bars.size(); i++){
    Bar b = (Bar) bars.get(i);
    b.printBar();
  }
}

public void insertBar(Bar b){
  bars.add(b);
  barwid = (wid/2)/bars.size();
  for(int i = 0; i < bars.size(); i++){
    Bar bar = (Bar) bars.get(i);
    bar.setwid(barwid);
    bar.setStartx(barwid*i);
  }
}

public void refreshBars(){
  barwid = (wid/2)/bars.size();
  for(int i = 0; i < bars.size(); i++){
    Bar bar = (Bar) bars.get(i);
    bar.setwid(barwid);
    bar.setStartx(barwid*i);
  }
}

  
public void sortBars(){
  if(bars.size()>0){
    List gaps = new ArrayList();
    for(int i = 0; i < bars.size(); i++){
      Bar b = (Bar)bars.get(i);
      gaps.add(new Gap(b.getGap(), i));
    }
    Collections.sort(gaps);
    ArrayList newBars = new ArrayList();
    for(int i = 0; i < bars.size(); i++){
      Gap g = (Gap) gaps.get(i);
      Bar newBar = (Bar) bars.get(g.getIndex());
      newBars.add(newBar);
    }
   bars.clear();
   bars = newBars;
   Bar b = (Bar) bars.get(0);
  }
}
    
  
public class Gap implements Comparable<Gap>{
  public float gap; public int index;
  public Gap(float g, int i){
    gap =g;
    index = i;
  }
  
  public int getIndex(){
    return index;
  }
  
  public int compareTo(Gap g){
    if(this.gap == g.gap){
      return 0;
    }
    if (this.gap > g.gap){
      return 1;
    }
    else{
      return -1;
    }
  }
  
}
