#include <stdio.h>

#include "cdecl.h"


void PRE_CDECL switchCase() POST_CDECL;     /* prototype for assembly routine */
int main()
{
  switchCase();
  printf("Fim do bloco Switch Case.");
  return 0;
}