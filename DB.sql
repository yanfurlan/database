/usr/local/mysql/bin/mysql -u root -p'Troca@123'


Logar no banco (alguns servidores pode ser necessário colocar a porta: ex 3306): 
/usr/local/mysql/bin/mysql -u -p --protocol=tcp -A 
Segunda opção : mysql -u  -p --protocol=tcp


/usr/local/mysql/bin/mysql -u user -p'password'

select host, user, password from mysql.user where user like '' -> Para pegar a hash de senha

Create user '123123' identified by password 'hash'; -> criar usando senha hash

--------------------------------------------------------------------------------------

Replicação 

md5 sum -> consistencia logica


erro 1032

Recuperação de dados a partir de binlogs
Princapais erros de replicação e inconsistencia logica

--------------------------------------------------------------------------------------- 
mysql -uzt00152 -p'^*bkGV6K&despNo' --socket=/opt/mysql/run/mysqld_DEFAULT.sock --port=3300
 

mysql -uuser -p'123456' -vvvvvv database  < arquivo.sql > result.csv

mysql -uuser -p'123456' -vvvvvv database  arquivo.sql "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" > result.csv & disown


set global variables 
  
mysql -uuser -p'123456'  < atividade | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" > result.csv

select user, host from mysql.user where user not like 'hti%' and user not like 'ifc%';

--------------------------------------------------------------------------------------- 

gzip result.csv -> para compactar para gzip 

select user, host from mysql.user where user ='nome_do_usuario';    ----> Verificar se o usuario existe 

CREATE USER IF NOT EXISTS ----> MySQL 5.7 

mysql -uuser -p'123456' --socket=/opt/mysql/run/mysqld_DEFAULT.sock --port=3300 -vvvv piloto < CDT-118635.sql > /opt/mysql/work/CDT-118635.txt
USAR PARA PEGAR NA PASTA COMPARTILHADA
------------------------------------------------------------------------------------

use banco
desc tabela


desc banco.tabela;


para apagar no SO

rm * -> apaga tudo

rm nomearquivo

------------------------------------------------------------------------------------------------------------------------------------------------------

Para extrair procedure

SHOW CREATE PROCEDURE nome_da_procedure \G

-----------------------------------------------------------------------------------------------------------------------------------------------------

Para ver data de modificação das tabelas de um DB em information schema 

SELECT table_schema, table_name, create_time FROM information_schema.tables WHERE table_schema = 'database';


	Grant Azul

Select 'CDT-119743', @@hostname, now();

grant select on ccme.tab_proposta_historico to 'sdcomsh0'@'%';


grant select on comm.tab_proposta_controle to 'sdcomsh0'@'%';
grant select on comm.apo_trans to 'sdcomsh0'@'%';

Show grants for sdcomsh0;



--------------------------------------------------------------------------------------------------------


	Usuário no proxy
	
	
	
mysql -uadmin -padmin -h 127.0.0.1 -P 6034 ##bolt_proxy
select * from mysql_users;
insert into mysql_users (username, password, default_hostgroup, default_schema, backend, frontend, max_connections, comment) values ('sdadcod0', '*CCFC3D95C4909DBFE76D91D4EF041F88CA9687B2', 3300,'information_schema', 0, 1, 1000, 'Bolt-Padrão');
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS FROM RUNTIME;
SAVE MYSQL USERS TO DISK;
mysql -u sdsolpp0 -p -P6035 --protocol=tcp -e"SELECT 'CDT-114905', @@HOSTNAME, NOW(); SHOW GRANTS" ## bolt-db




------------------------------------------------------------------------------------------------------------


	Pegar permissões
	
	
SELECT * FROM mysql.procs_priv A WHERE A.Db = 'nome_do_banco' AND A.Routine_name = 'nome_do_objeto' AND FIND_IN_SET('Execute', A.proc_priv);
SELECT * FROM mysql.procs_priv A WHERE A.Db = 'nome_do_banco' AND A.Routine_name = 'nome_do_objeto' AND Proc_priv LIKE '%Execute%';
select Db,User,Routine_name,Proc_priv from mysql.procs_priv where routine_name in('proc_popula_tabela_painel_emissao');


-----------------------------------------------------------------------------------------------------------

	Antes de executar um delete ou update pegar a estrutura
	
show create table
show create procedure, function, trigger, event...


Show create procedure proc_proposta_validar_renovacao \G

	Pra verificar os usuários com permissão na proc/trigger


select Db,User,Routine_name,Proc_priv 
from mysql.procs_priv where routine_name in('trig_insert_proposta_historico');

Pra pegar a estrutura da proc: show create procedure trig_insert_proposta_historico\G
Pra pegar a estrutura da trigger: show create trigger Insert_Pagamentos\G



CLI Dbsnoop -> gcisv




-----------------------------------------------------------------

Atualização PRD para HMG/DSV

mysqldump -uzt00004 -p --single_transaction --lock-tables=false --skip-triggers --databases orquestracao_transmissao --complete-insert --no-create-db --no-create-info --tables tab_proposta > /opt/mysql/work/CDT-125823.sql
scp /opt/mysql/work/CDT-125823.sql zt00007@10.124.7.44:/opt/mysql/work

select "CDT-125823", @@hostname, now();

set foreign_key_checks = 0;

truncate table tab_proposta;

truncate table historico_adesao_renovacao_programada;

truncate table log_renovacao_programada;

truncate table pref_corretor_renovacao_programada;

source CDT-125823.sql

select table_schema, table_name, CREATE_TIME from information_schema.tables where table_schema = 'api_renovacao';

SELECT 'CDT-125823', @@hostname, now();

select TABLE_SCHEMA, TABLE_NAME, CREATE_TIME, UPDATE_TIME FROM information_schema.TABLES where TABLE_SCHEMA='api_renovacao' and TABLE_NAME in ('controle_renovacao_programada','historico_adesao_renovacao_programada','log_renovacao_programada','pref_corretor_renovacao_programada');

select count(*) from controle_renovacao_programada union select count(*) from historico_adesao_renovacao_programada union select count(*) from log_renovacao_programada union select count(*) from pref_corretor_renovacao_programada;

set foreign_key_checks = 1;

-----------------------------------------------------------------

Quando realizado truncate realizar

set foreign_key_checks = 0;

Depois retornar parar

set foreign_key_checks = 1;


------------------------------------------------------------------

Verificar no SO

uptime && date && free -ht && df -h


No Banco

BD

\s; 
show slave status\G 
select @@max_connections, @@max_user_connections; 
SHOW STATUS LIKE 'Max_used_connections';
SHOW STATUS LIKE 'Max_used_connections_time'; 
select * from (select user, count(*) as qtd from information_schema.processlist group by user order by 2 desc) t union select '------------------', '-----' union select 'Total: ', count(0) from information_schema.processlist;





POSTGRESQL


SELECT 'CDT-125679' as CDT, current_database(), now();


Transforme o codigo abaixo de mysql para postgresql adicionando corretamente os comentários das colunas. O PostgreSQL usa a instrução COMMENT ON para adicionar comentários a tabelas e colunas.


SQL Server

Max Connections

SELECT @@MAX_CONNECTIONS AS 'Max Connections';


Problema de disco

== VERIFICAR TOP TABLES EM GB ==
SELECT 
     table_schema as Database, 
     table_name AS Table, 
     round(((data_length + index_length) / 1024 / 1024/ 1024), 2) Size in GB 
FROM information_schema.TABLES 
ORDER BY (data_length + index_length) DESC;

sudo su
du -hcs  *



--------------------- SQL Server Lock

select spid, db_name(dbid) as [Database],login_time as Hora_Login,
Open_tran as Transacoes_Abertas,nt_username as Usuario, status,
Hostname as Estacao_Trabalho,program_name as Aplicacao, blocked as bloqueado_por
From master..sysProcesses
where db_name(dbid) <> 'master'
order by Open_tran desc, spid, program_name

SELECT     session_id, r.status, command, hostname, cmd, nt_username, text 
FROM       sys.dm_exec_requests r 
LEFT JOIN  master..sysprocesses p ON (session_id = spid) 
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS sqltext
WHERE      session_id = 351

SELECT s.TEXT, r.session_id, r.blocking_session_id, r.status, r.command, r.cpu_time,
r.total_elapsed_time FROM sys.dm_exec_requests r 
CROSS APPLY sys.dm_exec_sql_text(sql_handle) 
AS s where blocking_session_id <> 0 order by blocking_session_id desc;


------ Comandos

* Verificar Transações Longas/locks 

SELECT trx.trx_id, trx.trx_started, trx.trx_weight, trx.trx_rows_modified, trx.trx_rows_locked, trx.trx_mysql_thread_id FROM information_schema.innodb_trx trx JOIN information_schema.processlist ps ON trx.trx_mysql_thread_id = ps.id WHERE trx.trx_started < CURRENT_TIMESTAMP - INTERVAL 1 SECOND AND ps.user != 'system_user';

* Verificar quais tabelas estão sendo usadas no momento.

SHOW OPEN TABLES WHERE In_Use > 0;

* Verificar LOCKS

SELECT * FROM information_schema.innodb_locks;

* Verificar cosumo de CPU e Memória

htop ou top -c

* Verificar Memória RAM / SWAP

free -g

Ver o processlist de forma ascendente. Bom para ver querys com tempo de execução longo.

SELECT Id, User, Host, DB, Command, Time, State, LEFT(Info,100) FROM information_schema.processlist WHERE Command NOT IN ('Sleep','Connect','Daemon','Binlog Dump') ORDER BY TIME asc;

==SKIPAR ERRO DE REPLICAÇÃO==
set global sql_slave_skip_counter =1; start slave; 
 skipar somente os erros 1032 - Can't find record - ele quer apagar um arquivo que ja não existe no banco 
1062 e 1061 é entrada duplicada -  ele quer adicionar uma informação que ja existe


==encontrar parametros do mysql==
show variables like "% testo aqui %";


==SELECIONAR TODOS OS PROCESSOS DE UM USER E ADICIONAR O COMANDO KILL==
select GROUP_CONCAT(stat SEPARATOR ' ') from (select concat('KILL ',id,';') as stat from information_schema.processlist where command = 'query' and user = 'nome do usuario aqui' and time > 0) as stats;


==VERIFICAR O PROCESSO PELO ID==
select * from information_schema.processlist where id like 28015724\G;


==VERIFICAR A EXISTÊNCIA DE LOCKS==

SELECT trx.trx_id, trx.trx_started, trx.trx_weight, trx.trx_rows_modified, trx.trx_rows_locked, trx.trx_mysql_thread_id FROM information_schema.innodb_trx trx JOIN information_schema.processlist ps ON trx.trx_mysql_thread_id = ps.id WHERE trx.trx_started < CURRENT_TIMESTAMP - INTERVAL 1 SECOND AND ps.user != 'system_user';

SELECT
 r.trx_id waiting_trx_id,
 r.trx_mysql_thread_id waiting_thread,
 r.trx_query waiting_query,
 b.trx_id blocking_trx_id,
 b.trx_mysql_thread_id blocking_thread,
 b.trx_query blocking_query
FROM      performance_schema.data_lock_waits w
INNER JOIN information_schema.innodb_trx b
 ON b.trx_id = w.blocking_engine_transaction_id
INNER JOIN information_schema.innodb_trx r
 ON r.trx_id = w.requesting_engine_transaction_id;


== UPTIME DO MYSQL == validar alerta de sem informações sobre disponibilidade
select TIME_FORMAT(SEC_TO_TIME(VARIABLE_VALUE ),'%Hh %im')  as Uptime  from information_schema.GLOBAL_STATUS  where VARIABLE_NAME='Uptime';


==VER PROCESSOS DE USUARIO ESPECIFICO==
SELECT Id, User, Host, DB, Command, Time, State, LEFT(Info,10000) FROM information_schema.processlist WHERE user ='sdoperp0';


==VERIFICAR TAMANHO TOTAL DOS DIRETORIO==
du -h --max-depth=1 


==CRIAR UM USUÁRIO==
create user <'usuário'@'%'> IDENTIFIED BY 'senha'; A senha deve ter entre 8 a 12 digitos com números e letras maiúsculas e minúsculas.
% = vai conseguir acessar o banco de qualquer maquina, se tiver o ip, irá acessar apenas do ip determinado.
 exemplo: create user 'felipe.matos'@'%' IDENTIFIED BY 'Hu4s3ym2T&aa';

Unilever e Food
grant SELECT, SHOW VIEW, TRIGGER, EVENT on unilever_site.* to 'felipe.matos'@'%';
grant SELECT, SHOW VIEW, TRIGGER, EVENT on unilever_hub.* to 'felipe.matos'@'%';

Middleware
grant SELECT, SHOW VIEW, TRIGGER, EVENT on middlewareb2b.* to 'felipe.matos'@'%';
==DAR PERMISSÕES AO USUÁRIO==
grant <permissões> on . to '<usuário>'@'%';

exemplo permissão de select:
Unilever e Food
grant SELECT, SHOW VIEW, TRIGGER, EVENT on unilever_site.* to 'felipe.matos'@'%';
grant SELECT, SHOW VIEW, TRIGGER, EVENT on unilever_hub.* to 'felipe.matos'@'%';

Middleware
grant SELECT, SHOW VIEW, TRIGGER, EVENT on middlewareb2b.* to 'felipe.matos'@'%';

INFORMAÇÕES
. = base.tabela
Só pode atualizar apenas um database por vez, junto com suas tabelas, ou seja, deverá digitar quantas vezes for necessário, caso tiver mais de um database.
Todas as grants
SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE.

==Alterar senha==
SET PASSWORD FOR '<usuário>'@'%' = PASSWORD('<senha>');

==RETIRAR PERMISSÃO EM TABELA==
revoke <permissão, permissão...> on <base>.<tabela> from '<usuário>'@'%';

==VERIFICAR PERMISSÕES==
show grants for debezium;

==ATUALIZAR AS PERMISSÕES DOS USUÁRIOS==
flush privileges;

==Dar permissões para procedure==
GRANT EXECUTE ON PROCEDURE banco.procedure TO '<usuario>'@'%'

exemplo:
mysql> create user 'rodrigo.brito'@'%' IDENTIFIED BY 'I7y7DaX7jE*a';
Query OK, 0 rows affected (0.01 sec)

mysql> grant CREATE, DROP, ALTER, SELECT, INSERT, UPDATE, DELETE  on . to 'rodrigo.brito'@'%';
Query OK, 0 rows affected (0.00 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)


==Conceder permissão em uma função==
GRANT EXECUTE ON FUNCTION <função> TO '<usuário>'@'%';

==Verificar permissão em tabela==
SELECT user, host from mysql.tables_priv WHERE table_name ='login';

---- Neo4j

Bizuário | Neo4J | Gestão de Usuário


Gestão de Usuários no Neo4J (criação, adicionar/remover grants, remoção, verificação de grants)


Create a user -> Para criar um usuário, você pode usar o comando CREATE USER seguido do nome de usuário e senha. Por exemplo:
  
  CREATE USER teste SET PASSWORD 'secretpassword' CHANGE NOT REQUIRED;

Este comando cria um usuário chamado "teste" com a senha fornecida.


Conceder ou revogar funções ->  as funções podem ser usadas para gerenciar os privilégios do usuário. O Neo4j vem com funções integradas como administrador, editor, editor, etc. Para conceder uma função a um usuário, você pode usar o comando GRANT ROLE. Por exemplo:

   GRANT ROLE editor TO teste;
   
Este comando concede a função de editor ao usuário "teste".
   
Ao iniciar um DBMS Neo4j pela primeira vez, há várias funções integradas:

Public - uma função concedida a todos os usuários. Por padrão, dá acesso ao banco de dados inicial e para executar privilégios para procedimentos e funções.

Reader  - pode executar operações de passagem e leitura em todos os bancos de dados, exceto sistema.

Editor - pode executar operações de passagem, leitura e gravação em todos os bancos de dados, exceto no sistema, mas não pode criar novos rótulos ou tipos de relacionamento.

Publisher - pode fazer o mesmo que editor, mas também criar novos rótulos e tipos de relacionamento.

Architect - pode fazer o mesmo que o editor, além de criar e gerenciar índices e restrições.

Admin - pode fazer o mesmo que todos os itens acima, bem como gerenciar bancos de dados, aliases, usuários, funções e privilégios.


Gerenciar privilégios -> Os privilégios controlam os direitos de acesso aos elementos do gráfico no Neo4j. Você pode conceder ou negar acesso usando os comandos GRANT, DENY e REVOKE. Por exemplo:

   GRANT READ ON * TO teste;
   DENY WRITE ON (node:Label) TO teste;
   REVOKE READ ON (node:Label) FROM teste;
   
O primeiro comando concede acesso de leitura a todos os elementos do gráfico para o usuário "teste". O segundo comando nega o acesso de gravação aos nós com o rótulo "Label". O terceiro comando revoga o acesso de leitura em nós com o rótulo "Label" do usuário "teste".


Remover um usuário -> Para remover um usuário, você pode usar o comando DROP USER seguido do nome de usuário. Por exemplo:

   DROP USER teste;

Este comando remove o usuário "teste" do banco de dados do sistema.

---- Neo4J Alerta de ControlM

Neo4J ControlM Alerta como resolver

sudo su
cd ..
su -ctmag
cd /opt/controlm/EN
./setup.sh
exit

---- Neo4J

Bizuário | Neo4J | Gestão de Usuário


Gestão de Usuários no Neo4J (criação, adicionar/remover grants, remoção, verificação de grants)


Create a user -> Para criar um usuário, você pode usar o comando CREATE USER seguido do nome de usuário e senha. Por exemplo:
  
  CREATE USER teste SET PASSWORD 'secretpassword' CHANGE NOT REQUIRED SET STATUS ACTIVE ;

Este comando cria um usuário chamado "teste" com a senha fornecida.


Conceder ou revogar funções ->  as funções podem ser usadas para gerenciar os privilégios do usuário. O Neo4j vem com funções integradas como administrador, editor, editor, etc. Para conceder uma função a um usuário, você pode usar o comando GRANT ROLE. Por exemplo:

   GRANT ROLE editor TO teste;
   
Este comando concede a função de editor ao usuário "teste".
   
Ao iniciar um DBMS Neo4j pela primeira vez, há várias funções integradas:

Public - uma função concedida a todos os usuários. Por padrão, dá acesso ao banco de dados inicial e para executar privilégios para procedimentos e funções.

Reader  - pode executar operações de passagem e leitura em todos os bancos de dados, exceto sistema.

Editor - pode executar operações de passagem, leitura e gravação em todos os bancos de dados, exceto no sistema, mas não pode criar novos rótulos ou tipos de relacionamento.

Publisher - pode fazer o mesmo que editor, mas também criar novos rótulos e tipos de relacionamento.

Architect - pode fazer o mesmo que o editor, além de criar e gerenciar índices e restrições.

Admin - pode fazer o mesmo que todos os itens acima, bem como gerenciar bancos de dados, aliases, usuários, funções e privilégios.

Para remover a ROLE

REVOKE ROLE editor FROM teste;

Remover um usuário -> Para remover um usuário, você pode usar o comando DROP USER seguido do nome de usuário. Por exemplo:

   DROP USER teste;

Este comando remove o usuário "teste" do banco de dados do sistema.


Para verificar os privilégios de um usuário específico: Você também pode verificar os privilégios de um usuário específico usando o comando SHOW USER <usuário> PRIVILEGES AS COMMANDS. Por exemplo, para verificar os privilégios do usuário Teste, você pode executar o seguinte comando:

SHOW USER teste PRIVILEGES AS COMMANDS;

Lista todos os usuarios

SHOW USERS

Para criar e deixar ativo 

CREATE USER jake
SET PLAINTEXT PASSWORD 'abcd1234'
SET STATUS ACTIVE;

PARA DEIXAR ATIVO
SET STATUS ACTIVE FOR USER jake


---- Neo4J Up Time

Up Time Neo4J


call dbms.queryJmx("java.lang:type=Runtime") 
yield attributes 
return attributes.Uptime