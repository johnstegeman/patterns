merge (a:Account {name: "johnstegeman"})
merge (a2:Account {name: "steggy"})
merge (i:Identity:Address {street: "111 Main Street", city: "Anytown"})
merge (a)-[:LOCATED_AT]->(i)
merge (a2)-[:LOCATED_AT]->(i);

match (a:Account)-[r]->(i:Identity)<-[r2]-(a2:Account)
return *;

create (i:Identity:Email {address: "john@cloud.co"})
with i
match (a:Account {name: "johnstegeman"})
merge (a)-[:USES]->(i);

create (i:Identity:IP_Address {ipv4: "192.160.1.2"})
with i
match (a:Account {name: "steggy"})
merge (a)-[:CONNECTED_VIA]->(i);

merge (a:Account {name: "johndstegeman"})
with a
match (i:Identity:IP_Address {ipv4: "192.160.1.2"})
with a,i
merge (a)-[:CONNECTED_VIA]->(i);

match p=(()-[]-())
return p;

merge (a:Account {name: "johnsmith"})-[:CONNECTED_VIA]->(:Identity:IP_Address {ipv4: "192.168.4.100"});

match (a:Account {name: "johnsmith"})
with a
merge (i:Identity:Email {address: "john@cloud.de"})
with i, a
merge (a)-[:USES]->(i);


select a1.*, a2.*
from account a1, account a2
where (exists (select null from account_address aa1, account_address aa2
               where a1.account_id = aa1.account_id
               and   a2.account_id = aa2.account_id
               and   aa1.address = aa2.address))
or (exists (select null from ip_address i1, ip_address i2
               where a1.account_id = i1.account_id
               and   a2.account_id = i2.account_id
               and   i1.ipv4 = i2.ipv4))
or (exists (select null from account_email ae1, account_email ae2
               where a1.account_id = ae1.account_id
               and   a2.account_id = ae2.account_id
               and   ae1.email = ae2.email))