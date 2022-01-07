# Nautobot Lab

> This container is **not** for production use!

`Nautobot Lab` is an all-in-one Docker container that allows a user to quickly get an instance of Nautobot up and running with minimal effort.

This image is for the purposes of "kicking the tires" of Nautobot. Utilize `nautobot-lab` to quickly see if Nautobot is right for you and your organization.

It bears repeating, `nautobot-lab` is **NOT a ready for production container**. If you wish to use Nautobot in production, please refer to the [Nautobot documentation](https://nautobot.readthedocs.io/en/latest/installation/).

## Running from Docker Hub

Building the container yourself isn't needed to get up and running quickly. The image is hosted on Docker Hub for public consumption, and you can download and start it with a single command.

```shell
docker run -itd --name nautobot -p 8000:8000 networktocode/nautobot-lab
```

> If you've previously run `nautobot-lab` in the past, you may wish to first invoke `docker pull networktocode/nautobot-lab` to ensure that you have the latest version of this image!

Because this image is an all-in-one container (with Nautobot, PostgreSQL, and Redis), it will take a few seconds to download the container, and then about 30 seconds more for all of the services to start and stabilize. Once the container has started and all services have stabilized, the web interface can be accessed via `http://localhost:8000`.

If you wish, you can also check the health status of the container by running the following command:

```shell
docker ps | grep nautobot
```

You are waiting for the container to be in a `healthy` state as shown below.

```text
99c9312e0409   networktocode/nautobot-lab     "/usr/local/bin/supe…"   3 minutes ago   Up 3 minutes (healthy)   0.0.0.0:8000->8000/tcp, :::8000->8000/tcp
```

Once Nautobot Lab is up and running, you will need to [create a Super User as shown in the section below](#Creating-a-Super-User).

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

> Populating the database with sandbox data will destroy any data that you have created and load in the sandbox data. The user credentials for the sandbox data are **username:** *demo* and **password:** *nautobot*.

`docker exec -it nautobot load-mock-data`

## Nautobot Plugins

The following plugins are pre-installed in the Nautobot Lab container:

- `nautobot-device-onboarding`
- `nautobot-circuit-maintenance`
- `nautobot-data-validation-engine`
- `nautobot-capacity-metrics`
- `nautobot-golden-config`
- `nautobot-plugin-nornir`
- `nautobot-netbox-importer`
- `nautobot-chatops`

The plugins are configured in `nautobot_config.py`.

If you want to add more plugins, here are the steps:

1. Edit `pb_nautobot.yml` and add a plugin item in the list:

```yaml
- name: "INSTALL NAUTOBOT PLUGINS"
  ansible.builtin.pip:
    name: "{{ item }}"
    virtualenv: "{{ nautobot_root }}"
    virtualenv_command: "python3 -m venv"
    with_items:
        - "my-plugin"
```

2. Edit `local_requirements.txt` to include the plugin name for persistence.

3. Edit the `nautobot_config.py` and add the plugin to the list of plugins:

```python
PLUGINS = ["my-plugin]
```

4. Add any other plugin configuration parameters in `nautobot_config.py`.

5. Finally, rebuild the container:

```bash
docker build -t nautobot-lab:latest .
```

If you have any questions, don't hesitate to reach out in the #Nautobot channel on the [Network To Code Slack instance](https://networktocode.slack.com), we'll be happy to assist you!

If you're not a member, you can join the Slack instance [here](http://slack.networktocode.com/).

![Nautobot](nautobot.png)
