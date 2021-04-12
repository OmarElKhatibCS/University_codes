// stack is predefined

// Algorithm : https://www.youtube.com/watch?v=L99TIz933wo
// NOTE : #3 is -3 , we use # to differ 2-3 from -3

int isInt(char c) {
    return c-'0' >= 0 && c-'0' <= 9;
}

float infix_evaluation(char *infix) {
    int len = strlen(infix);
    char *postfix = (char*)malloc(len*sizeof(char));
    char c;
    int cnt=0,i;
    element e;
    stack s = CreateStack();
    
    for(i=0;i<len;i++) {
        c = *(infix+i);
        if(isInt(c)) {
            *(postfix+cnt) = c;
            cnt++;
        } else if (c == ')'){
            while(Top(s,&e) && (char)e != '(') {
                Pop(&s);
                *(postfix+cnt) = (char)e;
                cnt++;
            }
            Pop(&s);
        }
        else {
            Top(s,&e);
            if(isEmptyStack(s) || stackable(c,(char)e)) {
                Push(&s , c);
            } else {
              while(Top(s,&e) && !stackable(c,(char)e)) {
                  Pop(&s);
                  *(postfix+cnt) = (char)e;
                  cnt++;
              }
              Push(&s,c);
            }
        }
    }
    while(Top(s,&e)) {
        Pop(&s);
        *(postfix+cnt) = (char)e;
        cnt++;
    }
    *(postfix+cnt) = '\0';

    for(i=0;i<cnt;i++){
        c = *(postfix+i);
        if(isInt(c)) {
            Push(&s,c-'0');
        }
        else if(c == '#') {
            if(Top(s,&e)) {
                Pop(&s);
                Push(&s,e*-1);
            }
        }
        else {
            float top,bottomOfTop;
            if(Top(s,&e)) {
                top = e;
                Pop(&s);
                if(Top(s,&e)) {
                    bottomOfTop = e;
                    Pop(&s);
                }
            }
            if(c == '+') Push(&s , bottomOfTop+top);
            else if(c == '-') Push(&s, bottomOfTop-top);
            else if(c == '*') Push(&s , bottomOfTop*top);
            else if(c == '^') Push(&s , pow(bottomOfTop,top));
            else Push(&s,bottomOfTop/top);
        }
    }
    Top(s,&e);
    Pop(&s);
    return e;
}

