Vim�UnDo� VT�b��rc���"���Bn+���S�|��W��n                                     R�    _�                             ����                                                                                                                                                                                                                                                                                                                                                            R�v     �                   �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                         R�w     �                  F  1 /* tpk.c:  Knuth's TPK program in the C programming language    */   2    D3 #include <stdio.h>    /* include header file for standard I/O   */   D4 #include <math.h>     /* include header file for math functions */   5    !6 /* f(x) = sqrt(|x|) + 5*x**3 */   7 double f (double x) {   .8     return (sqrt(fabs(x)) + 5.0*pow(x,3.0));   9 }   10    &11 int main (int argc, char* argv[]) {   12     double A [11], y;   13     int i;   14    .15     /* Read in the values of the array A */   16     for (i=0; i<11; i++) {    17         scanf ("%lf", &A[i]);   18     }   19    G20     /* In reverse order, apply "f" to each element of A and print */   21     for (i=10; i>=0; i--) {   22         y = f (A[i]);   23         if (y > 400.0) {   ,24             printf ("%d TOO LARGE\n", i);   25         } else {   (26             printf ("%d %f\n", i, y);   27         }   28     }   29     return (0);   30 }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                         R�z     �                  E 1 /* tpk.c:  Knuth's TPK program in the C programming language    */       C #include <stdio.h>    /* include header file for standard I/O   */   C #include <math.h>     /* include header file for math functions */         /* f(x) = sqrt(|x|) + 5*x**3 */    double f (double x) {   -     return (sqrt(fabs(x)) + 5.0*pow(x,3.0));    }   0    %1 int main (int argc, char* argv[]) {   2     double A [11], y;   3     int i;   4    -5     /* Read in the values of the array A */   6     for (i=0; i<11; i++) {   7         scanf ("%lf", &A[i]);   8     }   9    F0     /* In reverse order, apply "f" to each element of A and print */   1     for (i=10; i>=0; i--) {   2         y = f (A[i]);   3         if (y > 400.0) {   +4             printf ("%d TOO LARGE\n", i);   5         } else {   '6             printf ("%d %f\n", i, y);   7         }   8     }   9     return (0);   0 }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                         R�{     �                D1 /* tpk.c:  Knuth's TPK program in the C programming language    */5�_�                            ����                                                                                                                                                                                                                                                                                                                                                         R�}     �                C /* tpk.c:  Knuth's TPK program in the C programming language    */5�_�                            ����                                                                                                                                                                                                                                                                                                                                                         R�    �   
              $ int main (int argc, char* argv[]) {        double A [11], y;        int i;       ,     /* Read in the values of the array A */        for (i=0; i<11; i++) {            scanf ("%lf", &A[i]);        }       E     /* In reverse order, apply "f" to each element of A and print */        for (i=10; i>=0; i--) {            y = f (A[i]);            if (y > 400.0) {   *             printf ("%d TOO LARGE\n", i);            } else {   &             printf ("%d %f\n", i, y);   
         }        }        return (0);    }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                       R�     �   
             "nt main (int argc, char* argv[]) {      double A [11], y;   	   int i;       *   /* Read in the values of the array A */      for (i=0; i<11; i++) {          scanf ("%lf", &A[i]);      }       C   /* In reverse order, apply "f" to each element of A and print */      for (i=10; i>=0; i--) {          y = f (A[i]);          if (y > 400.0) {   (           printf ("%d TOO LARGE\n", i);          } else {   $           printf ("%d %f\n", i, y);          }      }      return (0);    5��