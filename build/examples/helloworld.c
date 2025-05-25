#include <stdio.h>

void jitentry ()
{
  char name[100];
  printf("Enter your name: ");
  scanf("%99s", name);
  printf("Hello, %s!\n", name);
}
