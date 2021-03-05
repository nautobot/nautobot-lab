# Nautobot Lab

`Nautobot Lab` is an all-in-one docker container that allows a user to quickly get an instance of Nautobot up and running with minimal effort, for the purposes of kicking the tires. With that said; `nautobot-lab` is **NOT** a ready for production container image.

## Running from Docker Hub
Building the container isn't needed to get up and running quickly. The image is hosted on Docker Hub for public consumption. Since the image is an all-in-on container, it will take a a few seconds for all of the services to start and stabalize. Once the container has started and all services have stabalized, the web interface can be accessed via `http://localhost:8000`.
```
docker run -itd --name nautobot -p 8000:8000 networktocode/nautobot-lab
```

## Building the container
The container can be built locally, if preferred.

1. Clone the repository.
```
git clone https://github.com/nautobot/nautobot-lab.git
```
2. Enter the `nautobot-lab` directory.
3. Build the image.
```
docker build -t nautobot-lab:latest .
```

### Running the container from a local build

```
docker run -itd --name nautobot -p 8000:8000 nautobot-lab
```

## Creating a Super User
Once the container has started and all the services have stabalized. A super user account will need to be created to start kicking the tires with what is available in Nautobot. The `createsuperuser` command will prompt you for a username, email address, and password. 
```
% docker exec -it nautobot nautobot-server createsuperuser
Username (leave blank to use 'root'): ntc
Email address: info@networktocode.com
Password:
Password (again):
Superuser created successfully.
```

## Kick the Tires
At this point, Nautobot can be accessed at `http://localhost:8000` with the user credentials that were created.
![Nautobot](nautobot.png)
