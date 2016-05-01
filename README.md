# Prison Break (through SSH tunnels)

> If you feel like a prisoner behind proxies and firewalls then this repo is for you.

## Rationale

Whether our internet traffic is monitored in our workplace or even in our country,
what you essentially get is a limited view of the web/world.  
Consequently you are exposed to a subset of information.

From a corporate environment standpoint, this situation is a creativity killer.  
Creativity requires unlimited access to information that will shape your
ideas into unknown, beautiful, forms.  
By being less creative you may become less productive
or you may accomplish your work at a lower standard.
And no entrepreneur wants that. Do they?

We are not monkeys that type code on a keyboard.
We need **unlimited** access to information.

Regardless, we must act!

## The big picture

We setup an SSH tunnel between our PC (client) and a gateway server (an ordinary server)
and utilize our PC as a SOCKS proxy.

```
                Censorship
                  wall
                                                                      WEB
                 +---+
                 |   |                                               XXXXXXXX
                 |   |                                          XXXXX       XXX
                 |   |                                          X             XXXXXXXXX
  Client         |   |                   Server                 XXX                  XX
                 |   |                                            XX              XXX
+--------+       |   |                 +--------+              XXXX              XXX
|        +-------------SSH Tunnel------+        +-------------+X                   XXXX
|        +-----------------------------+        |           XXX                      XX
+--------+       |   |                 +--------+             X                   XXXX
                 |   |                                        XX                   XX
                 |   |                                       XX                  XXX
                 |   |                                       XXXXX              XX
                 |   |                                            XX     XXXXXXXXX
                 |   |                                             XXXXXXX
                 |   |
                 +---+
```

## Dockerize all the things

Wanting the solution presented to be truly cross-platform I couldn't but use [docker](https://www.docker.com/) for the occasion.

The solution is comprised of two parts. The client and the server.

The `server` part assumes that there is already set up and running an `sshd`
and on top of that it just enables us to expose port 22 to another port, such as 8022.  
This addresses the issue when port 22 is blocked in our restrictive environment.

The `client` part is the gist.
It can perform the following:

0. Generate SSH public-private key pairs
0. Establish an SSH tunnel

Both parts (docker containers) are based on, my favorite, `alpine` image and can be managed via `make`.  
A sample `make` usage:

```
$ OPTIONAL_CONFIGURATION_VAR_1=value1 OPTIONAL_CONFIGURATION_VAR_2=value2 make target1 target2 ...targetN
```

I won't expand in detail on the usage; the source code is the ultimate truth.

## Server

Build the image:

```shell
$ make image
```

and then run the container:

```shell
$ make run
```

Or in one line we could just:

```shell
$ make image run
```

After running this container port 22 is also exposed as port 8022.
However, you can configure the alternative port as you see fit.

Note that there is also a script called `config-guide-gen.sh`.
This is a script that generates a brief document, in markdown format,
on how to set-up a user for accepting ssh connections.
It doesn't compare to a configuration management software
but at that time, while I was experimenting, it was really helpful for me (all the way copy-pasting).

For instance if we run it:

```shell
$ CONF_HOST=freedom.example.net CONF_SSH_KEY='~/.ssh/id_rsa.pub' ./config-guide-gen.sh
```

we get an output like this one:

    # Configuration guide

    > view source to see all the available configuration options

    ## Server-side

    ### Create user
    ```
    adduser --disabled-password --gecos "" tunnel
    touch /home/tunnel/.hushlogin
      echo tunnel:AxCKMfkZyPEiybL0 | chpasswd
    ```


    ## Client-side

    ### Copy admin ssh public key
    ```
    ssh-copy-id -i ~/.ssh/id_rsa.pub tunnel@freedom.example.net
    ```


    ## Server-side

    ### Disable user
    ```
    usermod --shell /usr/sbin/nologin -L tunnel
    ```

    ___THE END___

which we can view with our favorite markdown viewer, if preferred.

## Client

Before all else, we must build the image:

```shell
$ make image
```

To generate a new SSH public-private key pair we can:

```shell
$ make keys
```

after which we now have our newly created keys in the ./.ssh directory

```shell
$ pwd
/path/to/prisonbreak-ssh/client

$ tree ./.ssh
./.ssh
├── identity
└── identity.pub

0 directories, 2 files
```

At this point the public key (identity.pub) must be placed in the authorized_keys file on the gateway server.  
For instance, be appended in the `/home/tunnel/.ssh/authorized_keys` file.

After having done all of the above we can finally run the container:

```shell
$ SSH_HOST=freedom.example.net make run
```

which will instantiate a SOCKS proxy listening, by default, on port **1080**.

_Please note that how to configure your browser or any other client software
to use a SOCKS proxy is beyond the scope of this document._

And that is all.  
Happy, free web-ing :)