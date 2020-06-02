// https://www.keyence.co.jp/downloads/?mode=tg&o=0&group_id=tcm%3A106-1619397&type_id=&webseries_id=
// 21 * 21のセルを持つQRコードを生成する
// バージョン1, QRコードモデル2, 誤り訂正レベルH
// 英数字モード(データの種類は英数字のみ(小文字大文字の区別なし))



int cellSize = 20;
// QRコードで表現するデータ(英数字文字列)
String data = "ABCDE123";

int dataLength = data.length();


int[] code1 = {0,0,1,0}; // モード指示子, 英数字モードは0010
int[] code2 = {0,0,0,0,0,0,0,0,0}; // dataの文字数を9bitで表記, 値はsetup内で設定
int[] code3 = new int[100];
int[] code4 = {0,0,0,0}; // 終端パターン, データビット列がシンボル容量を満たしている場合は含まない(?)

int[] resultCode = new int[72];






// 0白, 1黒, 2黄(データ部分), 3水(誤り訂正レベル, マスクパターン)
// 2と3は適切に0か1に変更する, 実行時に黄, 水が表示されたらうまくいっていない

int[][] cell = {
  {1,1,1,1,1,1,1,0,3,2,2,2,2,0,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,1,0,3,2,2,2,2,0,1,0,0,0,0,0,1},
  {1,0,1,1,1,0,1,0,3,2,2,2,2,0,1,0,1,1,1,0,1},
  {1,0,1,1,1,0,1,0,3,2,2,2,2,0,1,0,1,1,1,0,1},
  {1,0,1,1,1,0,1,0,3,2,2,2,2,0,1,0,1,1,1,0,1},
  {1,0,0,0,0,0,1,0,3,2,2,2,2,0,1,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,3,2,2,2,2,0,0,0,0,0,0,0,0},
  {3,3,3,3,3,3,1,3,3,2,2,2,2,3,3,3,3,3,3,3,3},
  {2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {0,0,0,0,0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,1,1,1,1,1,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,0,0,0,0,0,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,0,1,1,1,0,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,0,1,1,1,0,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,0,1,1,1,0,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,0,0,0,0,0,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,1,1,1,1,1,1,0,3,2,2,2,2,2,2,2,2,2,2,2,2},
};

  

void setup(){
  
  size(420,420);
  int i, j;
  background(255);
  noStroke();
  
  //code3をすべて-1に初期化
  for(i=0; i<100; i++){
    code3[i] = -1;
  }
  
  // cellの中身の処理
  // code2の中身
  //println("dataLength = " + dataLength);
  for(i=0; i<9; i++){
    code2[8-i] = dataLength % 2;
    dataLength /= 2;
  }
  
  // 文字列を2文字ずつ分け, 奇数個目をlhs, 偶数個目をrhsとする
  int lhs, rhs;
  int now = 0;
   
  
  for(i=0; i<data.length(); i+=2){
    lhs = int(data.charAt(i));
    rhs = int(data.charAt(i+1));
    
    // 文字が0～9の時のコード変換
    if(48 <= lhs && lhs <= 57){
       lhs -= 48;
    }
    if(48 <= rhs && rhs <= 57){
      rhs -= 48;
    }
    
    // 文字がA～Zの時のコード変換
    if(65 <= lhs && lhs <= 90){
      lhs -= 55;
    }
    if(65 <= rhs && rhs <= 90){
      rhs -= 55;
    }
    
    // 左辺値lhsを45倍し, 右辺値rhsと足し合わせる
    lhs *= 45;
    int twoCharNum = lhs + rhs;
     // 2文字分の文字を表すbit数, 10以上なら11bit, 10未満なら6bit
    int twoCodeLength;
    if(twoCharNum < 1){
      twoCodeLength = 6;
    }
    else twoCodeLength = 11;
    
    for(j=0; j<twoCodeLength; j++){
      code3[now+twoCodeLength-j-1] = twoCharNum%2;
      twoCharNum /= 2;
    }
    now += twoCodeLength;
    
        
  }
  
  // 最終的にnowがcode3[]の要素数となる
  
  
  /*
  // データ部分の確認
  for(i=0; i<200; i++){
    print(code3[i]);
  }
  */
  
  
  
  // code3の要素数を求める
  int code3Size = 0;
  for(i=0; i<100; i++){
    if(code3[i] == -1){
      code3Size = i;
      break;
    }
  }
  
  
  
  //resultCodeにすでに格納された値の個数
  int resultSize = 0;
  for(i=0; i<code1.length; i++){
    resultCode[i] = code1[i];
  }
  resultSize += code1.length;
  
  for(i=0; i<code2.length; i++){
    resultCode[resultSize+i] = code2[i];
  }
  resultSize += code2.length;
  
  for(i=0; i<code3Size; i++){
    resultCode[resultSize+i] = code3[i];
  }
  resultSize += code3Size;
  
  for(i=0; i<code4.length; i++){
    resultCode[resultSize+i] = code4[i];
  }
  resultSize += code4.length;
  
  // 8bitずつに分けた時, 足りない部分に0を挿入
  j = 0;
  for(i=0; i<8-resultSize%8; i++){
    if(resultSize%8 == 0) break;
    resultCode[resultSize+i] = 0;
    j ++;
    println("resultSize = " + resultSize);
  }
  resultSize += j;
  
  
  // 9byteに満たない場合, (11101100), (00010001)を交互に付加
  boolean isFirst = true;
  for(i=0; i< (72-resultSize)/8; i++){
    if(isFirst){
      resultCode[resultSize + i]   = 1;
      resultCode[resultSize + i+1] = 1;
      resultCode[resultSize + i+2] = 1;
      resultCode[resultSize + i+3] = 0;
      resultCode[resultSize + i+4] = 1;
      resultCode[resultSize + i+5] = 1;
      resultCode[resultSize + i+6] = 0;
      resultCode[resultSize + i+7] = 0;
      resultSize += 8;
      isFirst = false;
    }
    else if(!isFirst){
      resultCode[resultSize + i]   = 0;
      resultCode[resultSize + i+1] = 0;
      resultCode[resultSize + i+2] = 0;
      resultCode[resultSize + i+3] = 1;
      resultCode[resultSize + i+4] = 0;
      resultCode[resultSize + i+5] = 0;
      resultCode[resultSize + i+6] = 0;
      resultCode[resultSize + i+7] = 1;
      resultSize += 8;
      isFirst = true;
    }
    
  }
  
  // code3.length = 72で正常
  // println("code3.length" + code3Size);


  // resultCode確認 
  for(i=0; i<resultCode.length; i++){
    print(resultCode[i]);
    if(i%8 == 7){
      print(" ");
    }
  }
  println();
  println("resultSize = " +resultSize);
  
  
  
  for(i=0; i<21; i++){
    for(j=0; j<21; j++){
      if(cell[i][j] == 1){
        fill(0);
        rect(j*cellSize, i*cellSize, cellSize, cellSize);
      }
      else if(cell[i][j] == 2){
        fill(255, 255, 0);
        rect(j*cellSize, i*cellSize, cellSize, cellSize);
      }
      else if(cell[i][j] == 3){
        fill(0, 255, 255);
        rect(j*cellSize, i*cellSize, cellSize, cellSize);
      }
        
      
    }
  }
}
