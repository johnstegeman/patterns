// SET UP DATA for "shared identity" pattern

merge (a:Account {name: "johnstegeman"})
merge (a2:Account {name: "steggy"})
merge (i:Identity:Address {street: "111 Main Street", city: "Anytown"})
merge (a)-[:LOCATED_AT]->(i)
merge (a2)-[:LOCATED_AT]->(i);

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

// accounts using shared identities

match (a:Account)-[r]->(i:Identity)<-[r2]-(a2:Account)
return *;

merge (a:Account {name: "johnsmith"})-[:CONNECTED_VIA]->(:Identity:IP_Address {ipv4: "192.168.4.100"});

match (a:Account {name: "johnsmith"})
with a
merge (i:Identity:Email {address: "john@cloud.de"})
with i, a
merge (a)-[:USES]->(i);

match p=(()-[]-())
return p;

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

merge (a:AccountHolder {name: "Josephine Stegeman"})
merge (b:AccountHolder {name: "Mark Smith"})
merge (c:AccountHolder {name: "Smiti Rogers"})
merge (t:Transaction {amount: 1500})
merge (u:Transaction {amount: 1490})
merge (v:Transaction {amount: 1480})
merge (a)-[:PERFORMS]->(t)-[:FOR_BENEFIT_OF]->(b)
merge (b)-[:PERFORMS]->(u)-[:FOR_BENEFIT_OF]->(c)
merge (c)-[:PERFORMS]->(v)-[:FOR_BENEFIT_OF]->(a);

match ring=(a:AccountHolder)
(()-[:PERFORMS]->()-[:FOR_BENEFIT_OF]->()){3,10}(a)
return ring;

match ring=(a:AccountHolder)
(()-[:PERFORMS]->(:Transaction)-[:FOR_BENEFIT_OF]->()){3,10}(a)
return ring;

// Create CRM
CREATE (crm1:Application {
			ip:'10.10.32.1',
			host:'CRM-APPLICATION',
			type: 'APPLICATION',
			system: 'CRM'
		})

// Create ERP
CREATE (erp1:Application {
			ip:'10.10.33.1',
			host:'ERP-APPLICATION',
			type: 'APPLICATION',
			system: 'ERP'
		})

// Create Data Warehouse
CREATE (datawarehouse1:Application {
			ip:'10.10.34.1',
			host:'DATA-WAREHOUSE',
			type: 'DATABASE',
			system: 'DW'
		})

// Create Public Website 1
CREATE (Internet1:Internet {
			ip:'10.10.35.1',
			host:'global.acme.com',
			type: "APPLICATION",
			system: "INTERNET"
		})

// Create Public Website 2
CREATE (Internet2:Internet {
			ip:'10.10.35.2',
			host:'support.acme.com',
			type: "APPLICATION",
			system: "INTERNET"
		})

// Create Public Website 3
CREATE (Internet3:Internet {
			ip:'10.10.35.3',
			host:'shop.acme.com',
			type: "APPLICATION",
			system: "INTERNET"
		})

// Create Public Website 4
CREATE (Internet4:Internet {
			ip:'10.10.35.4',
			host:'training.acme.com',
			type: "APPLICATION",
			system: "INTERNET"
		})

// Create Public Website 5
CREATE (Internet5:Internet {
			ip:'10.10.35.1',
			host:'partners.acme.com',
			type: "APPLICATION",
			system: "INTERNET"
		})

// Create Internal Website 1
CREATE (Intranet1:Intranet {
			ip:'10.10.35.2',
			host:'events.acme.net',
			type: "APPLICATION",
			system: "INTRANET"
		})

// Create Internal Website 2
CREATE (Intranet2:Intranet {
			ip:'10.10.35.3',
			host:'intranet.acme.net',
			type: "APPLICATION",
			system: "INTRANET"
		})

// Create Internal Website 3
CREATE (Intranet3:Intranet {
			ip:'10.10.35.4',
			host:'humanresources.acme.net',
			type: "APPLICATION",
			system: "INTRANET"
		})

// Create Webserver VM 1
CREATE (webservervm1:VirtualMachine {
			ip:'10.10.35.5',
			host:'WEBSERVER-1',
			type: "WEB SERVER",
			system: "VIRTUAL MACHINE"
		})

// Create Webserver VM 2
CREATE (webservervm2:VirtualMachine {
			ip:'10.10.35.6',
			host:'WEBSERVER-2',
			type: "WEB SERVER",
			system: "VIRTUAL MACHINE"
		})

// Create Database VM 1
CREATE (customerdatabase1:VirtualMachine {
			ip:'10.10.35.7',
			host:'CUSTOMER-DB-1',
			type: "DATABASE SERVER",
			system: "VIRTUAL MACHINE"
		})

// Create Database VM 2
CREATE (customerdatabase2:VirtualMachine {
			ip:'10.10.35.8',
			host:'CUSTOMER-DB-2',
			type: "DATABASE SERVER",
			system: "VIRTUAL MACHINE"
		})

// Create Database VM 3
CREATE (databasevm3:VirtualMachine {
			ip:'10.10.35.9',
			host:'ERP-DB',
			type: "DATABASE SERVER",
			system: "VIRTUAL MACHINE"
		})

// Create Database VM 4
CREATE (dwdatabase:VirtualMachine {
			ip:'10.10.35.10',
			host:'DW-DATABASE',
			type: "DATABASE SERVER",
			system: "VIRTUAL MACHINE"
		})

// Create Hardware 1
CREATE (hardware1:Hardware {
			ip:'10.10.35.11',
			host:'HARDWARE-SERVER-1',
			type: "HARDWARE SERVER",
			system: "PHYSICAL INFRASTRUCTURE"
		})

// Create Hardware 2
CREATE (hardware2:Hardware {
			ip:'10.10.35.12',
			host:'HARDWARE-SERVER-2',
			type: "HARDWARE SERVER",
			system: "PHYSICAL INFRASTRUCTURE"
		})

// Create Hardware 3
CREATE (hardware3:Hardware {
			ip:'10.10.35.13',
			host:'HARDWARE-SERVER-3',
			type: "HARDWARE SERVER",
			system: "PHYSICAL INFRASTRUCTURE"
		})

// Create SAN 1
CREATE (san1:Hardware {
			ip:'10.10.35.14',
			host:'SAN',
			type: "STORAGE AREA NETWORK",
			system: "PHYSICAL INFRASTRUCTURE"
		})


match p=(n)-[]-()
where n:Hardware or n:Application or n:Hardware or n:Internet or n:Intranet or n:VirtualMachine
return p

// Connect CRM to Database VM 1
CREATE (crm1)-[:DEPENDS_ON]->(customerdatabase1)

// Connect Public Websites 1-3 to Database VM 1
CREATE 	(Internet1)-[:DEPENDS_ON]->(customerdatabase1),
	   	(Internet2)-[:DEPENDS_ON]->(customerdatabase1),
	   	(Internet3)-[:DEPENDS_ON]->(customerdatabase1)

// Connect Database VM 1 to Hardware 1
CREATE 	(customerdatabase1)-[:DEPENDS_ON]->(hardware1)

// Connect Hardware 1 to SAN 1
CREATE 	(hardware1)-[:DEPENDS_ON]->(san1)

// Connect Public Websites 1-3 to Webserver VM 1
CREATE 	(webservervm1)<-[:DEPENDS_ON]-(Internet1),
		(webservervm1)<-[:DEPENDS_ON]-(Internet2),
		(webservervm1)<-[:DEPENDS_ON]-(Internet3)

// Connect Internal Websites 1-3 to Webserver VM 1
CREATE 	(webservervm1)<-[:DEPENDS_ON]-(Intranet1),
		(webservervm1)<-[:DEPENDS_ON]-(Intranet2),
		(webservervm1)<-[:DEPENDS_ON]-(Intranet3)

// Connect Webserver VM 1 to Hardware 2
CREATE 	(webservervm1)-[:DEPENDS_ON]->(hardware2)

// Connect Hardware 2 to SAN 1
CREATE 	(hardware2)-[:DEPENDS_ON]->(san1)

// Connect Webserver VM 2 to Hardware 2
CREATE 	(webservervm2)-[:DEPENDS_ON]->(hardware2)

// Connect Public Websites 4-6 to Webserver VM 2
CREATE 	(webservervm2)<-[:DEPENDS_ON]-(Internet4),
		(webservervm2)<-[:DEPENDS_ON]-(Internet5)

// Connect Database VM 2 to Hardware 2
CREATE 	(hardware2)<-[:DEPENDS_ON]-(customerdatabase2)

// Connect Public Websites 4-5 to Database VM 2
CREATE 	(Internet4)-[:DEPENDS_ON]->(customerdatabase2),
	   	(Internet5)-[:DEPENDS_ON]->(customerdatabase2)

// Connect Hardware 3 to SAN 1
CREATE 	(hardware3)-[:DEPENDS_ON]->(san1)

// Connect Database VM 3 to Hardware 3
CREATE 	(hardware3)<-[:DEPENDS_ON]-(databasevm3)

// Connect ERP 1 to Database VM 3
CREATE 	(erp1)-[:DEPENDS_ON]->(databasevm3)

// Connect Database VM 4 to Hardware 3
CREATE 	(hardware3)<-[:DEPENDS_ON]-(dwdatabase)

// Connect Data Warehouse 1 to Database VM 4
CREATE 	(datawarehouse1)-[:DEPENDS_ON]->(dwdatabase)

RETURN *

MATCH 		(dependency)<-[:DEPENDS_ON*]-(dependent)
WITH 		dependency, count(DISTINCT dependent) AS Dependents
ORDER BY 	Dependents DESC
LIMIT		1
WITH		dependency
MATCH 		p=(resource)-[:DEPENDS_ON*]->(dependency)
WHERE		resource.system = "DW"
RETURN		p


MATCH 		(dependency)<-[:DEPENDS_ON*]-(dependent)
WITH 		dependency, count(DISTINCT dependent) AS Dependents
ORDER BY 	Dependents DESC
LIMIT		1
WITH		dependency
MATCH 		p=(resource)-[:DEPENDS_ON*]->(dependency)
WHERE		resource.system = "ERP"
return p

// Most depended-upon component
MATCH 		(n)<-[:DEPENDS_ON*]-(dependent)
RETURN 		n.host as Host,
			count(DISTINCT dependent) AS Dependents
ORDER BY 	Dependents DESC
LIMIT 		1