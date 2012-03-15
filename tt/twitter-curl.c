#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>
#include <time.h>

struct string {
  char *ptr;
  size_t len;
};

void init_string(struct string *s) {
  s->len = 0;
  s->ptr = malloc(s->len+1);
  if (s->ptr == NULL) {
    fprintf(stderr, "malloc() failed\n");
    exit(EXIT_FAILURE);
  }
  s->ptr[0] = '\0';
}

size_t writefunc(void *ptr, size_t size, size_t nmemb, struct string *s)
{
  size_t new_len = s->len + size*nmemb;
  size_t max_buffer = 10240;
  FILE *fp;
  char base[12] = "stream.json";
  char filename[15];
  char directory[10] = "json/";
  time_t now;
  struct tm* tm;
  //fp=fopen("istream.txt", "a");


  s->ptr = realloc(s->ptr, new_len+1);
  if (s->ptr == NULL) {

    fprintf(stderr, "realloc() failed\n");
    exit(EXIT_FAILURE);
  }
  memcpy(s->ptr+s->len, ptr, size*nmemb);
  s->ptr[new_len] = '\0';
  s->len = new_len;

  // Begin newly added code
  if( s->len >= max_buffer )
  {
    now = time(0);
    tm = localtime(&now);
    printf("min = %d ", tm->tm_min);

    sprintf(filename, "%s%d%s", directory,tm->tm_min, base);
    //itoa(tm->tm_min, min, 2);    
    
    //strncat(min, filename, 20);

    //fp=fopen(filename, "a");
    fp=fopen(filename, "a"); // use this to not append old json file
    fprintf(fp, "%s", s->ptr);
    fclose(fp);
    //printf("%s", s->ptr);
    fflush( stdout );
    free(s->ptr);
    init_string( s );
  }
  //fclose(fp);
  // End newly added code

  return size*nmemb;
}

int main(void)
{
  CURL *curl;
  CURLcode res;


  curl = curl_easy_init();
  if(curl) {
    struct string s;
    init_string(&s);

    curl_easy_setopt(curl, CURLOPT_URL, "https://stream.twitter.com/1/statuses/sample.json");
    curl_easy_setopt(curl, CURLOPT_USERPWD, "neilmarion:password");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &s);
    res = curl_easy_perform(curl);

    //printf("%s\n", s.ptr);
    free(s.ptr);

    /* always cleanup */
    curl_easy_cleanup(curl);
  }
  return 0;
}
