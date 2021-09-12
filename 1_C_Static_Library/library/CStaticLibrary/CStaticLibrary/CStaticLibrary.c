//
//  HelloThere.c
//  CStaticLibrary
//
//  Created by Luis Antonio Gomez Vazquez on 29/08/21.
//

#include "CStaticLibrary.h"

void fibonacci(int n) {
    int first = 0, second = 1, next, i;
    for (i = 0; i < n; i++) {
        if (i <= 1) {
        next = i;
        } else {
        next = first + second;
        first = second;
        second = next;
      }
      printf("%d, ", next);
    }
    printf("\n");
}
