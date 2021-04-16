int add(systemQ t , int e , int p) {
    if(p < 0 || p > N-1) return 0;
    return EnQueue(t+p , e);
}

void create_system(systemQ t) {
    for(int i=0 ; i< N ; i++) {
        *(t+i) = CreateQueue();
    }
}

int deletePri(systemQ t) {
    for(int i= N-1 ; i >= 0 ; i--) {
        if(isEmptyQueue(*(t+i))) continue;
        return DeQueue(t+i);
    }
    return 0;
}

int nb_elements(systemQ t , element e) {
    if(e < 0 || e > N-1) return 0;
    queue temp = *(t+e);
    int count = 0;
    element el;
    while(Front(temp , &el)) {
        DeQueue(&temp);
        count++;
    }
    return count;
} 

void display(systemQ t) {
    element e;
    queue tempQ;
    for(int i=N-1 ; i >= 0 ; i--) {
        tempQ = *(t+i);
        if(isEmptyQueue(tempQ)) continue;
        while(Front( tempQ , &e)) {
            printf("%d ",e);
            DeQueue(&tempQ);
        }
    }
}

void modify(int priority1 , int priority2 , systemQ t) {
    element e;
    if(priority1 < 0 || priority2 < 0 || priority1 >= N || priority2 >= N || isEmptyQueue(*(t+priority1))) return;
    
    while(Front(*(t+priority1),&e)) {
        DeQueue(t+priority1);
        if(!EnQueue(t+priority2 , e)) return;
    }
}
