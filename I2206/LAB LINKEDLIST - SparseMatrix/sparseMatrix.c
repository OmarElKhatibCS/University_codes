#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int row, col ,value;
} element;

typedef struct matrix {
    element data;
    struct matrix *down , *right;
} matrix;

matrix* createMatrix(int row , int col , int val) {
    matrix* m = (matrix*)malloc(sizeof(matrix));
    m->data.row = row;
    m->data.col = col;
    m->data.value = val;
    return m;
}

void pushEndCirculaire(matrix **headRef , matrix* m) {
    matrix *head;
    if(*headRef == NULL) {
        *headRef = m;
        (*headRef)->right = *headRef;
        return;
    }
    head = *headRef;
    while(head->right != *headRef) {
        head = head->right;
    }
    head->right = m;
    head->right->right = *headRef;
}

void linkDowns(matrix **headRef) {
    matrix* head = *headRef , *start = *headRef , *m ,*current;
    int minCol , minRow , minSameRow , foundValidValueInSameColumn;
    int foundBiggerValue = 0;
    
    while(1) {
        current = head->right;
        minSameRow = head->data.row;
        minCol = -1;
        minRow = -1;
        foundValidValueInSameColumn = 0;
        m = head;
        
        while(current != head) {
            if(current == start) {
                current = current->right;
                continue;
            }
            // This is To check if I find a valid node with same col and bigger Row then HEAD
            if(current->data.col == head->data.col) {
                if(foundValidValueInSameColumn) {
                    if(current->data.row < minSameRow) {
                        m = current;
                        minSameRow = current->data.row;
                    }
                }
                else if(current->data.row > head->data.row) {
                    foundValidValueInSameColumn = 1;
                    m = current;
                    minSameRow = current->data.row;
                }
            }
            // END SAME COLUMN AS HEAD
            
            current = current->right;
        }
        current = head->right;
        while(current != head && !foundValidValueInSameColumn) {
            if(current == start) {
                current = current->right;
                continue;
            }
            
            if(minCol == -1) {
                if(current->data.col > head->data.col) {
                    minCol = current->data.col;
                    minRow = current->data.row;
                    m = current;
                }
            } else {
                if(current->data.col <= minCol && current->data.col > head->data.col) {
                    if(current->data.col == minCol) {
                        if(current->data.row < minRow) {
                            minRow = current->data.row;
                            minCol = current->data.col;
                            m = current;
                            continue;
                        }
                    } else {
                        minRow = current->data.row;
                        minCol = current->data.col;
                        m = current; 
                    }
                } 
            }
            
            current = current->right;
        }

        if(minCol == -1 && !foundValidValueInSameColumn) m = start;
        head->down = m;
        head = head->right;
        if(head == start) break;
    }
}

void buildList(matrix **headRef) {
   //matrix *head = *headRef; 
    matrix* dummy = createMatrix(0 , 0 , 0);
    
    int n,m ,r=0, row , col , val;
    scanf("%d %d" , &n , &m);
    matrix* a = createMatrix(n,m,0);
    a->down = NULL;
    a->right = dummy;
    pushEndCirculaire(headRef , dummy);
    while(scanf("%d%d%d",&row , &col , &val) != EOF) {
        matrix* m = createMatrix(row , col , val);
        pushEndCirculaire(headRef , m);
    }
    *headRef = a;
}

matrix* main() {
    matrix* List = NULL;
    buildList(&List);
    linkDowns(&(List->right));
    return List;
}

