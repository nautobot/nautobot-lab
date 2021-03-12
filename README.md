# Nautobot Lab

> This container is **not** for production use!

`Nautobot Lab` is an all-in-one Docker container that allows a user to quickly get an instance of Nautobot up and running with minimal effort.

This image is for the purposes of "kicking the tires" of Nautobot. Utilize `nautobot-lab` to quickly see if Nautobot is right for you and your organization.

It bears repeating, `nautobot-lab` is **NOT a ready for production container**. If you wish to use Nautobot in production, please refer to the [Nautobot documentation](https://nautobot.readthedocs.io/en/latest/installation/).

## Running from Docker Hub

Building the container yourself isn't needed to get up and running quickly. The image is hosted on Docker Hub for public consumption, and you can download and start it with a single command.

By default, the `naubotbot-lab` Docker container populates Nautobot with a Super User account.

The user credentials are:

* Username: `demo`
* Password: `nautobot`

View the [Creating a Super User section](#Creating-a-Super-User) to create a Super User.

```shell
docker run -itd --name nautobot -p 8000:8000 networktocode/nautobot-lab
```

Because this image is an all-in-one container (with Nautobot, PostgreSQL, and Redis), it will take a few seconds to download the container, and then about 30 seconds more for all of the services to start and stabilize. Once the container has started and all services have stabilized, the web interface can be accessed via `http://localhost:8000`.

If you wish, you can also check the health status of the container by running the following command:

```shell
docker ps | grep nautobot
```

You are waiting for the container to be in a `healthy` state as shown below.

```text
99c9312e0409   networktocode/nautobot-lab     "/usr/local/bin/supe…"   3 minutes ago   Up 3 minutes (healthy)   0.0.0.0:8000->8000/tcp, :::8000->8000/tcp
```

## Building the container

The container can be built locally, if preferred.

1.  Clone the repository.

    ```shell
    git clone https://github.com/nautobot/nautobot-lab.git
    ```

2.  Enter the `nautobot-lab` directory.
3.  Build the image.

    ```shell
    docker build -t nautobot-lab:latest .
    ```

### Running the container from a local build

```shell
docker run -itd --name nautobot -p 8000:8000 nautobot-lab
```

## Creating a Super User

Once the container has started and all the services have stabilized, you will need to create a Super User account to start exploring Nautobot. The `nautobot-server createsuperuser` command will prompt you for a username, email address, and password. The email address is unused in this particular workflow and can be left blank.

```shell
% docker exec -it nautobot nautobot-server createsuperuser
Username (leave blank to use 'root'): ntc
Email address: info@networktocode.com
Password:
Password (again):
Superuser created successfully.
```

## Kick the Tires

At this point, Nautobot can be accessed at `http://localhost:8000` with the user credentials that were created.

Explore, test, create, destroy, do whatever you like in this lab instance of Nautobot.

We assume that you will want to populate Nautobot Lab with data from your own environment. However, if you want to simply get it up and running with minimal effort, we provide a set of sandbox data. To load the sandbox data, execute:

`docker exec -it nautobot load-mock-data`

If you have any questions, don't hesitate to reach out in the #Nautobot channel on the [Network To Code Slack instance](https://networktocode.slack.com), we'll be happy to assist you!

If you're not a member, you can join the Slack instance [here](http://slack.networktocode.com/).

![Nautobot](nautobot.png)
