select sport 
from pratique
where sport not in (select sport from propose);

select centre_sportif 
from est_membre
where (select sport from propose) CONTAINS (select sport from pratique where Personne="Henri");

select personne
from est_membre
where centre_sportif = (select p2.centre_sportif
from est_membre p1 , est_membre p2
where p1.personne = "Pierre" and p2.personne = "Jean" and p1.centre_sportif = p2.centre_sportif
);

select personne
from est_membre
group by personne
having count(centre_sportif)>1;

select sport
from pratique 
group by sport
having count(sport) = (select max(myCount) from (select count(personne) myCount from pratique group by sport) result );

/* 
Same Result for above Query
 */

select sport
from partique
group by sport
order by count(personne) 
desc
limit 1;

select centre_sportif 
from est_membre
where (select sport from propose) CONTAINS (select sport from pratique where Personne="Pierre") and (select sport from propose) CONTAINS (select sport from pratique where Personne="Jean");