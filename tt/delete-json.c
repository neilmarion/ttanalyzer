#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
  FILE *fp;
  time_t now;
  struct tm* tm;
  char base[12] = "stream.json";
  char filename[15];
  char directory[10] = "json/";
  int min = 0;

  now = time(0);
  tm = localtime(&now);
  printf("min = %d ", tm->tm_min);

  min = tm->tm_min-3;
  if(min < 0) min = 60 + min;

  sprintf(filename, "%s%d%s", directory, min, base);

  fp=fopen(filename, "w"); // overwrite old json file
  //fprintf(fp, "%s", s->ptr);
  fclose(fp);
  
}
