#include<stdio.h>
void jitentry()
{
    int a;
    printf("Enter a number:");
    scanf("%d",&a);
    printf("Square of the number %d is: %d",a,a*a);
}