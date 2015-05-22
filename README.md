
Emulab Scripts
==============

Contains several scripts which are used to deploy and run Cassandra on an Emulab cluster. 

Scripts
-------

### Remote Excecute

```
$ ./exec_remote.sh -f script.sh -h hosts_file [-p]
```

`exec_remote` executes a script remotely on all of the hosts which are specified in `hosts_file`. Besides it can be done in parallel with `-p` option.

For example, do "hello world" on all the hosts. 

```
$ ./exec_remote.sh -f ./scripts/info.sh -h hosts 
```

`scripts` dir contains several scripts that are used at remote hosts.

- `info.sh` just prints "hello world".
- `init.sh` installs java and create work dir (`/public/${node-id}/`) at every remote host. 
- `deploy.sh` decompresses the cassandra tar file, which has been copied to all hosts previously, and injects configuration. 
- `start.sh` starts Cassandra on remote hosts. 
- `create_keyspace.sh` creates lots of keyspaces on Cassandra cluster, usually through seed node. 
- `stop.sh` kills Cassandra daemon on remote hosts. 

The hosts file has the format like, 

```
22 node-1.CA-6127.ucare.emulab.net
22 node-10.CA-6127.ucare.emulab.net
22 node-11.CA-6127.ucare.emulab.net
22 node-12.CA-6127.ucare.emulab.net
22 node-13.CA-6127.ucare.emulab.net
22 node-14.CA-6127.ucare.emulab.net
```

where the first column is ssh port (for compatibility when using virtual nodes), and the second is host name. 


### Copy to Remote

We still need a script that copies Cassandra tar file to every host. 

```
$ ./copy_remote.sh -s SRC -h hosts_file
```

The script hard coded the target dir as `/public/${node-id}/`. 


Work Flow
=========

Here's a typical work flow that runs a Cassandra cluster using these scripts. 

Create Host File
----------------

Beside, we may need other host files like seeds and non_seeds when seed nodes are supposed to start first, and then the non-seed nodes. Like, 

all host file, 

```
22 node-1.CA-6127.ucare.emulab.net
22 node-10.CA-6127.ucare.emulab.net
22 node-11.CA-6127.ucare.emulab.net
22 node-12.CA-6127.ucare.emulab.net
22 node-13.CA-6127.ucare.emulab.net
22 node-14.CA-6127.ucare.emulab.net
```

seed file, 

```
22 node-1.CA-6127.ucare.emulab.net
```

non-seed file, 

```
22 node-10.CA-6127.ucare.emulab.net
22 node-11.CA-6127.ucare.emulab.net
22 node-12.CA-6127.ucare.emulab.net
22 node-13.CA-6127.ucare.emulab.net
22 node-14.CA-6127.ucare.emulab.net
```

Test Connection
---------------

This could be done by, 

```
$ ./exec_remote.sh -f ./scripts/info.sh -h hosts 
```

Init Environment
----------------

Install packages, create directories, and etc. It would be better using `-p` parallel option. 

```
$ ./exec_remote.sh -f ./scripts/init.sh -h hosts -p 
```

Dispatch Tar File
-----------------

```
$ ./copt_remote.sh -s cassandra.tgz -h hosts
```

Deploy
------

Decompress tar file and inject configuration. 

```
$ ./exec_remote.sh -f ./scripts/deploy.sh -h hosts -p 
```

Run Seed Node
-------------

```
$ ./exec_remote.sh -f ./scripts/start.sh -h seeds 
```

Create Keyspaces
----------------

```
$ ./exec_remote.sh -f ./scripts/create_keyspace.sh -h seeds 
```

Start Non-seed Nodes
--------------------

Start all other nodes **simultanously**. 

```
$ ./exec_remote.sh -f ./scripts/start.sh -h non_seeds -p 
```

