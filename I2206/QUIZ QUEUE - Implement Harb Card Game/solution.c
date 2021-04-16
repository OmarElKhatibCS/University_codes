// We have Stack , and QUEUE operations predefined
// element type is INT


/*
NOTE :
their is repetitive code here ,
A good Idea maybe is to make a function that take player and ground and operate based on those
void turn(queue *player , stack *ground)
if(player_turn = 1) turn(&p1 , &ground)
NOT TESTED BUT SHOULD WORK FINE , it make code less and more reusable in case of many players!
*/

void play() {
	element card , topCard;
	int round = 1;
	int player_turn = 1;
	queue p1 = CreateQueue();
	queue p2 = CreateQueue();
	stack ground = CreateStack();
	stack aux = CreateStack(); // used to reverse the ground stack
	
	for(int i=0; i < 26 ; i++) {
		scanf("%d",&card);
		EnQueue(&p1,card);
	}
	for(int i=0; i < 26 ; i++) {
		scanf("%d",&card);
		EnQueue(&p2,card);
	}
	if(Front(p1,&card)) {
		DeQueue(&p1);
		Push(&ground , card);
		player_turn = 2;
	}
	
	while(1) {
		if(player_turn == 2) {
			player_turn = 1;
			if(Front(p2,&card)) {
				DeQueue(&p2);
				if(Top(ground , &topCard)) {
					if(topCard == card) {
						round++;
						while(Top(ground,&topCard)) {
							Push(&aux , topCard);
							Pop(&ground);
						}
						while(Top(aux,&topCard)) {
							EnQueue(&p2 , topCard);
							Pop(&aux);
						}
					}
				}
				Push(&ground,card);
			} else break;
		} else {
			player_turn = 2;
			if(Front(p1,&card)) {
				DeQueue(&p1);
				if(Top(ground , &topCard)) {
					if(topCard == card) {
						round++;
						while(Top(ground,&topCard)) {
							Push(&aux , topCard);
							Pop(&ground);
						}
						while(Top(aux,&topCard)) {
							EnQueue(&p1 , topCard);
							Pop(&aux);
						}
					}
				}
				Push(&ground,card);
			} else break;
		}
	}
	if(isEmptyQueue(p1)) printf("Player 2 wins after %d rounds\n" , round);
	else if (isEmptyQueue(p2)) printf("Player 1 wins after %d rounds\n" , round);
}
