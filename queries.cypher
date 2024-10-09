// SET UP DATA for "shared identity" pattern

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

// TODO: Create some more dummy data

// example of what the SQL might look like

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


// Payment ring

merge (a:AccountHolder {name: "John Stegeman"})
merge (b:AccountHolder {name: "Jane Smith"})
merge (c:AccountHolder {name: "Fred Rogers"})
merge (d:AccountHolder {name: "Susan Thomas"})
merge (t:Transaction {amount: 500})
merge (u:Transaction {amount: 490})
merge (v:Transaction {amount: 480})
merge (w:Transaction {amount: 470})
merge (a)-[:PERFORMS]->(t)-[:FOR_BENEFIT_OF]->(b)
merge (b)-[:PERFORMS]->(u)-[:FOR_BENEFIT_OF]->(c)
merge (c)-[:PERFORMS]->(v)-[:FOR_BENEFIT_OF]->(d)
merge (d)-[:PERFORMS]->(w)-[:FOR_BENEFIT_OF]->(a);

// TODO: Create some more dummy data

match ring=(a:AccountHolder)
(()-[:PERFORMS]->()-[:FOR_BENEFIT_OF]->()){3,10}(a)
return ring;

match ring=(a:AccountHolder)
(()-[:PERFORMS]->(:Transaction)-[:FOR_BENEFIT_OF]->()){3,10}(a)
return ring;

// QPP of some type

