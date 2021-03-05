# Nautobot Lab

`Nautobot Lab` is an all-in-one docker container that allows a user to quickly get an instance of nautobot up and running with minimal effort, for the purposes of kicking the tires.

## Building the container
```
docker build -t nautobot-lab:latest .
```

## Running the container
It will take a few seconds for all the services to start up and stabalize in the container. Once the services start, the web interface can be accessed via `http://localhost:8000`.
```
docker run -itd --name nautobot -p 8000:8000 nautobot-lab
```

## Creating a Super User
Once the container has started and all the services have stabalized. A super user account will need to be created to start kicking the tires with what is available in Nautobot. The `createsuperuser` command will prompt you for a username, email address, and password. 
```
% docker exec -it nautobot /opt/nautobot/venv/bin/nautobot-server createsuperuser
Username (leave blank to use 'root'): ntc
Email address: info@networktocode.com
Password:
Password (again):
Superuser created successfully.
```

### Kick the Tires
At this point, Nautobot can be accessed at `http://localhost:8000` with the user credentials that were created.
![Nautobot](nautobot.png)
